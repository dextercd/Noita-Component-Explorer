---@module 'component-explorer.style'
local style = dofile_once("mods/component-explorer/style.lua")

---@module 'component-explorer.ui.link'
local link = dofile_once("mods/component-explorer/ui/link.lua")

---@module 'component-explorer.deps.EZWand'
local EZWand = dofile_once("mods/component-explorer/deps/EZWand.lua")

---@module 'component-explorer.utils.strings'
local string_util = dofile_once("mods/component-explorer/utils/strings.lua")

---@module 'component-explorer.utils.wiki'
local wiki = dofile_once("mods/component-explorer/utils/wiki.lua")

---@module 'component-explorer.utils.player_util'
local player_util = dofile_once("mods/component-explorer/utils/player_util.lua")

---@module 'component-explorer.utils.copy'
local copy = dofile_once("mods/component-explorer/utils/copy.lua")

---@module 'component-explorer.preset_wands'
local preset_wands = dofile_once("mods/component-explorer/preset_wands.lua")

---@module 'component-explorer.cursor'
local cursor = dofile_once("mods/component-explorer/cursor.lua")

---@module 'component-explorer.utils.wiki_wand'
local wiki_wand_util = dofile_once("mods/component-explorer/utils/wiki_wand.lua")

dofile_once("data/scripts/gun/procedural/wands.lua")

local wiki_wands = {}
wiki_wands.open = false

local _g_parsed_template = nil

local function error_text(str)
    imgui.PushStyleColor(imgui.Col.Text, unpack(style.colour_fail))
    imgui.Text(str)
    imgui.PopStyleColor()
end

local function show_range(type, field_name, template_values, range_values)
    local item
    for _, v in ipairs(template_values) do
        if v[1] == field_name then
            item = v
            break
        end
    end
    if item == nil then return end

    local text_value = item[2]
    local min, max = wiki_wand_util.field_range_value(text_value)

    if min == max then
        return
    end

    local value = range_values[field_name] or min

    local _
    imgui.SetNextItemWidth(200)
    if type == "f" then
        _, value = imgui.SliderFloat(field_name, value, min, max)
    elseif type == "i" then
        _, value = imgui.SliderInt(field_name, value, min, max)
    end

    range_values[field_name] = value
end

local range_values = {}
local last_wand_card_template = nil

local function confirm_wand_card_import(template_data)
    if last_wand_card_template ~= template_data then
        last_wand_card_template = template_data
        range_values = {}
    end

    for _, field in ipairs(wiki_wand_util.FIELD_RANGES) do
        local type, name = unpack(field)
        show_range(type, name, template_data.values, range_values)
    end

    local create_in_inv = false
    local create_at_pos = false
    local x, y = 0, 0

    local player = player_util.get_player()

    if not player then imgui.BeginDisabled() end

    if imgui.Button("Create at player") then
        assert(player)
        create_at_pos = true
        x, y = EntityGetTransform(player)
    end

    imgui.SameLine()
    if imgui.Button("Put in inventory") then
        create_in_inv = true
    end

    if not player then imgui.EndDisabled() end

    imgui.SameLine()
    if imgui.Button("Create at cursor") then
        create_at_pos = true
        x, y = cursor.pos()
    end

    if not create_in_inv and not create_at_pos then
        return false
    end

    local ammended_data = copy.shallow_copy(template_data)
    ammended_data.values = {}

    -- Apply ranges and other fixups
    for _, item_ in ipairs(template_data.values) do
        local item = copy.shallow_copy(item_)
        local name = item[1]

        if wiki_wand_util.SUPPORTS_FIELD_RANGE[name] then
            if range_values[name] then
                item[2] = range_values[name]
            elseif name == "speed" then
                item[2] = wiki_wand_util.field_range_value(item[2])
            end
        end

        table.insert(ammended_data.values, item)
    end

    local wand

    if create_in_inv or create_at_pos then
        wand = EZWand()
        wand:UpdateSprite()
        wiki_wand_util.load_data_to_wand(wand, ammended_data)
    end

    if create_in_inv then
        local success = pcall(function()
            wand:PutInPlayersInventory()
        end)

        if success then
            return true
        end

        -- Couldn't put in inventory.. maybe the inventory is full or the player
        -- is polymorphed.. Fall back to placing it at the player's position.
        assert(player)
        create_at_pos = true
        x, y = EntityGetTransform(player)
    end

    if create_at_pos then
        wand:PlaceAt(x, y)
        return true
    end
end

local function confirm_wand_import(template_data)
    local wand

    local currently_held = EZWand.GetHeldWand()
    if not currently_held then imgui.BeginDisabled() end
    if imgui.Button("Place in current wand") then
        wand = currently_held
    end
    if not currently_held then imgui.EndDisabled() end

    for _, preset in ipairs(preset_wands) do
        imgui.SameLine()
        if imgui.Button("New " .. preset.name) then
            local px, py = 0, 0
            local player = player_util.get_player()
            if player then
                px, py = EntityGetTransform(player)
            end
            wand = EZWand(preset.data)
            wand:UpdateSprite()
            wand:PlaceAt(px, py)
        end
    end

    if wand then
        wiki_wand_util.load_data_to_wand(wand, template_data)
        return true
    end
end

local import_text = ""
local import_last_error = ""

local function import_menu()
    if imgui.Button("Clear") then
        import_text = ""
    end

    local template_changed
    template_changed, import_text = imgui.InputTextMultiline("##Import", import_text, -1, 0)

    if string_util.trim(import_text) == "" then
        return
    end

    if template_changed then
        _g_parsed_template = nil
        parse_success, parse_result = pcall(wiki.parse_template, import_text)
        if not parse_success then
            import_last_error = parse_result
            return
        end

        import_last_error = ""
        _g_parsed_template = parse_result
    end

    if _g_parsed_template then
        local success, result = pcall(function()
            local confirm_function
            if _g_parsed_template.template_name == "Wand Card" then
                confirm_function = confirm_wand_card_import
            elseif _g_parsed_template.template_name == "Wand" then
                confirm_function = confirm_wand_import
            else
                error_text("Unknown template: '" .. _g_parsed_template.template_name .. "'")
                return
            end

            if confirm_function(_g_parsed_template) then
                import_last_error = ""
                import_text = ""
            end
        end)

        if not success then
            import_last_error = result
        end
    end

    if import_last_error ~= "" then
        if type(import_last_error) == "table" and import_last_error.error then
            error_text(import_last_error.error)
        else
            error_text(tostring(import_last_error))
        end
    end
end


local function needs_wand()
    imgui.PushStyleColor(imgui.Col.Text, unpack(style.colour_warn))
    imgui.Text("No wand currently held")
    imgui.PopStyleColor()
end

local function wiki_wands_contents()
    local wand = EZWand.GetHeldWand()

    if not imgui.BeginTabBar("wiki_wand_tabs") then
        return
    end

    if imgui.BeginTabItem("Wand") then
        if not wand then
            needs_wand()
        else
            local wand_text = wiki_wand_util.wand_to_wiki_text(wand, false)
            if imgui.Button("Copy") then
                imgui.SetClipboardText(wand_text)
            end

            imgui.Text(wand_text)
        end
        imgui.EndTabItem()
    end

    if imgui.BeginTabItem("Wand Card") then
        if not wand then
            needs_wand()
        else
            local wand_text = wiki_wand_util.wand_to_wiki_text(wand, true)
            if imgui.Button("Copy") then
                imgui.SetClipboardText(wand_text)
            end

            imgui.Text(wand_text)
        end
        imgui.EndTabItem()
    end

    if imgui.BeginTabItem("Import") then
        import_menu()
        imgui.EndTabItem()
    end

    if imgui.BeginTabItem("About") then
        imgui.TextWrapped(table.concat({
            "The Noita wiki (noita.wiki.gg) could use more inspiring wand builds and demo GIF's!\n",
            "Noita includes a built-in GIF recorder and this mod should make it easier to use the wand templates on the wiki.",
            "\n\n",
            "In most cases the spells are the most important thing and the exact wand stats aren't that important, ",
            "so you should prefer the 'Wand' template over the 'Wand Card' template usually.",
            "\n\n",
            "If you need help with something, you can visit the #noita-wiki channel in the Noita Discord server.",
            "\n\n",
            "To easily copy wands off of the Noita wiki, you can add the following line to your personal common.js file:",
        }))

        local cjs_line = "importScript('User:DexterCD/wandCopy.js');"
        imgui.BeginDisabled()
        imgui.InputText("##cjs", cjs_line)
        imgui.EndDisabled()
        imgui.SameLine()
        if imgui.Button("Copy") then
            imgui.SetClipboardText(cjs_line)
        end
        link.button("Open Common.js", "https://noita.wiki.gg/wiki/Special:MyPage/common.js")

        imgui.EndTabItem()
    end

    imgui.EndTabBar()
end

function wiki_wands.show()
    local should_show
    should_show, wiki_wands.open = imgui.Begin("Wiki Wands", wiki_wands.open)

    if not should_show then
        return
    end

    wiki_wands_contents()

    imgui.End()
end

return wiki_wands

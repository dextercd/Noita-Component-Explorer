local style = dofile_once("mods/component-explorer/style.lua")
local EZWand = dofile_once("mods/component-explorer/deps/EZWand.lua")
local string_util = dofile_once("mods/component-explorer/utils/strings.lua")
local wiki_spell_names = dofile_once("mods/component-explorer/utils/wiki_spell_names.lua")
local wiki = dofile_once("mods/component-explorer/utils/wiki.lua")
local wand_sprites = dofile_once("mods/component-explorer/wand_sprites.lua")
dofile_once("mods/component-explorer/utils/copy.lua")

dofile_once("data/scripts/gun/procedural/wands.lua")

local preset_wands = dofile_once("mods/component-explorer/preset_wands.lua")

local _g_parsed_template = nil

local function error_text(str)
    imgui.PushStyleColor(imgui.Col.Text, unpack(style.colour_fail))
    imgui.Text(str)
    imgui.PopStyleColor()
end

local function get_wand_values(wand, wand_card)
    local values = {}
    local sprite_file = wand:GetSprite()
    local wiki_file_name = wand_sprites.to_wiki_name(sprite_file)

    if wand_card then
        table.insert(values, {"wandName", "My Wand"})
    end

    if wiki_file_name then
        table.insert(values, {"wandPic", wiki_file_name})
    end

    if wand.shuffle then
        table.insert(values, {"shuffle", "Yes"})
    end

    if wand.spellsPerCast ~= 1 then
        table.insert(values, {"spellsCast", wand.spellsPerCast})
    end

    if wand_card then
        table.insert(values, {"castDelay", ("%.2f"):format(wand.castDelay / 60)})
        table.insert(values, {"rechargeTime", ("%.2f"):format(wand.rechargeTime / 60)})
        table.insert(values, {"manaMax", ("%.2f"):format(wand.manaMax)})
        table.insert(values, {"manaCharge", ("%.2f"):format(wand.manaChargeSpeed)})
    end

    local spells, attached_spells = wand:GetSpells()

    if wand_card then
        table.insert(values, {"capacity", wand.capacity})
    else
        table.insert(values, {"capacity", #spells})
    end

    if wand_card then
        table.insert(values, {"spread", wand.spread})
        table.insert(values, {"speed", ("%.2f"):format(wand.speedMultiplier)})
    end

    for _, spell in ipairs(attached_spells) do
        local wiki_name = wiki_spell_names.by_action_id[spell.action_id]
        table.insert(values, {"alwaysCasts", wiki_name})
    end

    local spell_nr = 1
    for _, spell in ipairs(spells) do
        local wiki_name = wiki_spell_names.by_action_id[spell.action_id]
        table.insert(values, {"spell" .. spell_nr, wiki_name})
        spell_nr = spell_nr + 1
    end

    return values
end

local function wand_get_wiki_text(wand, wand_card)
    local wand_values = get_wand_values(wand, wand_card)

    if wand_card then
        return wiki.format_template("Wand Card", wand_values, 12)
    else
        return wiki.format_template("Wand", wand_values, 11)
    end
end

local function set_sprite_by_filename(wand, filename)
    local data = wand_sprites.from_wiki_name(filename)
    if data == nil then return false end

    wand:SetSprite(
        data.sprite_file or data.image_file,
        data.offset_x, data.offset_y,
        data.tip_x, data.tip_y)

    return true
end

local function write_wand_template(wand, template_data)
    map = {}
    for _, v in ipairs(template_data.values) do
        map[v[1]] = v[2]
    end

    set_sprite_by_filename(wand, map.wandPic)

    wand.shuffle = map.shuffle == "true"
    wand.spellsPerCast = map.spellsCast and tonumber(map.spellsCast) or 1

    if map.castDelay then
        wand.castDelay = tonumber(map.castDelay) * 60
    end

    if map.rechargeTime then
        wand.rechargeTime = tonumber(map.rechargeTime) * 60
    end

    if map.manaMax then
        wand.manaMax = tonumber(map.manaMax)
    end

    if map.manaCharge then
        wand.manaChargeSpeed = tonumber(map.manaCharge)
    end

    wand.capacity = tonumber(map.capacity)

    if map.spread then
        wand.spread = tonumber(map.spread)
    end

    if map.speed then
        wand.speedMultiplier = tonumber(map.speed)
    end

    wand:DetachSpells()
    for _, item in ipairs(template_data.values) do
        if item[1] == "alwaysCasts" then
            local action_id = wiki_spell_names.to_action_id(item[2])
            wand:AttachSpells(action_id)
        end
    end

    wand:RemoveSpells()
    for spell_nr=1, tonumber(map.capacity) do
        local spell_name = map["spell" .. spell_nr]
        if spell_name ~= nil then
            local action_id = wiki_spell_names.to_action_id(spell_name)
            wand:AddSpells(action_id)
        end
    end
end

local FIELD_RANGES = {
    {"i", "spellsCast"},
    {"f", "castDelay"},
    {"f", "rechargeTime"},
    {"i", "manaMax"},
    {"i", "manaCharge"},
    {"i", "capacity"},
    {"f", "spread"},
    {"f", "speed"},
}

local function show_range(type, field_name, template_values, range_values)
    local item
    for idx, v in ipairs(template_values) do
        if v[1] == field_name then
            item = v
            break
        end
    end
    if item == nil then return end

    local text_value = item[2]
    text_value = string_util.remove_prefix(text_value, "x ") -- speed = x 1.25

    if text_value:sub(1, 1) ~= "(" then return end

    local min, max
    local success, err = pcall(function()

        -- Value could be something like:
        -- (-3.0 - -1.0)
        local dash_pos = text_value:find("-", 3, true)
        min = tonumber(text_value:sub(2, dash_pos - 1))
        max = tonumber(text_value:sub(dash_pos + 1, #text_value - 1))

        if min == nil or max == nil then
            error({error="Range extents for '" .. field_name .. "' not a number?"})
        end
    end)
    if not success then
        error({error="Error number range for argument '" .. field_name .. "'"})
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

    for _, field in ipairs(FIELD_RANGES) do
        local type, name = unpack(field)
        show_range(type, name, template_data.values, range_values)
    end

    local ammended_data = shallow_copy(template_data)
    ammended_data.values = {}

    -- Apply ranges and other fixups
    for _, item_ in ipairs(template_data.values) do
        local item = shallow_copy(item_)
        local name = item[1]
        if range_values[name] ~= nil then
            item[2] = range_values[name]
        elseif name == "speed" then
            item[2] = string_util.remove_prefix(item[2], "x ")
        end

        table.insert(ammended_data.values, item)
    end

    if imgui.Button("Create") then
        local player = EntityGetWithTag("player_unit")[1]
        local px, py = EntityGetTransform(player)
        wand = EZWand()
        wand:UpdateSprite()
        wand:PlaceAt(px, py)
        write_wand_template(wand, ammended_data)
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
            local player = EntityGetWithTag("player_unit")[1]
            local px, py = EntityGetTransform(player)
            wand = EZWand(preset.data)
            wand:UpdateSprite()
            wand:PlaceAt(px, py)
        end
    end

    if wand then
        write_wand_template(wand, template_data)
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
            end
        end)

        if not success then
            import_last_error = result
        end
    end

    if import_last_error ~= "" then
        if type(import_last_error) == "table" then
            if type(import_last_error.error) == "string" then
                error_text(import_last_error.error)
            end
        else
            error_text(import_last_error)
        end
    end
end

window_open_wiki_wands = false

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
            local wand_text = wand_get_wiki_text(wand, false)
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
            local wand_text = wand_get_wiki_text(wand, true)
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
            "If you need help with something, you can visit the #noita-wiki channel in the Noita Discord server."
        }))
        imgui.EndTabItem()
    end

    imgui.EndTabBar()
end

function show_wiki_wands()
    local should_show
    should_show, window_open_wiki_wands = imgui.Begin("Wiki Wands", window_open_wiki_wands)

    if not should_show then
        return
    end

    wiki_wands_contents()

    imgui.End()
end

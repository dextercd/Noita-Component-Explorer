---@module 'component-explorer.utils.strings'
local string_util = dofile_once("mods/component-explorer/utils/strings.lua")

---@module 'component-explorer.ui.ui_combo'
local ui_combo = dofile_once("mods/component-explorer/ui/ui_combo.lua")

---@module 'component-explorer.utils.player_util'
local player_util = dofile_once("mods/component-explorer/utils/player_util.lua")

---@module 'component-explorer.spawn_data.perks'
local perk_list = dofile_once("mods/component-explorer/spawn_data/perks.lua")

local function get_unique_attrs(attr)
    local set = {}
    for _, perk in ipairs(perk_list) do
        set[perk[attr]] = true
    end

    local ret = {}
    for item, _ in pairs(set) do
        table.insert(ret, item)
    end

    table.sort(ret)
    return ret
end
local unique_origins = get_unique_attrs("origin")


local filter_search = ""
---@type string?
local filter_origin = nil

return function()
    local _

    imgui.SetNextItemWidth(200)
    _, filter_search = imgui.InputText("Search", filter_search)

    if #unique_origins > 1 then
        imgui.SameLine()
        imgui.SetNextItemWidth(150)
        _, filter_origin = ui_combo.optional("Origin", unique_origins, filter_origin)
    end

    local filtered_perks
    if filter_search == "" and filter_origin == nil then
        filtered_perks = perk_list
    else
        filtered_perks = {}
        for _, perk in ipairs(perk_list) do
            if
                (filter_search == "" or (
                    string_util.ifind(perk.id, filter_search, 1, true) or
                    string_util.ifind(perk.display_name, filter_search, 1, true) or
                    string_util.ifind(perk.display_description, filter_search, 1, true)
                ))
                and (filter_origin == nil or perk.origin == filter_origin)
            then
                table.insert(filtered_perks, perk)
            end
        end
    end

    if not imgui.BeginChild("table") then return end

    local column_count = 4

    local has_image_support = imgui.LoadImage ~= nil
    if has_image_support then
        column_count = column_count + 1
    end

    local flags = bit.bor(
        imgui.TableFlags.Resizable,
        imgui.TableFlags.Hideable,
        imgui.TableFlags.RowBg
    )

    if imgui.BeginTable("perks", column_count, flags) then
        if has_image_support then
            imgui.TableSetupColumn("img", imgui.TableColumnFlags.WidthFixed)
        end
        imgui.TableSetupColumn("Name")
        imgui.TableSetupColumn("ID")
        imgui.TableSetupColumn("Origin", imgui.TableColumnFlags.WidthFixed)
        imgui.TableSetupColumn("Spawn", imgui.TableColumnFlags.WidthFixed)
        imgui.TableHeadersRow()

        if has_image_support then
            local image_paths = {}
            for _, p in ipairs(perk_list) do
                if p.perk_icon then
                    table.insert(image_paths, p.perk_icon)
                end
            end
            -- Files are placed alphabetically in the data.wak, loading them in
            -- that order is much faster.
            table.sort(image_paths)
            for _, path in ipairs(image_paths) do
                imgui.LoadImage(path)
            end
        end

        local clipper = imgui.ListClipper.new()
        clipper:Begin(#filtered_perks)

        while clipper:Step() do
            for i=clipper.DisplayStart,clipper.DisplayEnd - 1 do
                local perk = filtered_perks[i + 1]
                imgui.PushID(perk.id)

                if has_image_support then
                    imgui.TableNextColumn()
                    if perk.perk_icon then
                        local img = imgui.LoadImage(perk.perk_icon)
                        if img then
                            local style = imgui.GetStyle()
                            local image_size = imgui.GetTextLineHeight() + style.CellPadding_y * 2
                            imgui.Image(img, image_size, image_size)
                        end
                    end
                end

                imgui.TableNextColumn()
                imgui.Text(perk.display_name)

                imgui.TableNextColumn()
                imgui.Text(perk.id)

                imgui.TableNextColumn()
                imgui.Text(perk.origin)
                if #unique_origins > 1 and imgui.IsItemHovered() and imgui.IsMouseReleased(imgui.MouseButton.Right) then
                    filter_origin = perk.origin
                end

                imgui.TableNextColumn()
                if imgui.SmallButton("Equip") then
                    local player = player_util.get_player()
                    if player then
                        local success, result = pcall(function()
                            local x, y = EntityGetTransform(player)
                            local perk_entity = perk_spawn(x, y - 8, perk.id)
                            perk_pickup(perk_entity, player, nil, true, false)
                        end)

                        if not success then
                            print_error("CE give perk error: " .. tostring(result))
                        end
                    end
                end

                imgui.PopID()
            end
        end

        imgui.EndTable()
    end

    imgui.EndChild()
end

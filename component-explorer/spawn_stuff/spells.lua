---@module 'component-explorer.utils.strings'
local string_util = dofile_once("mods/component-explorer/utils/strings.lua")

---@module 'component-explorer.ui.combo'
local combo = dofile_once("mods/component-explorer/ui/combo.lua")

---@module 'component-explorer.utils.player_util'
local player_util = dofile_once("mods/component-explorer/utils/player_util.lua")

---@module 'component-explorer.spawn_data.actions'
local actions_data = dofile_once("mods/component-explorer/spawn_data/actions.lua")

---@module 'component-explorer.cursor'
local cursor = dofile_once("mods/component-explorer/cursor.lua")

local actions = actions_data.actions
local unique_action_types = actions_data.unique_action_types
local action_type_to_name = actions_data.action_type_to_name

local function get_unique_attrs(attr)
    local set = {}
    for _, action in ipairs(actions) do
        set[action[attr]] = true
    end

    local ret = {}
    for item, _ in pairs(set) do
        table.insert(ret, item)
    end

    table.sort(ret)
    return ret
end
local unique_origins = get_unique_attrs("origin")

local function popup_contents(action)
    if imgui.MenuItem("Copy action.id") then
        imgui.SetClipboardText(action.id)
    end

    if imgui.MenuItem("Copy name") then
        imgui.SetClipboardText(action.display_name)
    end
end

local filter_search = ""
---@type string?
local filter_origin = nil
---@type string?
local filter_action_type = nil

return function()
    local _

    imgui.SetNextItemWidth(200)
    _, filter_search = imgui.InputText("Search", filter_search)

    imgui.SameLine()
    imgui.SetNextItemWidth(150)
    _, filter_action_type = combo.optional("Type", unique_action_types, filter_action_type)

    if #unique_origins > 1 then
        imgui.SameLine()
        imgui.SetNextItemWidth(150)
        _, filter_origin = combo.optional("Origin", unique_origins, filter_origin)
    end

    local filtered_actions
    if filter_search == "" and filter_origin == nil and filter_action_type == nil then
        filtered_actions = actions
    else
        filtered_actions = {}
        for _, action in ipairs(actions) do
            if
                (filter_search == "" or (
                    string_util.ifind(action.id, filter_search, 1, true) or
                    string_util.ifind(action.display_name, filter_search, 1, true) or
                    string_util.ifind(action.display_description, filter_search, 1, true)
                ))
                and (filter_origin == nil or action.origin == filter_origin)
                and (filter_action_type == nil or action_type_to_name(action.type) == filter_action_type)
            then
                table.insert(filtered_actions, action)
            end
        end
    end

    if not imgui.BeginChild("table") then return end

    local column_count = 5

    local has_image_support = imgui.LoadImage ~= nil
    if has_image_support then
        column_count = column_count + 1
    end

    local flags = bit.bor(
        imgui.TableFlags.Resizable,
        imgui.TableFlags.Hideable,
        imgui.TableFlags.RowBg
    )

    if imgui.BeginTable("spells", column_count, flags) then
        if has_image_support then
            imgui.TableSetupColumn("img", imgui.TableColumnFlags.WidthFixed)
        end
        imgui.TableSetupColumn("Name")
        imgui.TableSetupColumn("ID")
        imgui.TableSetupColumn("Type", imgui.TableColumnFlags.WidthFixed)
        imgui.TableSetupColumn("Origin", imgui.TableColumnFlags.WidthFixed)
        imgui.TableSetupColumn("Spawn", imgui.TableColumnFlags.WidthFixed)
        imgui.TableHeadersRow()

        if has_image_support then
            local image_paths = {}
            for _, p in ipairs(actions) do
                if p.sprite then
                    table.insert(image_paths, p.sprite)
                end
            end
            -- Files are placed alphabetically in the data.wak, loading them in
            -- that order is much faster.
            table.sort(image_paths)
            for _, path in ipairs(image_paths) do
                imgui.LoadImage(path)
            end
        end

        local spawn_at_cursor = imgui.IsKeyDown(imgui.Key.LeftShift)

        local clipper = imgui.ListClipper.new()
        clipper:Begin(#filtered_actions)

        while clipper:Step() do
            for i=clipper.DisplayStart,clipper.DisplayEnd - 1 do
                local action = filtered_actions[i + 1]
                imgui.PushID(action.id)

                if has_image_support then
                    imgui.TableNextColumn()
                    if action.sprite then
                        local img = imgui.LoadImage(action.sprite)
                        if img then
                            local style = imgui.GetStyle()
                            local image_size = imgui.GetTextLineHeight() + style.CellPadding_y * 2
                            imgui.Image(img, image_size, image_size)
                        end
                    end
                end

                imgui.TableNextColumn()
                imgui.Text(action.display_name)

                imgui.TableNextColumn()
                imgui.Text(action.id)

                imgui.TableNextColumn()
                imgui.Text(action_type_to_name(action.type))
                if imgui.IsItemHovered() and imgui.IsMouseReleased(imgui.MouseButton.Right) then
                    filter_action_type = action_type_to_name(action.type)
                end

                imgui.TableNextColumn()
                imgui.Text(action.origin)
                if #unique_origins > 1 and imgui.IsItemHovered() and imgui.IsMouseReleased(imgui.MouseButton.Right) then
                    filter_origin = action.origin
                end

                imgui.TableNextColumn()
                if imgui.SmallButton("Spawn") then
                    local x, y = cursor.pos()
                    if not spawn_at_cursor then
                        local player = player_util.get_player()
                        if player then
                            x, y = EntityGetTransform(player)
                        end
                    end

                    CreateItemActionEntity(action.id, x, y)
                end

                if imgui.BeginPopupContextItem() then
                    popup_contents(action)
                    imgui.EndPopup()
                end

                imgui.PopID()
            end
        end

        imgui.EndTable()
    end

    imgui.EndChild()
end

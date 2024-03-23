dofile_once("mods/component-explorer/serialise_entity.lua")

---@module 'component-explorer.utils.strings'
local string_util = dofile_once("mods/component-explorer/utils/strings.lua")

---@module 'component-explorer.xml_serialise'
local xml_serialise = dofile_once("mods/component-explorer/xml_serialise.lua")

---@module 'component-explorer.entity_markers'
local entity_markers = dofile_once("mods/component-explorer/entity_markers.lua")

---@module 'component-explorer.tags_gui'
local tags_gui = dofile_once("mods/component-explorer/tags_gui.lua")

---@module 'component-explorer.utils.player_util'
local player_util = dofile_once("mods/component-explorer/utils/player_util.lua")

---@module 'component-explorer.file_viewer'
local file_viewer = dofile_once("mods/component-explorer/file_viewer.lua")

---@module 'component-explorer.style'
local style = dofile_once("mods/component-explorer/style.lua")

---@module 'component-explorer.cursor'
local cursor = dofile_once("mods/component-explorer/cursor.lua")

---@module 'component-explorer.ui.im'
local im = dofile_once("mods/component-explorer/ui/im.lua")

local common_entity_tags = {
    "card_action",
    "effect_protection",
    "enemy",
    "glue_NOT",
    "hittable",
    "homing_target",
    "human",
    "item_physics",
    "item_pickup",
    "mortal",
    "pixelsprite",
    "polymorphable_NOT",
    "prey",
    "projectile",
    "projectile_player",
    "prop",
    "prop_physics",
    "teleportable_NOT",
    "ui_use_raw_name",
    "vegetation",
    "wand",
}

local entities_watching = {}
local add_component_filter = ""

local function window_id(entity_id)
    return "###entity" .. entity_id
end

local function is_open(entity_id)
    local entry = entities_watching[entity_id]
    if entry and entry.window.open then
        return entry
    end
    return nil
end

function unwatch_entity(entity_id)
    local entry = is_open(entity_id)
    if entry then
        entry.window.open = false
    end
end

---@param entity_id integer
---@param open_data OpenData?
function watch_entity(entity_id, open_data)
    local config = entities_watching[entity_id]
    if not config then
        config = {}
        config.component_search = ""
        config.tag_data = {}
        config.window = im.Window(
            window_id(entity_id),
            true,
            imgui.WindowFlags.NoSavedSettings
        )
    end

    if open_data then
        config.window.open_data = open_data
    end
    config.window.open = true

    entities_watching[entity_id] = config
end

function toggle_watch_entity(entity_id)
    if is_open(entity_id) then
        unwatch_entity(entity_id)
    else
        watch_entity(entity_id)
    end
end

local function _make_entity_button(entity_id, button_fn)
    local id = "###open_entity_small_button" .. entity_id
    if is_open(entity_id) then
        if button_fn("Close" .. id) then
            unwatch_entity(entity_id)
        end
    else
        if button_fn("Open" .. id) then
            local open_data = im.GetOpenData()
            watch_entity(entity_id, open_data)
        end
    end
end

function open_entity_small_button(entity_id)
    return _make_entity_button(entity_id, imgui.SmallButton)
end

function open_entity_button(entity_id)
    return _make_entity_button(entity_id, imgui.Button)
end

local function get_entity_label(entity_id)
    local parts = {}

    local name = EntityGetName(entity_id)
    if name ~= "unknown" and name ~= "" then
        parts[#parts+1] = name
    end

    local tags = EntityGetTags(entity_id)
    if tags ~= "" then
        parts[#parts+1] = "[" .. tags .. "]"
    end

    return table.concat(parts, " ")
end

local function entity_child_buttons(parent_id, child_id)
    imgui.PushID(child_id)

    open_entity_small_button(child_id)

    imgui.SameLine()
    if imgui.SmallButton("Unparent") then
        EntityRemoveFromParent(child_id)
    end

    imgui.SameLine()
    if style.danger_small_button("Kill") then
        EntityKill(child_id)
    end

    imgui.PopID()
end

local function show_entity_children_row(parent_id, children)
    for _, child_id in ipairs(children) do
        imgui.TableNextColumn()

        local sub_children = EntityGetAllChildren(child_id)
        if not sub_children then
            imgui.Bullet()
            imgui.Text(get_entity_label(child_id))

            imgui.TableNextColumn()
            entity_child_buttons(parent_id, child_id)
        else
            if imgui.TreeNode(get_entity_label(child_id) .. "##" .. tostring(child_id)) then

                imgui.TableNextColumn()
                entity_child_buttons(parent_id, child_id)

                show_entity_children_row(child_id, sub_children)
                imgui.TreePop()
            else
                imgui.TableNextColumn()
                entity_child_buttons(parent_id, child_id)
            end
        end
    end
end

local function show_entity_children(parent_id, children)
    local table_flags = bit.bor(
        imgui.TableFlags.Resizable,
        imgui.TableFlags.RowBg
    )

    if not imgui.BeginTable("entity_children", 2, table_flags) then
        return
    end

    imgui.TableSetupColumn("Entity")
    imgui.TableSetupColumn("Actions", imgui.TableColumnFlags.WidthFixed)
    imgui.TableHeadersRow()

    show_entity_children_row(parent_id, children)

    imgui.EndTable()
end

local function show_entity(entity_id, data)
    if not EntityGetIsAlive(entity_id) then
        unwatch_entity(entity_id)
        return
    end

    local name = EntityGetName(entity_id)

    local display_name = name
    if display_name == "unknown" then display_name = "" end

    local title = "Entity: "
    if display_name == "" then
        title = title .. tostring(entity_id)
    else
        title = title .. display_name .. " (" .. tostring(entity_id) .. ")"
    end

    if not im.Begin(data.window, title) then
        return
    end

    local kill_entity = false

    if imgui.CollapsingHeader("Attributes") then
        local name_change
        name_change, name = imgui.InputText("Name", name)
        if name_change then
            EntitySetName(entity_id, name)
        end

        imgui.SameLine()
        local marker_changed, marker = imgui.Checkbox("Marker", entity_markers.has_marker(entity_id))
        if marker_changed then
            if marker then
                entity_markers.add_marker(entity_id)
            else
                entity_markers.remove_marker(entity_id)
            end
        end

        local filename = EntityGetFilename(entity_id)
        if filename ~= "" then
            if imgui.Button("Copy path") then
                imgui.SetClipboardText(filename)
            end

            imgui.SameLine()
            file_viewer.open_button(filename)

            imgui.SameLine()
            imgui.Text("File: " .. filename)
        end

        imgui.Separator()

        if xml_serialise.button() then
            local entity_xml = serialise_entity(entity_id, xml_serialise.include_privates)
            imgui.SetClipboardText(xml_serialise.tostring(entity_xml))
        end

        local x, y, rotation, scale_x, scale_y = EntityGetTransform(entity_id)

        local player = player_util.get_player()
        if player then
            imgui.Separator()

            imgui.Text("Teleport:")
            imgui.SameLine()
            if imgui.SmallButton("This to player") then
                local px, py = EntityGetTransform(player)
                EntityApplyTransform(entity_id, px, py, rotation, scale_x, scale_y)
            end

            imgui.SameLine()
            if imgui.SmallButton("This to cursor") then
                local cx, cy = cursor.pos()
                EntityApplyTransform(entity_id, cx, cy, rotation, scale_x, scale_y)
            end

            imgui.SameLine()
            if imgui.SmallButton("Player to this") then
                local _, _, pr, psx, psy = EntityGetTransform(player)
                EntityApplyTransform(player, x, y, pr, psx, psy)
            end
        end

        imgui.Separator()

        kill_entity = style.danger_button("Kill")

        local pos_changed
        pos_changed, x, y = imgui.InputFloat2("Position", x, y)

        local rot_changed
        rot_changed, rotation = imgui.InputFloat("Rotation", rotation)

        local scale_changed
        scale_changed, scale_x, scale_y = imgui.InputFloat2("Scale", scale_x, scale_y)

        if pos_changed or rot_changed or scale_changed then
            EntitySetTransform(entity_id, x, y, rotation, scale_x, scale_y)
        end

        local parent = EntityGetParent(entity_id)
        if parent ~= 0 then
            imgui.Text("Parent: " .. parent)
            imgui.SameLine()
            open_entity_small_button(parent)

            local root = EntityGetRootEntity(parent)
            if root ~= parent then
                imgui.Text("Root: " .. root)
                imgui.SameLine()
                open_entity_small_button(root)
            end
        end
    end

    local tag_string = EntityGetTags(entity_id) --[[@as string]]
    local tags = {}
    for tag in string.gmatch(tag_string, "[^,]+") do
        table.insert(tags, tag)
    end

    if imgui.CollapsingHeader("Tags (" .. #tags .. ")###entity_tags") then
        local function add_tag(t) EntityAddTag(entity_id, t) end
        local function remove_tag(t) EntityRemoveTag(entity_id, t) end
        tags_gui.show(data.tag_data, tags, add_tag, remove_tag, common_entity_tags)

        if imgui.Button("Copy tag string") then
            imgui.SetClipboardText(tag_string)
        end
    end

    local children = EntityGetAllChildren(entity_id)
    if children then
        if imgui.CollapsingHeader("Child Entities (" .. #children .. ")###entity_child_entites") then
            show_entity_children(entity_id, children)
        end
    else
        imgui.BeginDisabled()
        imgui.CollapsingHeader("Child Entities (none)")
        imgui.EndDisabled()
    end

    local components = EntityGetAllComponents(entity_id)
    if imgui.CollapsingHeader("Components (" .. #components .. ")###entity_components") then
        local _
        _, data.component_search = imgui.InputText("Type Search", data.component_search)

        if imgui.Button("+ Add Component") then
            imgui.OpenPopup("add_component_popup")
        end

        if imgui.BeginPopup("add_component_popup") then
            local _
            _, add_component_filter = imgui.InputTextWithHint(
                "##add_comp_filter", "Filter list", add_component_filter)
            imgui.SameLine()
            if imgui.Button("X") then
                add_component_filter = ""
            end

            for _, component_type in ipairs(component_types) do
                if string_util.ifind(component_type, add_component_filter, 1, true) then
                    if imgui.MenuItem(component_type) then
                        EntityAddComponent(entity_id, component_type)
                        add_component_filter = ""
                    end
                end
            end
            imgui.EndPopup()
        end

        local table_flags = bit.bor(imgui.TableFlags.Resizable, imgui.TableFlags.RowBg)
        if imgui.BeginTable("EntityComponents", 4, table_flags) then
            imgui.TableSetupColumn("ID", imgui.TableColumnFlags.WidthFixed)
            imgui.TableSetupColumn("Type", imgui.TableColumnFlags.WidthStretch, 6)
            imgui.TableSetupColumn("Enabled", imgui.TableColumnFlags.WidthFixed)
            imgui.TableSetupColumn("Open", imgui.TableColumnFlags.WidthFixed)
            imgui.TableHeadersRow()

            for _, component_id in ipairs(components) do
                local type = ComponentGetTypeName(component_id)

                if string_util.ifind(type, data.component_search, 1, true) then
                    imgui.PushID(component_id)

                    imgui.TableNextColumn()
                    imgui.Text(tostring(component_id))

                    imgui.TableNextColumn()
                    imgui.Text(type)

                    imgui.TableNextColumn()
                    local enabled = ComponentGetIsEnabled(component_id)
                    local enabled_changed, new_enabled = imgui.Checkbox("", enabled)
                    if enabled_changed then
                        EntitySetComponentIsEnabled(entity_id, component_id, new_enabled)
                    end

                    imgui.TableNextColumn()
                    open_component_small_button(entity_id, component_id)

                    imgui.PopID()
                end
            end

            imgui.EndTable()
        end
    end

    im.End(data.window)

    if kill_entity then
        EntityKill(entity_id)
    end
end

function show_entity_windows()
    -- entities_watching can change within show_entity, so make a copy to
    -- guard against this causing iteration bugs.
    local _copy = {}
    for entity_id, data in pairs(entities_watching) do
        _copy[#_copy+1] = {entity_id, data}
    end

    for _, v in ipairs(_copy) do
        show_entity(v[1], v[2])
    end
end

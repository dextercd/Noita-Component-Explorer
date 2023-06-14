dofile_once("mods/component-explorer/serialise_entity.lua")
local string_util = dofile_once("mods/component-explorer/utils/strings.lua")
local xml_serialise = dofile_once("mods/component-explorer/xml_serialise.lua")
local entity_markers = dofile_once("mods/component-explorer/entity_markers.lua")
local tags_gui = dofile_once("mods/component-explorer/tags_gui.lua")

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

function unwatch_entity(entity_id)
    entities_watching[entity_id] = nil
end

function watch_entity(entity_id)
    entities_watching[entity_id] = {
        component_search = "",
        tag_data = {},
    }
end

function toggle_watch_entity(entity_id)
    if entities_watching[entity_id] then
        unwatch_entity(entity_id)
    else
        watch_entity(entity_id)
    end
end

function open_entity_small_button(entity_id)
    if entities_watching[entity_id] then
        if imgui.SmallButton("Close###open_entity_small_button" .. entity_id) then
            unwatch_entity(entity_id)
        end
    else
        if imgui.SmallButton("Open###open_entity_small_button" .. entity_id) then
            watch_entity(entity_id)
        end
    end
end

function open_entity_button(entity_id)
    if entities_watching[entity_id] then
        if imgui.Button("Close###open_entity_small_button" .. entity_id) then
            unwatch_entity(entity_id)
        end
    else
        if imgui.Button("Open###open_entity_small_button" .. entity_id) then
            watch_entity(entity_id)
        end
    end
end

local function get_entity_label(entity_id)
    local name = EntityGetName(entity_id)

    if name == "unknown" then name = "" end
    local tags = EntityGetTags(entity_id)
    return entity_id .. " " .. name .. " [" .. tags .. "]"
end

function show_entity_sub_children(children)
    for _, child_id in ipairs(children) do
        local sub_children = EntityGetAllChildren(child_id)
        if not sub_children then
            imgui.Bullet()
            imgui.Text(get_entity_label(child_id))
            imgui.SameLine() open_entity_small_button(child_id)
        else
            if imgui.TreeNode(get_entity_label(child_id) .. "##" .. tostring(child_id)) then
                imgui.SameLine() open_entity_small_button(child_id)
                show_entity_children(child_id)
                imgui.TreePop()
            else
                imgui.SameLine() open_entity_small_button(child_id)
            end
        end
    end
end

function show_entity_children(entity_id)
    local children = EntityGetAllChildren(entity_id)
    if not children then return end

    show_entity_sub_children(children)
end

local function show_entity(entity_id, data)
    if not EntityGetIsAlive(entity_id) then
        unwatch_entity(entity_id)
        return
    end

    local name = EntityGetName(entity_id)
    if name == "unknown" then name = "" end

    local title = "Entity: "
    if name == "" then
        title = title .. tostring(entity_id)
    else
        title = title .. name .. " (" .. tostring(entity_id) .. ")"
    end

    imgui.SetNextWindowSize(600, 400, imgui.Cond.Once)
    local flags = imgui.WindowFlags.NoSavedSettings
    local should_show, open = imgui.Begin(title .. "###show_entity" .. tostring(entity_id), true, flags)

    if not open then
        unwatch_entity(entity_id)
    end

    if not should_show then
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
            imgui.Text("File: " .. filename)
        end

        imgui.Separator()

        if xml_serialise.button() then
            local entity_xml = serialise_entity(entity_id, xml_serialise.include_privates)
            imgui.SetClipboardText(xml_serialise.tostring(entity_xml))
        end

        imgui.Separator()

        imgui.PushStyleColor(imgui.Col.Button, 1, 0.4, 0.4)
        imgui.PushStyleColor(imgui.Col.ButtonHovered, 1, 0.6, 0.6)
        imgui.PushStyleColor(imgui.Col.ButtonActive, 0.8, 0.4, 0.4)
        if imgui.Button("Kill") then kill_entity = true end
        imgui.PopStyleColor(3)


        local x, y, rotation, scale_x, scale_y = EntityGetTransform(entity_id)

        local pos_changed
        pos_changed, x, y = imgui.InputFloat2("Position", x, y)

        local rot_changed
        rot_changed, rotation = imgui.InputFloat("Rotation", rotation)

        local scale_changed
        scale_changed, scale_x, scale_y = imgui.InputFloat2("Scale", scale_x, scale_y)

        if pos_changed or rot_changed or scale_changed then
            EntitySetTransform(entity_id, x, y, rotation, scale_x, scale_y)
        end
    end

    if imgui.CollapsingHeader("Tags") then
        local tag_string = EntityGetTags(entity_id)
        local tags = {}
        for tag in string.gmatch(tag_string, "[^,]+") do
            table.insert(tags, tag)
        end

        local function add_tag(t) EntityAddTag(entity_id, t) end
        local function remove_tag(t) EntityRemoveTag(entity_id, t) end
        tags_gui.show(data.tag_data, tags, add_tag, remove_tag, common_entity_tags)
    end

    if imgui.CollapsingHeader("Child Entities") then
        show_entity_children(entity_id)
    end

    if imgui.CollapsingHeader("Components") then
        _, data.component_search = imgui.InputText("Type Search", data.component_search)

        if imgui.Button("+ Add Component") then
            imgui.OpenPopup("add_component_popup")
        end

        if imgui.BeginPopup("add_component_popup") then
            for _, component_type in ipairs(component_types) do
                if imgui.MenuItem(component_type) then
                    EntityAddComponent(entity_id, component_type)
                end
            end
            imgui.EndPopup()
        end

        local table_flags = imgui.TableFlags.Resizable
        if imgui.BeginTable("EntityComponents", 4, table_flags) then
            imgui.TableSetupColumn("ID", imgui.TableColumnFlags.WidthFixed)
            imgui.TableSetupColumn("Type", imgui.TableColumnFlags.WidthStretch, 6)
            imgui.TableSetupColumn("Enabled", imgui.TableColumnFlags.WidthFixed)
            imgui.TableSetupColumn("Open", imgui.TableColumnFlags.WidthFixed)
            imgui.TableHeadersRow()

            local components = EntityGetAllComponents(entity_id)
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
                    local enabled_changed, enabled = imgui.Checkbox("###enabled" .. tostring(component_id), enabled)
                    if enabled_changed then
                        EntitySetComponentIsEnabled(entity_id, component_id, enabled)
                    end

                    imgui.TableNextColumn()
                    open_component_small_button(entity_id, component_id)

                    imgui.PopID()
                end
            end

            imgui.EndTable()
        end
    end

    imgui.End()

    if kill_entity then
        EntityKill(entity_id)
    end
end

function show_entity_windows()
    for entity_id, data in pairs(entities_watching) do
        show_entity(entity_id, data)
    end
end

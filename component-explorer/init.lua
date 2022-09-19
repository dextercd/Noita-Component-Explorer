dofile_once("mods/component-explorer/lua_console.lua")
dofile_once("mods/component-explorer/components.lua")
dofile_once("mods/component-explorer/entity_list.lua")

local common_entity_tags = {
    "enabled_in_world",
    "enabled_in_hand",
    "enabled_in_inventory",
    "projectile_player",
    "hittable",
    "teleportable_NOT",
    "polymorphable_NOT",
    "glue_NOT",
    "mortal",
    "prop",
    "prop_physics",
    "item_physics",
    "item_pickup",
    "pixelsprite",
    "homing_target",
    "enemy",
    "prey",
    "ui_use_raw_name",
    "card_action",
    "effect_protection",
    "vegetation",
    "wand",
    "projectile",
}

if not load_imgui then
    local msg = "Could not find Dear ImGui, Component Explorer won't work."
    GamePrint(msg)
    print(msg)
    error(msg)
end

imgui = load_imgui({version="1.0", mod="Component Explorer"})


function help_marker(desc)
    imgui.TextDisabled("(?)")
    if imgui.IsItemHovered() then
        imgui.BeginTooltip()
        imgui.PushTextWrapPos(300)
        imgui.Text(desc)
        imgui.PopTextWrapPos()
        imgui.EndTooltip()
    end
end

local entities_watching = {}

function unwatch_entity(entity_id)
    entities_watching[entity_id] = nil
end

function watch_entity(entity_id)
    entities_watching[entity_id] = {
        component_search = "",
    }
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

new_tag_input = ""

function get_entity_label(entity_id)
    local name = EntityGetName(entity_id)
    if name == "unknown" then name = "" end
    local tags = EntityGetTags(entity_id)
    return name .. " [" .. tags .. "]"
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

function show_entity(entity_id, data)
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

    local should_show, open = imgui.Begin(title .. "###show_entity" .. tostring(entity_id), true)

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
        local submit
        imgui.SetNextItemWidth(200)
        submit, new_tag_input = imgui.InputText(
            "Add tag", new_tag_input,
            imgui.InputTextFlags.EnterReturnsTrue
        )
        if submit then
            EntityAddTag(entity_id, new_tag_input)
            new_tag_input = ""
        end

        local tag_string = EntityGetTags(entity_id)
        local tags = {}
        local tag_set = {}
        for tag in string.gmatch(tag_string, "[^,]+") do
            table.insert(tags, tag)
            tag_set[tag] = true
        end

        imgui.SameLine()
        if imgui.Button("Common..") then
            imgui.OpenPopup("common_tags_popup")
        end

        if imgui.BeginPopup("common_tags_popup") then
            for _, tag in ipairs(common_entity_tags) do
                if imgui.MenuItem(tag, "", tag_set[tag] ~= nil) then
                    if tag_set[tag] then
                        EntityRemoveTag(entity_id, tag)
                    else
                        EntityAddTag(entity_id, tag)
                    end
                end
            end
            imgui.EndPopup()
        end

        local table_flags = imgui.TableFlags.Resizable
        if imgui.BeginTable("tags", 2, table_flags) then

            imgui.TableSetupColumn("Tag")
            imgui.TableSetupColumn("Remove", imgui.TableColumnFlags.WidthFixed)
            imgui.TableHeadersRow()

            for _, tag in ipairs(tags) do
                imgui.PushID(tag)

                imgui.TableNextColumn()
                imgui.Text(tag)

                imgui.TableNextColumn()
                if imgui.SmallButton("-") then
                    EntityRemoveTag(entity_id, tag)
                end

                imgui.PopID()
            end

            imgui.EndTable()
        end

    end

    if imgui.CollapsingHeader("Child Entities") then
        show_entity_children(entity_id)
    end

    if imgui.CollapsingHeader("Components") then
        _, data.component_search = imgui.InputText("Type Search", data.component_search)

        local table_flags = imgui.TableFlags.Resizable
        if imgui.BeginTable("EntityComponents", 3, table_flags) then
            imgui.TableSetupColumn("Type", imgui.TableColumnFlags.WidthStretch, 6)
            imgui.TableSetupColumn("Enabled", imgui.TableColumnFlags.WidthFixed)
            imgui.TableSetupColumn("Open", imgui.TableColumnFlags.WidthFixed)
            imgui.TableHeadersRow()

            local components = EntityGetAllComponents(entity_id)
            for _, component_id in ipairs(components) do
                local type = ComponentGetTypeName(component_id)

                if string.find(type, data.component_search, 1, true) then
                    imgui.PushID(component_id)

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

function OnPlayerSpawned(player_entity)
    player = player_entity
    watch_entity(player)
    if true then return end
    damage_model = EntityGetFirstComponentIncludingDisabled(player, "DamageModelComponent")
    controls_component = EntityGetFirstComponentIncludingDisabled(player, "ControlsComponent")

    if damage_model then
        table.insert(components_watching, {player, damage_model, show_DamageModelComponent_window})
    end

    if controls_component then
        table.insert(components_watching, {player, controls_component, show_ControlsComponent_window})
    end

    for i, v in ipairs(EntityGetAllChildren(player) or {}) do
        if EntityGetName(v) == "cape" then
            cape = v
        end
    end

    if cape then
        verlet = EntityGetFirstComponentIncludingDisabled(cape, "VerletPhysicsComponent")
        table.insert(components_watching, {cape, verlet, show_VerletPhysicsComponent_window})
    end
end

local console = new_console()

function OnWorldPreUpdate()
    show_component_windows()
    show_entity_windows()
    show_entity_list_window()

    console_draw(console)
end

dofile_once("mods/component-explorer/lua_console.lua")
dofile_once("mods/component-explorer/components.lua")
dofile_once("mods/component-explorer/entity_list.lua")
dofile_once("mods/component-explorer/entity.lua")

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

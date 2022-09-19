dofile_once("mods/component-explorer/lua_console.lua")
dofile_once("mods/component-explorer/components.lua")
dofile_once("mods/component-explorer/entity_list.lua")
dofile_once("mods/component-explorer/entity.lua")
dofile_once("mods/component-explorer/version.lua")

if not load_imgui then
    local msg = "Could not find Dear ImGui, Component Explorer won't work."
    GamePrint(msg)
    print(msg)
    error(msg)
end

imgui = load_imgui({version="1.2", mod="Component Explorer"})


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
console.open = false

local component_windows_open = true
local entity_windows_open = true

function OnWorldPreUpdate()
    local window_flags = imgui.WindowFlags.MenuBar
    if imgui.Begin("Component Explorer", nil, window_flags) then
        if imgui.BeginMenuBar() then

            if imgui.BeginMenu("View") then

                _, component_windows_open = imgui.MenuItem("Component Windows", "", component_windows_open)
                _, entity_windows_open = imgui.MenuItem("Entity Windows", "", entity_windows_open)
                _, console.open = imgui.MenuItem("Lua Console", "", console.open)
                _, entity_list_open = imgui.MenuItem("Entity List", "", entity_list_open)

                imgui.EndMenu()
            end

            imgui.EndMenuBar()
        end

        imgui.Text("Component explorer version " .. version)
        imgui.Text("Made by dextercd#7326")
        imgui.Text("Homepage: " .. homepage)
        imgui.SameLine()
        if imgui.SmallButton("Copy") then
            imgui.SetClipboardText(homepage)
        end

        imgui.End()
    end

    if component_windows_open then
        show_component_windows()
    end

    if entity_windows_open then
        show_entity_windows()
    end

    if entity_list_open then
        show_entity_list_window()
    end

    if console.open then
        console_draw(console)
    end
end

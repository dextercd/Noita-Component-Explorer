if not load_imgui then
    local msg = "Could not find Dear ImGui, Component Explorer won't work."
    GamePrint(msg)
    print(msg)
    error(msg)
end

-- Loading imgui early so it's available when other files are loaded
imgui = load_imgui({version="1.7.0", mod="Component Explorer"})

dofile_once("mods/component-explorer/settings_util.lua") -- Should be loaded early
dofile_once("mods/component-explorer/lua_console.lua")
dofile_once("mods/component-explorer/components.lua")
dofile_once("mods/component-explorer/entity_list.lua")
dofile_once("mods/component-explorer/entity.lua")
dofile_once("mods/component-explorer/version.lua")
dofile_once("mods/component-explorer/logger.lua")
dofile_once("mods/component-explorer/entity_picker.lua")
dofile_once("mods/component-explorer/noita_version.lua")

if is_steam_version() then
    dofile_once("mods/component-explorer/magic_numbers.lua")
    dofile_once("mods/component-explorer/debug.lua")
end


function help_tooltip(desc)
    if imgui.IsItemHovered() then
        imgui.BeginTooltip()
        imgui.PushTextWrapPos(400)
        imgui.Text(desc)
        imgui.PopTextWrapPos()
        imgui.EndTooltip()
    end
end

function help_marker(desc)
    imgui.TextDisabled("(?)")
    help_tooltip(desc)
end

local console = new_console()

window_open_entity_list = setting_get("window_open_entity_list")
console.open = setting_get("window_open_lua_console")
window_open_logs = setting_get("window_open_logs")
local overlay_open_logs = setting_get("overlay_open_logs")
local windows_open_component = true
local windows_open_entity = true


function OnWorldPreUpdate()
    update_ui(false)
end


is_escape_paused = false
is_inventory_paused = false

function OnPausedChanged(paused, inventory_pause)
    load_settings()  -- Settings might've changed, reload

    is_escape_paused = paused and not inventory_pause
    is_inventory_paused = inventory_pause
end

function OnPausePreUpdate()
    if is_escape_paused and setting_get("pause_escape") or
       is_inventory_paused and setting_get("pause_wands")
    then
        update_ui(true)
    end
end

function view_menu_items()
    _, windows_open_component  = imgui.MenuItem("Component Windows", "", windows_open_component)
    _, windows_open_entity     = imgui.MenuItem("Entity Windows", "", windows_open_entity)
    _, console.open            = imgui.MenuItem("Lua Console", "CTRL+SHIFT+L", console.open)
    _, window_open_entity_list = imgui.MenuItem("Entity List", "", window_open_entity_list)
    _, window_open_logs        = imgui.MenuItem("Logs Window", "", window_open_logs)
    _, overlay_open_logs       = imgui.MenuItem("Logs Overlay", "CTRL+SHIFT+O", overlay_open_logs)

    local clicked = imgui.MenuItem("Entity Picker", "CTRL+SHIFT+E", overlay_open_entity_picker)
    if clicked then
        open_entity_picker_overlay()
        imgui.SetWindowFocus(nil)
    end

    if imgui.IsItemHovered() then
        help_tooltip(table.concat({
            "Allows you to move your mouse over an entity to open a window for it. ",
            "Press the entry number to select the entity. ESC to cancel the action.\n\n",
            "You can also hit CTRL+SHIFT+E to open or close the picker.",
        }))
    end

    if is_steam_version() then
        imgui.Separator()
        _, window_open_magic_numbers = imgui.MenuItem("Magic Numbers", "CTRL+SHIFT+M", window_open_magic_numbers)
        _, window_open_debug = imgui.MenuItem("Debug", "CTRL+SHIFT+D", window_open_debug)
    end
end

function update_ui(is_paused)
    keyboard_shortcuts()

    local window_flags = imgui.WindowFlags.MenuBar
    if imgui.Begin("Component Explorer", nil, window_flags) then
        if imgui.BeginMenuBar() then

            if imgui.BeginMenu("View") then
                view_menu_items()
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

    if windows_open_component then
        show_component_windows()
    end

    if windows_open_entity then
        show_entity_windows()
    end

    if window_open_entity_list then
        show_entity_list_window()
    end

    if console.open then
        console_draw(console)
    end

    if window_open_logs then
        draw_log_window()
    end

    if overlay_open_logs then
        draw_log_overlay()
    end

    if overlay_open_entity_picker then
        show_entity_picker_overlay()
    end

    if is_steam_version() then
        if window_open_magic_numbers then
            show_magic_numbers()
        end

        if window_open_debug then
            show_debug()
        end
    end
end

function keyboard_shortcuts()
    if not imgui.IsKeyDown(imgui.Key.LeftCtrl) then
        return
    end

    if not imgui.IsKeyDown(imgui.Key.LeftShift) then
        return
    end

    if imgui.IsKeyPressed(imgui.Key.E) then
        if overlay_open_entity_picker then
            overlay_open_entity_picker = false
        else
            open_entity_picker_overlay()
        end
    end

    if imgui.IsKeyPressed(imgui.Key.W) then
        local world_entity = 1
        local world_component = EntityGetFirstComponent(world_entity, "WorldStateComponent")
        toggle_watch_component(world_entity, world_component)
    end

    if imgui.IsKeyPressed(imgui.Key.P) then
        local players = EntityGetWithTag("player_unit")
        for _, player in ipairs(players) do
            toggle_watch_entity(player)
        end
    end

    if imgui.IsKeyPressed(imgui.Key.L) then
        console.open = not console.open
    end

    if imgui.IsKeyPressed(imgui.Key.O) then
        overlay_open_logs = not overlay_open_logs
    end

    if is_steam_version() then
        if imgui.IsKeyPressed(imgui.Key.M) then
            window_open_magic_numbers = not window_open_magic_numbers
        end

        if imgui.IsKeyPressed(imgui.Key.D) then
            window_open_debug = not window_open_debug
        end
    end
end

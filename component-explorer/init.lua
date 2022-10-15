dofile_once("mods/component-explorer/settings_util.lua") -- Should be loaded early
dofile_once("mods/component-explorer/lua_console.lua")
dofile_once("mods/component-explorer/components.lua")
dofile_once("mods/component-explorer/entity_list.lua")
dofile_once("mods/component-explorer/entity.lua")
dofile_once("mods/component-explorer/version.lua")
dofile_once("mods/component-explorer/logger.lua")

if not load_imgui then
    local msg = "Could not find Dear ImGui, Component Explorer won't work."
    GamePrint(msg)
    print(msg)
    error(msg)
end

imgui = load_imgui({version="1.3.0", mod="Component Explorer"})


function help_marker(desc)
    imgui.TextDisabled("(?)")
    if imgui.IsItemHovered() then
        imgui.BeginTooltip()
        imgui.PushTextWrapPos(400)
        imgui.Text(desc)
        imgui.PopTextWrapPos()
        imgui.EndTooltip()
    end
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


function update_ui(is_paused)
    local window_flags = imgui.WindowFlags.MenuBar
    if imgui.Begin("Component Explorer", nil, window_flags) then
        if imgui.BeginMenuBar() then

            if imgui.BeginMenu("View") then
                _, windows_open_component =  imgui.MenuItem("Component Windows", "", windows_open_component)
                _, windows_open_entity =     imgui.MenuItem("Entity Windows", "", windows_open_entity)
                _, console.open =            imgui.MenuItem("Lua Console", "", console.open)
                _, window_open_entity_list = imgui.MenuItem("Entity List", "", window_open_entity_list)
                _, window_open_logs =        imgui.MenuItem("Logs Window", "", window_open_logs)
                _, overlay_open_logs =       imgui.MenuItem("Logs Overlay", "", overlay_open_logs)

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
end

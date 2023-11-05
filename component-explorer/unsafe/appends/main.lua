local _show_view_menu_items = show_view_menu_items
local _keyboard_shortcut_items = keyboard_shortcut_items

local function is_steam_version()
    return GlobalsGetValue("ue.steam") == "1"
end

function show_view_menu_items()
    _show_view_menu_items()

    imgui.Separator()

    local _
    local window_open_logs = GlobalsGetValue("ue.logs_window") == "1"
    local overlay_open_logs = GlobalsGetValue("ue.logs_overlay") == "1"

    _, window_open_logs  = imgui.MenuItem("Logs Window", "", window_open_logs)
    _, overlay_open_logs = imgui.MenuItem("Logs Overlay", sct("CTRL+SHIFT+O"), overlay_open_logs)

    GlobalsSetValue("ue.logs_window", window_open_logs and "1" or "0")
    GlobalsSetValue("ue.logs_overlay", overlay_open_logs and "1" or "0")

    if is_steam_version() then
        imgui.Separator()
        local window_open_magic_numbers = GlobalsGetValue("ue.mn_window") == "1"
        local window_open_debug = GlobalsGetValue("ue.debug_window") == "1"

        _, window_open_magic_numbers = imgui.MenuItem("Magic Numbers", sct("CTRL+SHIFT+M"), window_open_magic_numbers)
        _, window_open_debug = imgui.MenuItem("Debug", sct("CTRL+SHIFT+D"), window_open_debug)

        GlobalsSetValue("ue.mn_window", window_open_magic_numbers and "1" or "0")
        GlobalsSetValue("ue.debug_window", window_open_debug and "1" or "0")
    end
end

function keyboard_shortcut_items()
    _keyboard_shortcut_items()

    if imgui.IsKeyPressed(imgui.Key.O) then
        local overlay_open_logs = GlobalsGetValue("ue.logs_overlay") == "1"
        overlay_open_logs = not overlay_open_logs
        GlobalsSetValue("ue.logs_overlay", overlay_open_logs and "1" or "0")
    end

    if is_steam_version() then
        if imgui.IsKeyPressed(imgui.Key.M) then
            local window_open_magic_numbers = GlobalsGetValue("ue.mn_window") == "1"
            window_open_magic_numbers = not window_open_magic_numbers
            GlobalsSetValue("ue.mn_window", window_open_magic_numbers and "1" or "0")
        end

        if imgui.IsKeyPressed(imgui.Key.D) then
            local window_open_debug = GlobalsGetValue("ue.debug_window") == "1"
            window_open_debug = not window_open_debug
            GlobalsSetValue("ue.debug_window", window_open_debug and "1" or "0")
        end
    end
end

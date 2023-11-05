-- Loading imgui early so it's available when other files are loaded
imgui = load_imgui({version="1.7.0", mod="Unsafe Explorer"})

---@module 'component-explorer.utils.ce_settings'
local ce_settings = dofile_once("mods/component-explorer/utils/ce_settings.lua")

---@module 'component-explorer.logger'
dofile_once("mods/component-explorer/unsafe/logger.lua")

---@module 'component-explorer.unsafe.win32'
local win32 = dofile_once("mods/component-explorer/unsafe/win32.lua")

dofile_once("mods/component-explorer/unsafe/noita_version.lua")

---@module 'component-explorer.unsafe.user_scripts_window'
local uswindow = dofile_once("mods/component-explorer/unsafe/user_scripts_window.lua")


if is_steam_version() then
    dofile_once("mods/component-explorer/unsafe/magic_numbers.lua")
    dofile_once("mods/component-explorer/unsafe/debug.lua")
end

function OnWorldPreUpdate()
    local link = GlobalsGetValue("ue.link")
    if link ~= "" then
        GlobalsSetValue("ue.link", "")
        win32.open(link)
    end
end

function OnWorldInitialized()
    GlobalsSetValue("ue.logs_window", ce_settings.get("window_open_logs") and "1" or "0")
    GlobalsSetValue("ue.logs_overlay", ce_settings.get("overlay_open_logs") and "1" or "0")

    GlobalsSetValue("ue.mn_window", "0")
    GlobalsSetValue("ue.debug_window", "0")

    GlobalsSetValue("ue.steam", is_steam_version() and "1" or "")
end

function update_ui(paused, current_frame_run)
    if GlobalsGetValue("ue.logs_window") == "1" then
        draw_log_window()
    end

    if GlobalsGetValue("ue.logs_overlay") == "1" then
        draw_log_overlay()
    end

    if
        GlobalsGetValue("ce.console") == "1" and
        ce_settings.get("window_open_user_scripts")
    then
        local script = uswindow.draw_user_scripts_window()
        if script then
            GlobalsSetValue("ue.us_cmd", script)
        end
    end

    if is_steam_version() then
        if GlobalsGetValue("ue.mn_window") == "1" then
            show_magic_numbers()
        end
        if GlobalsGetValue("ue.debug_window") == "1" then
            show_debug()
        end
    end
end

dofile("mods/component-explorer/lib/ui_callbacks.lua")

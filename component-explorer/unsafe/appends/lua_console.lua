---@module 'component-explorer.lua_console'
local lua_console = dofile_once("mods/component-explorer/lua_console.lua")

---@module 'component-explorer.user_scripts'
local us = dofile_once("mods/component-explorer/user_scripts.lua")

---@module 'component-explorer.utils.ce_settings'
local ce_settings = dofile_once("mods/component-explorer/utils/ce_settings.lua")

local _header_buttons = lua_console.header_buttons
function lua_console.header_buttons(console)
    _header_buttons(console)

    imgui.SameLine()
    local user_scripts_open = ce_settings.get("window_open_user_scripts")

    local ustext = user_scripts_open and "Close user scripts" or "Open user scripts"
    if imgui.SmallButton(ustext) then
        user_scripts_open = not user_scripts_open
        ce_settings.set("window_open_user_scripts", user_scripts_open)
    end

    local us_cmd = GlobalsGetValue("ue.us_cmd")
    if us_cmd ~= "" then
        GlobalsSetValue("ue.us_cmd", "")
        console_run_command(console, us.user_script_call_string(us_cmd))
    end
end

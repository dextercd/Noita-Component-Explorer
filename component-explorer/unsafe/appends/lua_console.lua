---@module 'component-explorer.lua_console'
local lua_console = dofile_once("mods/component-explorer/lua_console.lua")

---@module 'component-explorer.user_scripts'
local us = dofile_once("mods/component-explorer/user_scripts.lua")

---@module 'component-explorer.utils.ce_settings'
local ce_settings = dofile_once("mods/component-explorer/utils/ce_settings.lua")

local _menu_bar = lua_console.menu_bar_items
function lua_console.menu_bar_items(console)
    _menu_bar(console)

    local user_scripts_open = ce_settings.get("window_open_user_scripts")

    local ustext = user_scripts_open and "Close user scripts" or "Open user scripts"
    if imgui.MenuItem(ustext) then
        user_scripts_open = not user_scripts_open
        ce_settings.set("window_open_user_scripts", user_scripts_open)
    end
end

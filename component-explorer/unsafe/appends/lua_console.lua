---@module 'component-explorer.lua_console'
local lua_console = dofile_once("mods/component-explorer/lua_console.lua")

---@module 'component-explorer.user_scripts'
local us = dofile_once("mods/component-explorer/user_scripts.lua")

---@module 'component-explorer.utils.ce_settings'
local ce_settings = dofile_once("mods/component-explorer/utils/ce_settings.lua")

---@module 'component-explorer.unsafe.win32'
local win32 = dofile_once("mods/component-explorer/unsafe/win32.lua")

local _menu_bar = lua_console.Console.draw_menu_bar_items
function lua_console.Console:draw_menu_bar_items()
    _menu_bar(self)

    local user_scripts_open = ce_settings.get("window_open_user_scripts") --[[@as boolean]]

    if imgui.BeginMenu("User Scripts") then
        if imgui.MenuItem("Show", "", user_scripts_open) then
            user_scripts_open = not user_scripts_open
            ce_settings.set("window_open_user_scripts", user_scripts_open)
        end

        if imgui.MenuItem("Open script folder") then
            win32.explore(us.directory_path)
        end

        imgui.EndMenu()
    end
end

---@module 'component-explorer.utils.ce_settings'
local ce_settings = dofile_once("mods/component-explorer/utils/ce_settings.lua")

---@module 'component-explorer.unsafe.logger'
local logger = dofile_once("mods/component-explorer/unsafe/logger.lua")

dofile_once("mods/component-explorer/unsafe/noita_version.lua")

---@module 'component-explorer.unsafe.user_scripts_window'
local uswindow = dofile_once("mods/component-explorer/unsafe/user_scripts_window.lua")

---@module 'component-explorer.user_scripts'
local us = dofile_once("mods/component-explorer/user_scripts.lua")


local magic_numbers = nil
local debug = nil

if is_steam_version() then
    ---@module 'component-explorer.unsafe.magic_numbers'
    magic_numbers = dofile_once("mods/component-explorer/unsafe/magic_numbers.lua")

    ---@module 'component-explorer.unsafe.debug'
    debug = dofile_once("mods/component-explorer/unsafe/debug.lua")
end


local _show_view_menu_items = show_view_menu_items
function show_view_menu_items()
    _show_view_menu_items()

    imgui.Separator()

    local _
    _, logger.window_open  = imgui.MenuItem("Logs Window", "", logger.window_open)
    _, logger.overlay_open = imgui.MenuItem("Logs Overlay", sct("CTRL+SHIFT+O"), logger.overlay_open)

    if is_steam_version() then
        imgui.Separator()

        if magic_numbers then
            _, magic_numbers.open = imgui.MenuItem("Magic Numbers", sct("CTRL+SHIFT+M"), magic_numbers.open)
        end

        if debug then
            _, debug.open = imgui.MenuItem("Debug", sct("CTRL+SHIFT+D"), debug.open)
        end
    end
end

local _keyboard_shortcut_items = keyboard_shortcut_items
function keyboard_shortcut_items()
    _keyboard_shortcut_items()

    if imgui.IsKeyPressed(imgui.Key.O) then
        logger.overlay_open = not logger.overlay_open
    end

    if magic_numbers then
        if imgui.IsKeyPressed(imgui.Key.M) then
            magic_numbers.open = not magic_numbers.open
        end
    end

    if debug then
        if imgui.IsKeyPressed(imgui.Key.D) then
            debug.open = not debug.open
        end
    end
end

local _update_ui = update_ui
function update_ui(paused, current_frame_run)
    _update_ui(paused, current_frame_run)

    if logger.window_open then
        logger.show_window()
    end

    if logger.overlay_open then
        logger.show_overlay()
    end

    if console.open and ce_settings.get("window_open_user_scripts") then
        uswindow.draw_user_scripts_window(console)
    end

    if magic_numbers and magic_numbers.open then
        magic_numbers.show()
    end

    if debug and debug.open then
        debug.show()
    end
end

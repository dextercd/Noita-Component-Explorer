---@module 'component-explorer.user_scripts'
local us = dofile_once("mods/component-explorer/user_scripts.lua")
---@module 'component-explorer.unsafe.user_scripts'
local us_unsafe = dofile_once("mods/component-explorer/unsafe/user_scripts.lua")

---@module 'component-explorer.utils.strings'
local string_util = dofile_once("mods/component-explorer/utils/strings.lua")

---@module 'component-explorer.unsafe.win32'
local win32 = dofile_once("mods/component-explorer/unsafe/win32.lua")

---@module 'component-explorer.utils.ce_settings'
local ce_settings = dofile_once("mods/component-explorer/utils/ce_settings.lua")

local uswindow = {}

local search = ""

function uswindow.draw_user_scripts_window()
    local should_show
    local open = ce_settings.get("window_open_user_scripts")
    should_show, open = imgui.Begin("User Scripts", open)
    ce_settings.set("window_open_user_scripts", open)

    if not should_show then
        return
    end

    if imgui.Button("Open script folder") then
        win32.explore(us.directory_path)
    end

    local _
    _, search = imgui.InputText("Search", search)

    local ret = nil

    local files = us_unsafe.get_scripts_tree()
    for _, file in ipairs(files) do
        if
            not us.is_hidden(file) and
            string_util.ifind(file, search, 1, true)
        then
            if imgui.Button(file) then
                ret = file
            end
        end
    end

    imgui.End()

    return ret
end

return uswindow

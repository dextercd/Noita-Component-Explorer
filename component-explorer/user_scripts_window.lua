local us = dofile_once("mods/component-explorer/user_scripts.lua")
local string_util = dofile_once("mods/component-explorer/utils/strings.lua")

local uswindow = {}

local search = ""

function uswindow.draw_user_scripts_window(console)
    local should_show
    should_show, console.user_scripts_open =
        imgui.Begin("User Scripts", console.user_scripts_open)

    if not should_show then
        return
    end

    local search_changed
    search_changed, search = imgui.InputText("Search", search)

    local ret = nil

    local files = us.get_scripts_tree()
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

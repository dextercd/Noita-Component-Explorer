---@module 'component-explorer.user_scripts'
local us = dofile_once("mods/component-explorer/user_scripts.lua")
---@module 'component-explorer.unsafe.user_scripts'
local us_unsafe = dofile_once("mods/component-explorer/unsafe/user_scripts.lua")

---@module 'component-explorer.utils.strings'
local string_util = dofile_once("mods/component-explorer/utils/strings.lua")

---@module 'component-explorer.utils.ce_settings'
local ce_settings = dofile_once("mods/component-explorer/utils/ce_settings.lua")

---@module 'component-explorer.repeat_scripts'
local repeat_scripts = dofile_once("mods/component-explorer/repeat_scripts.lua")


local uswindow = {}

local search = ""

---@param console Console
function uswindow.draw_user_scripts_window(console)
    local should_show
    local open = ce_settings.get("window_open_user_scripts")
    should_show, open = imgui.Begin("User Scripts", open)
    ce_settings.set("window_open_user_scripts", open)

    if not should_show then
        return
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
                console:run_command_text(us.user_script_call_string(file))
                console:scroll_to_bottom()
            end

            if imgui.BeginPopupContextItem() then
                local run_every = repeat_scripts.show_run_options()
                if run_every then
                    console:add_repeat_script(us.user_script_call_string(file), run_every)
                end
                imgui.EndPopup()
            end
        end
    end

    imgui.End()

    return ret
end

return uswindow

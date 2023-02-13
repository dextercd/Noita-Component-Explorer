local ffi = require("ffi")

local string_util = dofile_once("mods/component-explorer/utils/strings.lua")
local memory_display = dofile_once("mods/component-explorer/memory_display.lua")

dofile_once("mods/component-explorer/memory_type.lua")
dofile_once("mods/component-explorer/magic_number_items.lua")

window_open_magic_numbers = false

local search = ""

local function show_magic_items()
    for _, item in ipairs(developer_items) do
        if string_util.ifind(item.name, search, 1, true) then
            memory_display.show_item(item)
        end
    end
end

function show_magic_numbers()
    local should_show
    should_show, window_open_magic_numbers = imgui.Begin("Magic Numbers", window_open_magic_numbers)

    if should_show then
        local search_changed
        search_changed, search = imgui.InputText("Search", search)
        imgui.Separator()

        if imgui.BeginChild("magicinputs") then
            show_magic_items()
            imgui.EndChild()
        end
        imgui.End()
    end
end

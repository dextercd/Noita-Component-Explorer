local ffi = require("ffi")
local string_util = dofile_once("mods/component-explorer/string_util.lua")
dofile_once("mods/component-explorer/magic_number_items.lua")

window_open_magic_numbers = false

local search = ""

local function show_magic_item(item)
    if item.type == DeveloperType.bool_ then
        local location = ffi.cast("bool*", item.addr)
        local value = location[0]
        local changed
        imgui.SetNextItemWidth(180)
        changed, value = imgui.Checkbox(item.name, value)
        if changed then
            location[0] = value
        end
    elseif item.type == DeveloperType.uint32_t then
        local location = ffi.cast("uint32_t*", item.addr)
        local value = location[0]
        local changed
        imgui.SetNextItemWidth(180)
        changed, value = imgui.InputInt(item.name, value)
        if changed then
            location[0] = value
        end
    elseif item.type == DeveloperType.int_ then
        local location = ffi.cast("int*", item.addr)
        local value = location[0]
        local changed
        imgui.SetNextItemWidth(180)
        changed, value = imgui.InputInt(item.name, value)
        if changed then
            location[0] = value
        end
    elseif item.type == DeveloperType.float_ then
        local location = ffi.cast("float*", item.addr)
        local value = location[0]
        local changed
        imgui.SetNextItemWidth(180)
        changed, value = imgui.InputFloat(item.name, value)
        if changed then
            location[0] = value
        end
    elseif item.type == DeveloperType.double_ then
        local location = ffi.cast("double*", item.addr)
        local value = location[0]
        local changed
        imgui.SetNextItemWidth(180)
        changed, value = imgui.InputFloat(item.name, value)
        if changed then
            location[0] = value
        end
    end
end

local function show_magic_items()
    for _, item in ipairs(developer_items) do
        if string_util.ifind(item.name, search, 1, true) then
            show_magic_item(item)
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
        end
        imgui.End()
    end
end

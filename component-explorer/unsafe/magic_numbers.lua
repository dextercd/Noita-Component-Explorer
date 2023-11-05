---@module 'component-explorer.utils.strings'
local string_util = dofile_once("mods/component-explorer/utils/strings.lua")

---@module 'component-explorer.unsafe.memory_display'
local memory_display = dofile_once("mods/component-explorer/unsafe/memory_display.lua")

dofile_once("mods/component-explorer/unsafe/memory_type.lua")
dofile_once("mods/component-explorer/unsafe/magic_number_items.lua")


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
    local window_open_magic_numbers = GlobalsGetValue("ue.mn_window") == "1"
    should_show, window_open_magic_numbers = imgui.Begin("Magic Numbers", window_open_magic_numbers)

    GlobalsSetValue("ue.mn_window", window_open_magic_numbers and "1" or "0")

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

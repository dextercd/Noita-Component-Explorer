---@module 'component-explorer.utils.strings'
local string_util = dofile_once("mods/component-explorer/utils/strings.lua")

---@module 'component-explorer.unsafe.memory_display'
local memory_display = dofile_once("mods/component-explorer/unsafe/memory_display.lua")

dofile_once("mods/component-explorer/unsafe/memory_type.lua")
dofile_once("mods/component-explorer/unsafe/magic_number_items.lua")

magic_numbers = {}

local search = ""

local function show_magic_items()
    for _, item in ipairs(developer_items) do
        if string_util.ifind(item.name, search, 1, true) then
            memory_display.show_item(item)
        end
    end
end

magic_numbers.open = false

function magic_numbers.show()
    local should_show
    should_show, magic_numbers.open = imgui.Begin("Magic Numbers", magic_numbers.open)

    if should_show then
        local _
        _, search = imgui.InputText("Search", search)
        imgui.Separator()

        if imgui.BeginChild("magicinputs") then
            show_magic_items()
            imgui.EndChild()
        end
        imgui.End()
    end
end

return magic_numbers

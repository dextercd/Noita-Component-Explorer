local ffi = require("ffi")

---@module 'component-explorer.unsafe.win32'
local win32 = dofile_once("mods/component-explorer/unsafe/win32.lua")

local base = win32.get_base_address()

local memory_display = {}

function memory_display.show_item(item)
    if item.addr == nil then
        print("item.addr must not be nil.")
        return
    end

    local address = base + item.addr

    local location = nil

    if item.type == CE_MemoryType.bool_ then
        location = ffi.cast("bool*", address)
    elseif item.type == CE_MemoryType.uint32_t then
        location = ffi.cast("uint32_t*", address)
    elseif item.type == CE_MemoryType.uint8_t then
        location = ffi.cast("uint8_t*", address)
    elseif item.type == CE_MemoryType.int8_t then
        location = ffi.cast("int8_t*", address)
    elseif item.type == CE_MemoryType.int_ then
        location = ffi.cast("int*", address)
    elseif item.type == CE_MemoryType.float_ then
        location = ffi.cast("float*", address)
    elseif item.type == CE_MemoryType.double_ then
        location = ffi.cast("double*", address)
    end

    if location == nil then
        -- Unsuported type
        return
    end

    local value = location[0]
    local changed

    if item.type == CE_MemoryType.bool_ then
        imgui.SetNextItemWidth(180)
        changed, value = imgui.Checkbox(item.name, value)
    elseif
        item.type == CE_MemoryType.int_ or
        item.type == CE_MemoryType.uint32_t or
        item.type == CE_MemoryType.uint8_t or
        item.type == CE_MemoryType.int8_t
    then
        imgui.SetNextItemWidth(180)
        changed, value = imgui.InputInt(item.name, value)
    elseif item.type == CE_MemoryType.float_ then
        imgui.SetNextItemWidth(180)
        changed, value = imgui.InputFloat(item.name, value)
    elseif item.type == CE_MemoryType.double_ then
        imgui.SetNextItemWidth(180)
        changed, value = imgui.InputFloat(item.name, value)
    end

    if changed then
        location[0] = value
    end

end

return memory_display

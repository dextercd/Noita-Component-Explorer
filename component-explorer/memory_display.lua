local ffi = require("ffi")

local memory_display = {}

function memory_display.show_item(item)
    if item.addr == nil then
        print("item.addr must not be nil.")
        return
    end

    local location = nil

    if item.type == CE_MemoryType.bool_ then
        location = ffi.cast("bool*", item.addr)
    elseif item.type == CE_MemoryType.uint32_t then
        location = ffi.cast("uint32_t*", item.addr)
    elseif item.type == CE_MemoryType.uint8_t then
        location = ffi.cast("uint8_t*", item.addr)
    elseif item.type == CE_MemoryType.int8_t then
        location = ffi.cast("int8_t*", item.addr)
    elseif item.type == CE_MemoryType.int_ then
        location = ffi.cast("int*", item.addr)
    elseif item.type == CE_MemoryType.float_ then
        location = ffi.cast("float*", item.addr)
    elseif item.type == CE_MemoryType.double_ then
        location = ffi.cast("double*", item.addr)
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

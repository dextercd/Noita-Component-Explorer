local ffi = require("ffi")
local ouroborous = dofile_once("mods/component-explorer/unsafe/ouroboros.lua")

local get_global_addr = ouroborous.func_c_address(GlobalsGetValue)

local iter = ffi.cast("uint8_t*", get_global_addr)
for _=1,1500 do
    if  iter[0x0] == 0x8d and iter[0x1] == 0x4c and iter[0x2] == 0x24
    and iter[0x4] == 0xe8
    and iter[0x9] == 0x8b and iter[0xa] == 0x35
    then
        local rela_call = ffi.cast("int32_t*", iter + 5)[0]
        local next_instruction = iter + 0x9
        iter = next_instruction + rela_call
        goto stage2
    end

    iter = iter + 1
end

print("Couldn't find next 'GlobalsGetValue' stage")
do return {} end

::stage2::

local world_state

for _=1, 300 do
    if  iter[0x0] == 0x8b and iter[0x1] == 0x1d
    and iter[0x6] == 0x85 and iter[0x7] == 0xdb
    and iter[0x8] == 0x74
    then
        world_state = ffi.cast("uint8_t***", iter + 2)[0]
        goto stage3
    end

    iter = iter + 1
end

print("Couldn't find WorldStateComponent")
do return {} end

::stage3::

local world_state_lua_globals

for _=1, 200 do
    if  iter[0x0] == 0x8b and iter[0x1] == 0xf0
    and iter[0x2] == 0x3b and iter[0x3] == 0xb3
    and iter[0x8] == 0x74
    then
        world_state_lua_globals = ffi.cast("int32_t*", iter + 4)[0]
        goto stage4
    end

    iter = iter + 1

end

print("Couldn't find WorldStateComponent.lua_globals offset")
do return {} end

::stage4::

return {
    world_state = world_state,
    world_state_lua_globals = world_state_lua_globals,
}

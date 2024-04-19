local ffi = require("ffi")

---@module 'component-explorer.unsafe.stl'
local stl = dofile_once("mods/component-explorer/unsafe/stl.lua")

---@module 'component-explorer.unsafe.o_world_state'
local ws = dofile_once("mods/component-explorer/unsafe/o_world_state.lua")

---@module 'component-explorer.style'
local style = dofile_once("mods/component-explorer/style.lua")

---@module 'component-explorer.globals'
local globals = dofile_once("mods/component-explorer/globals.lua")

if not ws.world_state or not ws.world_state_lua_globals then
    return
end


local orig_extra = globals.extra
globals.extra = function(...)
    orig_extra(...)

    if style.danger_button("Scan existing") then
        local all_globals = stl.map_string_keys(
            ffi.cast("std_map*", ws.world_state[0] + ws.world_state_lua_globals)
        )

        for _, global in ipairs(all_globals) do
            if not globals.is_watching(global) then
                globals.watch(global)
            end
        end
    end
end

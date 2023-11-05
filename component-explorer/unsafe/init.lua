ModLuaFileAppend("mods/component-explorer/link_ui.lua", "mods/component-explorer/unsafe/appends/link_ui.lua")
ModLuaFileAppend("mods/component-explorer/main.lua", "mods/component-explorer/unsafe/appends/main.lua")
ModLuaFileAppend("mods/component-explorer/lua_console.lua", "mods/component-explorer/unsafe/appends/lua_console.lua")

function OnModPostInit()
    dofile("mods/component-explorer/unsafe/main.lua")
end

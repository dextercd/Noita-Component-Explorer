---@module 'component-explorer.utils.ce_settings'
local ce_settings = dofile_once("mods/component-explorer/utils/ce_settings.lua")

ModLuaFileAppend("mods/component-explorer/ui/link.lua", "mods/component-explorer/unsafe/appends/link.lua")
ModLuaFileAppend("mods/component-explorer/main.lua", "mods/component-explorer/unsafe/appends/main.lua")
ModLuaFileAppend("mods/component-explorer/lua_console.lua", "mods/component-explorer/unsafe/appends/lua_console.lua")
ModLuaFileAppend("mods/component-explorer/user_scripts.lua", "mods/component-explorer/unsafe/appends/user_scripts.lua")
ModLuaFileAppend("mods/component-explorer/globals.lua", "mods/component-explorer/unsafe/appends/globals.lua")

is_unsafe_explorer = true
dofile("mods/component-explorer/init.lua")

if ce_settings.get("logger_txt") then
    ModTextFileSetContent("mods/component-explorer/um.xml", [[
        <MagicNumbers
            DEBUG_LOG_INSTANT_FLUSH="1"
            />
        ]]
    )
    ModMagicNumbersFileAdd("mods/component-explorer/um.xml")
end

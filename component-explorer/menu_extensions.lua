local menu_extensions = {}

--[[

# Guide for modders

Have you written a Noita mod that uses imgui and can be useful for modding or science purposes?
In that case you have my permission to add your mod into Component Explorer's 'View' menu.
This makes it easy for users to find your tool in a well known and convenient place.

## How-to

For the purposes of this guide, we're adding a menu entry for an imaginary mod named 'mymod'.

Inside 'mods/mymod/init.lua' add a line like this:

ModLuaFileAppend(
    "mods/component-explorer/menu_extensions.lua",
    "mods/mymod/ce_menu_entry.lua"
)

Note that you don't need to check if Component Explorer is enabled to do the append.
It'll not have any effect if you run the append when the mod isn't active or installed.

Next, inside 'mods/mymod/ce_menu_entry.lua' add the following:

local menu_extensions = dofile_once("mods/component-explorer/menu_extensions.lua")
menu_extensions.list[#menu_extensions.list+1] = {
    category = "My Name",
    name = "My Mod",
    is_enabled = function()
        -- Tells CE whether the mod's main window is currently visible.
        -- Need to use a method that's visible across mod contexts.
        -- For instance: globals, mod settings, run flags, or persistent flags.
        return GlobalsGetValue("MYMOD_MAIN_WINDOW") == "1"
    end,
    set_enabled = function(enabled)
        -- CE is telling you whether the user enabled or disabled your entry.
        GlobalsSetValue("MYMOD_MAIN_WINDOW", enabled and "1" or "0")
    end,
    -- These are optional. Please be careful with adding new shortcuts since
    -- it's easy to step on someone else's toes with this.
    shortcut = "CTRL+SHIFT+N",
    check_shortcut = function()
        return imgui.IsKeyPressed(imgui.Key.N)
    end
}

And the should be all you need. When you start the game with mymod and Component
Explorer active, mymod should show up in the 'View' menu.

Please only add entries to menu_extensions.list and don't mess with entries
added by other people.

## Contact

Hopefully the above works for you but if it doesn't you can contact me on GitHub
and Discord.

GitHub: https://github.com/dextercd/Noita-Component-Explorer/issues

Discord: dextercd or the CE forum post on the Noita Discord
       : https://discord.com/channels/453998283174576133/1021520048495542322

]]

---@class MenuExtension
---@field category string
---@field name string
---@field is_enabled fun(): boolean
---@field set_enabled fun(enabled: boolean)
---@field shortcut string?
---@field check_shortcut (fun(): boolean)?

---@type MenuExtension[]
menu_extensions.list = {}

if ModIsEnabled("kae_waypoint") then
    menu_extensions.list[#menu_extensions.list+1] = {
        category = "Kaedenn",
        name = "Teleport to Anything",
        is_enabled = function()
            return not not ModSettingGet("kae_waypoint.enable")
        end,
        set_enabled = function(enabled)
            ModSettingSetNextValue("kae_waypoint.enable", enabled, false)
        end,
        shortcut = "CTRL+SHIFT+T",
        check_shortcut = function()
            return imgui.IsKeyPressed(imgui.Key.T)
        end
    }
end

if ModIsEnabled("world_radar") then
    menu_extensions.list[#menu_extensions.list+1] = {
        category = "Kaedenn",
        name = "World Information Scanner",
        is_enabled = function()
            return not not ModSettingGet("world_radar.enable")
        end,
        set_enabled = function(enabled)
            ModSettingSetNextValue("world_radar.enable", enabled, false)
        end
    }
end

return menu_extensions

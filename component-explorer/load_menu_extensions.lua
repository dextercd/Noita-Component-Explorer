-- See mods/component-explorer/menu_extensions.lua if you want to add your mod
-- to Component Explorer's 'View' menu. Don't mess with this file.

---@module 'component-explorer.utils.copy'
local copy = dofile_once("mods/component-explorer/utils/copy.lua")

---@module 'component-explorer.menu_extensions'
local menu_extensions = dofile_once("mods/component-explorer/menu_extensions.lua")

---@class LoadedMenuExtension : MenuExtension
---@field original_order integer

---@type LoadedMenuExtension[]
local loaded_extensions = {}

local string_or_nil = {["string"]=1, ["nil"]=1}
local function_or_nil = {["function"]=1, ["nil"]=1}

for index, extension in ipairs(menu_extensions.list) do
    ---@type LoadedMenuExtension
    local loaded = copy.shallow_copy(extension)

    -- Makes no sense to set one but not the other
    if not loaded.shortcut or not loaded.check_shortcut then
        loaded.shortcut = nil
        loaded.check_shortcut = nil
    end

    loaded.original_order = index

    if  type(loaded.category) == "string"
    and type(loaded.name) == "string"
    and type(loaded.is_enabled) == "function"
    and type(loaded.set_enabled) == "function"
    and string_or_nil[type(loaded.shortcut)]
    and function_or_nil[type(loaded.check_shortcut)]
    then
        loaded_extensions[#loaded_extensions+1] = loaded
    else
        print("Couldn't load extension " .. tostring(loaded.name)
              .. " because of a type mismatch")
    end
end

table.sort(loaded_extensions, function(a, b)
    if a.category < b.category then return true end
    if a.category > b.category then return false end
    return a.original_order < b.original_order
end)

for _, ext in ipairs(loaded_extensions) do
    if ext.shortcut then
        -- You used to have to include 'CTRL+SHIFT+' in the shortcut text. Now
        -- that part of the keybind is configurable so you shouldn't include it
        -- in the menu extensions shortcut text
        ext.shortcut = ext.shortcut:gsub("^ *[cC][tT][rR][lL] *%+ *[sS][hH][iI][fF][tT] *%+ *", "")
    end
end

return loaded_extensions

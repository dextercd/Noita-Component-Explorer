---@module 'component-explorer.ui.link'
local link = dofile_once("mods/component-explorer/ui/link.lua")

---@module 'component-explorer.unsafe.win32'
local win32 = dofile_once("mods/component-explorer/unsafe/win32.lua")

link.open_link = function(url)
    win32.open(url)
end

---@module 'component-explorer.link_ui'
local link_ui = dofile_once("mods/component-explorer/link_ui.lua")

---@module 'component-explorer.unsafe.win32'
local win32 = dofile_once("mods/component-explorer/unsafe/win32.lua")

link_ui.open_link = function(url)
    win32.open(url)
end

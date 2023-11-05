---@module 'component-explorer.link_ui'
local link_ui = dofile_once("mods/component-explorer/link_ui.lua")

link_ui.open_link = function(url)
    -- Pass value to the unsafe mod which can actually open it
    GlobalsSetValue("ue.link", url)
end

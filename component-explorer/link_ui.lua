local win32 = dofile_once("mods/component-explorer/utils/win32.lua")

local link_ui = {}

function link_ui.button(label, url)
    imgui.Text(label .. ": " .. url)
    imgui.SameLine()
    if imgui.SmallButton("Copy") then
        imgui.SetClipboardText(url)
    end
    imgui.SameLine()
    if imgui.SmallButton("Open") then
        win32.open(url)
    end
end

function link_ui.menu_item(label, extra, url)
    if imgui.MenuItem(label, extra) then
        win32.open(url)
    end
end

return link_ui

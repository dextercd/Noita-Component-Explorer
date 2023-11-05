local link_ui = {}

link_ui.open_link = nil

function link_ui.button(label, url)
    imgui.Text(label .. ": " .. url)
    imgui.SameLine()
    if imgui.SmallButton("Copy") then
        imgui.SetClipboardText(url)
    end

    if link_ui.open_link then
        imgui.SameLine()
        if imgui.SmallButton("Open") then
            link_ui.open_link(url)
        end
    end
end

function link_ui.menu_item(label, extra, url)
    if imgui.MenuItem(label, extra) then
        if link_ui.open_link then
            link_ui.open_link(url)
        else
            imgui.SetClipboardText(url)
        end
    end
end

return link_ui

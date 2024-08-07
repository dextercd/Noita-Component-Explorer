local link = {}

link.open_link = nil

function link.button(label, url)
    imgui.Text(label .. ": " .. url)
    imgui.SameLine()
    if imgui.SmallButton("Copy") then
        imgui.SetClipboardText(url)
    end

    if link.open_link then
        imgui.SameLine()
        if imgui.SmallButton("Open") then
            link.open_link(url)
        end
    end
end

function link.text_link(fallback_label, url, link_label)
    if imgui.TextLinkOpenURL then
        if link_label then
            imgui.TextLinkOpenURL(link_label, url)
        else
            imgui.TextLinkOpenURL(url)
        end
    else
        link.button(fallback_label, url)
    end
end

function link.menu_item(label, extra, url)
    if imgui.MenuItem(label, extra) then
        if link.open_link then
            link.open_link(url)
        else
            imgui.SetClipboardText(url)
        end
    end
end

return link

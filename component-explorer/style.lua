local style = {}

style.colour_fail = {1, 0.4, 0.4, 1}
style.colour_danger = style.colour_fail
style.colour_warn = {0.96, 0.94, 0, 1}

local function danger_button_ex(text, buttonfn)
    imgui.PushStyleColor(imgui.Col.Button, 1, 0.4, 0.4)
    imgui.PushStyleColor(imgui.Col.ButtonHovered, 1, 0.6, 0.6)
    imgui.PushStyleColor(imgui.Col.ButtonActive, 0.8, 0.4, 0.4)
    local ret = buttonfn(text)
    imgui.PopStyleColor(3)

    return ret
end

function style.danger_button(text)
    return danger_button_ex(text , imgui.Button)
end

function style.danger_small_button(text)
    return danger_button_ex(text , imgui.SmallButton)
end

return style

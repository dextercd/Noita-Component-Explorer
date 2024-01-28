local help = {}

---@param desc string
function help.tooltip(desc)
    if imgui.IsItemHovered() then
        if imgui.BeginTooltip() ~= false then
            imgui.PushTextWrapPos(400)
            imgui.Text(desc)
            imgui.PopTextWrapPos()
            imgui.EndTooltip()
        end
    end
end

---@param desc string
function help.exclam_marker(desc)
    imgui.TextDisabled("(!)")
    help.tooltip(desc)
end

---@param desc string
function help.marker(desc)
    imgui.TextDisabled("(?)")
    help.tooltip(desc)
end

return help

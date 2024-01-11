local ui_combo = {}

---Combo list with an --All-- option that corresponds to nil.
---@param label string
---@param list string[]
---@param value string?
---@param default_name string?
---@return boolean
---@return string?
function ui_combo.optional(label, list, value, default_name)
    default_name = default_name or "--All--"
    local changed = false
    if imgui.BeginCombo(label, value or default_name) then
        if imgui.Selectable(default_name, value == nil) then
            changed = true
            value = nil
        end

        for _, item in ipairs(list) do
            if imgui.Selectable(item, value == item) then
                changed = true
                value = item
            end
        end
        imgui.EndCombo()
    end

    return changed, value
end

return ui_combo

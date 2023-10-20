local settings_value = {}

---@alias SettingsType "string" | "number" | "boolean" | "nil"

---@type SettingsType[]
local SettingsTypes = {
    "string", "number", "boolean", "nil"
}

---@class SettingsValue
---@field type SettingsType
---@field string_value string
---@field number_value number
---@field boolean_value boolean
local SettingsValue = {}
SettingsValue.__index = SettingsValue

---@return SettingsValue
---@nodiscard
function SettingsValue.new()
    return setmetatable({
        type="string",
        string_value="",
        number_value=0,
        boolean_value=false,
    }, SettingsValue)
end

---@param value string|number|boolean|nil
---@return SettingsValue
---@nodiscard
function SettingsValue.from_lua_value(value)
    local vt = type(value)
    local setting = setmetatable({
        type=vt,
        string_value="",
        number_value=0,
        boolean_value=false,
    }, SettingsValue)

    if vt == "string" then
        setting.string_value = value
    elseif vt == "number" then
        setting.number_value = value
    elseif vt == "boolean" then
        setting.boolean_value = value
    else
        setting.type = "nil"
    end

    return setting
end

---@return string|number|boolean|nil
---@nodiscard
function SettingsValue:to_lua_value()
    if self.type == "string" then
        return self.string_value
    elseif self.type == "number" then
        return self.number_value
    elseif self.type == "boolean" then
        return self.boolean_value
    end

    return nil
end

---Shows the setting allowing the user to change type or stored value.
---Setting is modified in-place.
---@return boolean changed True if the value changed
function SettingsValue:show(name)
    imgui.Text(name .. ": ")
    imgui.SameLine()

    imgui.PushID(name)
    imgui.BeginGroup()

    if imgui.BeginCombo("Type", self.type) then
        for _, settings_type in ipairs(SettingsTypes) do
            local is_selected = settings_type == self.type
            if imgui.Selectable(settings_type, is_selected) then
                self.type = settings_type
            end
        end
        imgui.EndCombo()
    end

    local changed = false
    if self.type == "string" then
        local line_height = imgui.GetTextLineHeight()
        changed, self.string_value = imgui.InputTextMultiline("Value", self.string_value, 0, 4 * line_height)
    elseif self.type == "number" then
        changed, self.number_value = imgui.InputDouble("Value", self.number_value)
    elseif self.type == "boolean" then
        changed, self.boolean_value = imgui.Checkbox("Value", self.boolean_value)
    else
        imgui.Text("nil")
    end

    imgui.EndGroup()
    imgui.PopID()

    return changed
end

settings_value.SettingsValue = SettingsValue

return settings_value

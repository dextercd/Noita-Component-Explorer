---@module 'component-explorer.deps.datadumper'
local stringify = dofile_once("mods/component-explorer/deps/datadumper.lua")
---@module 'component-explorer.ui.helpers'
local ui_helpers = dofile_once("mods/component-explorer/ui/helpers.lua")
---@module 'component-explorer.settings_value'
local sv = dofile_once("mods/component-explorer/settings_value.lua")
---@module 'component-explorer.style'
local style = dofile_once("mods/component-explorer/style.lua")

local modal_create_setting = {}

---@class EditSettingModal
---@field type "edit"
---@field open boolean
---@field setting_id string
---@field start_value string|number|boolean|nil
---@field start_next_value string|number|boolean|nil
---@field same boolean
---@field new_value SettingsValue
---@field new_next_value SettingsValue
local Modal = {
    type = "edit",
}
Modal.__index = Modal

---@return EditSettingModal
---@nodiscard
function Modal.new(setting_id, value, next_value)
    return setmetatable({
        open = true,
        setting_id = setting_id,
        start_value = value,
        start_next_value = next_value,
        same = value == next_value,
        new_value = sv.SettingsValue.from_lua_value(value),
        new_next_value = sv.SettingsValue.from_lua_value(next_value),
    }, Modal)
end

---Chosen values with self.same logic applied.
---@return string|number|boolean|nil value
---@return string|number|boolean|nil next
---@nodiscard
function Modal:chosen_values()
    local value = self.new_value:to_lua_value()
    local next
    if self.same then
        next = value
    else
        next = self.new_next_value:to_lua_value()
    end

    return value, next
end

---@return boolean # Whether both values are nil which isn't possible to create via the API.
---@nodiscard
function Modal:both_nil()
    local a, b = self:chosen_values()
    return a == nil and b == nil
end

---@param still_exists boolean
---@param current_value string|number|boolean|nil
---@param current_next_value string|number|boolean|nil
function Modal:show(still_exists, current_value, current_next_value)
    local window_id = "###edit_mod_setting"
    local title = "Edit mod setting: " .. self.setting_id .. window_id

    if not imgui.IsPopupOpen(window_id) then
        imgui.OpenPopup(window_id)
    end

    ui_helpers.window_appear_center()
    local should_show
    should_show, self.open = imgui.BeginPopupModal(title, true, imgui.WindowFlags.AlwaysAutoResize)

    if not should_show then
        return
    end

    imgui.Text("Setting ID: " .. self.setting_id)

    imgui.Text("Current value: (" .. type(current_value) .. ") " .. stringify(current_value, ""))
    imgui.Text("Current next value: (" .. type(current_next_value) .. ") " .. stringify(current_next_value, ""))
    imgui.Text("")

    if self.start_value ~= current_value
    or self.start_next_value ~= current_next_value
    then
        imgui.PushStyleColor(imgui.Col.Text, unpack(style.colour_warn))
        imgui.Text("Warning: Mod setting changed value while modal was open.")
        imgui.Text("")
        imgui.PopStyleColor()
    end

    local _
    _, self.same = imgui.Checkbox("Make value and next the same", self.same)

    self.new_value:show("Value")

    if not self.same then
        self.new_next_value:show("Next value")
    else
        imgui.Text("Next: " .. stringify(self.new_value:to_lua_value(), ""))
    end

    local both_nil = self:both_nil()
    if both_nil then
        imgui.PushStyleColor(imgui.Col.Text, unpack(style.colour_warn))
        imgui.Text("Can't have value and next both be nil")
        imgui.PopStyleColor()
    end

    if both_nil then imgui.BeginDisabled() end

    if imgui.Button("Edit setting") then
        ModSettingRemove(self.setting_id)

        local value, next = self:chosen_values()
        if value ~= nil then
            ModSettingSet(self.setting_id, value)
        end
        if next ~= nil then
            ModSettingSetNextValue(self.setting_id, next, false)
        end
        self.open = false
    end

    if both_nil then imgui.EndDisabled() end

    imgui.SameLine()
    if imgui.Button("Cancel") then
        self.open = false
    end

    imgui.EndPopup()
end

modal_create_setting.Modal = Modal

return modal_create_setting

---@module 'component-explorer.deps.datadumper'
local stringify = dofile_once("mods/component-explorer/deps/datadumper.lua")
---@module 'component-explorer.ui.helpers'
local ui_helpers = dofile_once("mods/component-explorer/ui/helpers.lua")
---@module 'component-explorer.settings_value'
local sv = dofile_once("mods/component-explorer/settings_value.lua")
---@module 'component-explorer.style'
local style = dofile_once("mods/component-explorer/style.lua")

local modal_create_setting = {}

---@class CreateSettingModal
---@field type "create"
---@field open boolean
---@field setting_id string
---@field same boolean
---@field value SettingsValue
---@field next_value SettingsValue
local Modal = {
    type = "create",
}
Modal.__index = Modal

---@return CreateSettingModal
---@nodiscard
function Modal.new()
    return setmetatable({
        open = true,
        setting_id = "",
        same = true,
        value = sv.SettingsValue.new(),
        next_value = sv.SettingsValue.new(),
    }, Modal)
end

---Chosen values with self.same logic applied.
---@return string|number|boolean|nil value
---@return string|number|boolean|nil next
---@nodiscard
function Modal:chosen_values()
    local value = self.value:to_lua_value()
    local next
    if self.same then
        next = value
    else
        next = self.next_value:to_lua_value()
    end

    return value, next
end

---@return boolean # Whether both values are nil which isn't possible to create via the API.
---@nodiscard
function Modal:both_nil()
    local a, b = self:chosen_values()
    return a == nil and b == nil
end

---@param exists boolean Setting with ID already exists
function Modal:show(exists)
    local title = "Create mod setting"

    if not imgui.IsPopupOpen(title) then
        imgui.OpenPopup(title)
    end

    ui_helpers.window_appear_center()
    local should_show
    should_show, self.open = imgui.BeginPopupModal(title, true, imgui.WindowFlags.AlwaysAutoResize)

    if not should_show then
        return
    end

    local _

    _, self.setting_id = imgui.InputText("Setting ID", self.setting_id)

    if self.setting_id == "" then
        imgui.Text("Setting ID can't be an empty string")
    end

    if exists then
        imgui.PushStyleColor(imgui.Col.Text, unpack(style.colour_warn))
        imgui.Text("Setting with this ID already exists")
        imgui.PopStyleColor()
    end

    local invalid_setting_id = self.setting_id == "" or exists

    _, self.same = imgui.Checkbox("Make value and next the same", self.same)

    self.value:show("Value")

    if not self.same then
        self.next_value:show("Next value")
    else
        imgui.Text("Next: " .. stringify(self.value:to_lua_value(), ""))
    end

    local both_nil = self:both_nil()
    if both_nil then
        imgui.PushStyleColor(imgui.Col.Text, unpack(style.colour_warn))
        imgui.Text("Can't have value and next both be nil")
        imgui.PopStyleColor()
    end

    local disabled = invalid_setting_id or both_nil
    if disabled then imgui.BeginDisabled() end

    if imgui.Button("Create setting") then
        local value, next = self:chosen_values()
        if value ~= nil then
            ModSettingSet(self.setting_id, value)
        end
        if next ~= nil then
            ModSettingSetNextValue(self.setting_id, next, false)
        end
        self.open = false
    end

    if disabled then imgui.EndDisabled() end

    imgui.SameLine()
    if imgui.Button("Cancel") then
        self.open = false
    end

    imgui.EndPopup()
end

modal_create_setting.Modal = Modal

return modal_create_setting

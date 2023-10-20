---@module 'component-explorer.deps.datadumper'
local stringify = dofile_once("mods/component-explorer/deps/datadumper.lua")
---@module 'component-explorer.style'
local style = dofile_once("mods/component-explorer/style.lua")
---@module 'component-explorer.ui.helpers'
local ui_helpers = dofile_once("mods/component-explorer/ui/helpers.lua")

local modal_delete_mod_setting = {}

---@class DeleteSettingModal
---@field type "delete"
---@field open boolean
---@field setting_id string
---@field start_value string|number|boolean|nil
---@field start_next_value string|number|boolean|nil
local Modal = {
    type = "delete"
}
Modal.__index = Modal

---@return DeleteSettingModal
---@nodiscard
function Modal.new(setting_id, value, next_value)
    return setmetatable({
        open = true,
        setting_id = setting_id,
        start_value = value,
        start_next_value = next_value,
    }, Modal)
end

---@param still_exists boolean
---@param current_value string|number|boolean|nil
---@param current_next_value string|number|boolean|nil
function Modal:show(still_exists, current_value, current_next_value)
    if not still_exists then
        -- Oh.. it's gone already..
        self.open = false
        return
    end

    local window_id = "###delete_mod_setting"
    local title = "Delete mod setting: " .. self.setting_id .. window_id

    if not imgui.IsPopupOpen(window_id) then
        imgui.OpenPopup(window_id)
    end

    ui_helpers.window_appear_center()
    local should_show
    should_show, self.open = imgui.BeginPopupModal(title, true, imgui.WindowFlags.AlwaysAutoResize)

    if not should_show then return end

    imgui.Text("Do you want to delete the following mod setting?")
    imgui.Text("")
    imgui.Text("ID: " .. self.setting_id)
    imgui.Text("Value: (" .. type(current_value) .. ") " .. stringify(current_value, ""))
    imgui.Text("Next value: (" .. type(current_next_value) .. ") " .. stringify(current_next_value, ""))
    imgui.Text("")

    if self.start_value ~= current_value
    or self.start_next_value ~= current_next_value
    then
        imgui.PushStyleColor(imgui.Col.Text, unpack(style.colour_warn))
        imgui.Text("Warning: Mod setting changed value while modal was open.")
        imgui.Text("")
        imgui.PopStyleColor()
    end

    if style.danger_button("Delete") then
        ModSettingRemove(self.setting_id)
        self.open = false
    end

    imgui.SameLine()
    if imgui.Button("Cancel") then
        self.open = false
    end

    imgui.EndPopup()
end

modal_delete_mod_setting.Modal = Modal

return modal_delete_mod_setting

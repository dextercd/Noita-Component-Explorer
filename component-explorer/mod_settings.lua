---@module 'component-explorer.deps.datadumper'
local stringify = dofile_once("mods/component-explorer/deps/datadumper.lua")
---@module 'component-explorer.utils.strings'
local string_util = dofile_once("mods/component-explorer/utils/strings.lua")
---@module 'component-explorer.style'
local style = dofile_once("mods/component-explorer/style.lua")
---@module 'component-explorer.mod_setting_modals.delete'
local modal_delete = dofile_once("mods/component-explorer/mod_setting_modals/delete.lua")
---@module 'component-explorer.mod_setting_modals.create'
local modal_create = dofile_once("mods/component-explorer/mod_setting_modals/create.lua")
---@module 'component-explorer.mod_setting_modals.edit'
local modal_edit = dofile_once("mods/component-explorer/mod_setting_modals/edit.lua")
---@module 'component-explorer.ui.help'
local help = dofile_once("mods/component-explorer/ui/help.lua")

local mod_settings = {}

mod_settings.open = false

local search = ""
local accepted_risk = false

---@type nil|DeleteSettingModal|CreateSettingModal|EditSettingModal
local modal = nil

local queued_deletes = {}
local function queue_setting_delete(setting_id)
    table.insert(queued_deletes, setting_id)
end

local function mod_table_item(idx, id, value, next_value)
    imgui.PushID(idx)

    imgui.TableNextColumn()
    imgui.Text(id)

    imgui.TableNextColumn()
    imgui.Text(type(value))

    imgui.TableNextColumn()
    imgui.Text(stringify(value, ""))

    imgui.TableNextColumn()
    imgui.Text(type(next_value))

    imgui.TableNextColumn()
    imgui.Text(stringify(next_value, ""))

    imgui.TableNextColumn()

    local alternate = imgui.IsKeyDown(imgui.Key.LeftShift)

    local copy = imgui.SmallButton("Copy")
    if imgui.IsItemHovered() then
        if alternate then
            help.tooltip("Release shift to copy 'Value'")
        else
            help.tooltip("Hold shift to copy 'Next value'")
        end
    end
    if copy then
        if alternate then
            imgui.SetClipboardText(tostring(next_value))
        else
            imgui.SetClipboardText(tostring(value))
        end
    end

    if accepted_risk then
        imgui.SameLine()
        if imgui.SmallButton("Edit") then
            modal = modal_edit.Modal.new(id, value, next_value)
        end

        imgui.SameLine()
        if alternate then
            if style.danger_small_button("!") then
                queue_setting_delete(id)
            end

            if imgui.IsItemHovered() then
                imgui.PushStyleColor(imgui.Col.Text, unpack(style.colour_danger))
                help.tooltip("NOTE! Clicking this will erase without confirmation dialog!")
                imgui.PopStyleColor()
            end
        else
            if style.danger_small_button("X") then
                modal = modal_delete.Modal.new(id, value, next_value)
            end
            if imgui.IsItemHovered() then
                help.tooltip("Hold shift to skip confirmation dialog")
            end
        end
    end

    imgui.PopID()
end

function mod_settings.show()
    local should_show
    should_show, mod_settings.open = imgui.Begin("Mod Settings", mod_settings.open)

    if not should_show then
        return
    end

    imgui.TextWrapped(
        "Unless you know what you're doing, " ..
        "you should only change mod settings using that mod's intended methods. " ..
        "If you mess up you might have to delete all setting related to a mod, " ..
        "or even erase your entire save00/mod_settings.bin file."
    )

    local color_danger_mode = accepted_risk
    if color_danger_mode then
        imgui.PushStyleColor(imgui.Col.Text, unpack(style.colour_danger))
    end

    local _

    _, accepted_risk = imgui.Checkbox(
        "I understand the risks and still wish to edit mod settings",
        accepted_risk)

    if color_danger_mode then
        imgui.PopStyleColor()
    end

    imgui.Separator()

    _, search = imgui.InputText("Search", search)

    if accepted_risk then
        if imgui.Button("Create Setting...") then
            modal = modal_create.Modal.new()
        end
    end

    local table_flags = bit.bor(imgui.TableFlags.Resizable, imgui.TableFlags.RowBg)
    local column_count = 6
    if imgui.BeginTable("modsettings", column_count, table_flags) then
        imgui.TableSetupColumn("ID")
        imgui.TableSetupColumn("Type")
        imgui.TableSetupColumn("Value")
        imgui.TableSetupColumn("Next type")
        imgui.TableSetupColumn("Next value")
        imgui.TableSetupColumn("Actions")
        imgui.TableHeadersRow()

        local filtered_items = {}

        for setting_idx=0,ModSettingGetCount()-1 do
            local id, value, next_value = ModSettingGetAtIndex(setting_idx)

            if string_util.ifind(id, search, 1, true) then
                table.insert(filtered_items, {setting_idx, id, value, next_value})
            end
        end

        local clipper = imgui.ListClipper.new()
        clipper:Begin(#filtered_items)
        while clipper:Step() do
            for i=clipper.DisplayStart,clipper.DisplayEnd - 1 do
                local setting_idx, id, value, next_value = unpack(filtered_items[i + 1])
                mod_table_item(setting_idx, id, value, next_value)
            end
        end

        imgui.EndTable()

        local modal_current_value = nil
        local modal_current_next_value = nil
        local modal_setting_exists = false

        for setting_idx=0,ModSettingGetCount()-1 do
            local id, value, next_value = ModSettingGetAtIndex(setting_idx)
            if modal and modal.setting_id == id then
                modal_setting_exists = true
                modal_current_value = value
                modal_current_next_value = next_value
            end
        end

        if modal then
            if modal.type == "delete" then
                modal:show(modal_setting_exists, modal_current_value, modal_current_next_value)
            elseif modal.type == "create" then
                modal:show(modal_setting_exists)
            elseif modal.type == "edit" then
                modal:show(modal_setting_exists, modal_current_value, modal_current_next_value)
            end

            if not modal.open then
                -- Modal is now closed
                modal = nil
            end
        end
    end

    for _, v in ipairs(queued_deletes) do
        ModSettingRemove(v)
    end
    queued_deletes = {}

    imgui.End()
end

return mod_settings

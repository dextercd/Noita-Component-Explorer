---@module 'component-explorer.utils.eval'
local eval = dofile_once("mods/component-explorer/utils/eval.lua")

---@module 'component-explorer.utils.eval'
local math_util = dofile_once("mods/component-explorer/utils/math_util.lua")

---@module 'component-explorer.style'
local style = dofile_once("mods/component-explorer/style.lua")

---@module 'component-explorer.utils.copy'
local copy = dofile_once("mods/component-explorer/utils/copy.lua")

---@module 'component-explorer.deps.datadumper'
local stringify = dofile_once("mods/component-explorer/deps/datadumper.lua")

---@module 'component-explorer.ui.helpers'
local ui_helpers = dofile_once("mods/component-explorer/ui/helpers.lua")

local NAME_TAKEN_ERROR = "This name is already taken"

local repeat_scripts = {}

repeat_scripts.all_pause = false
repeat_scripts.open = false

---@class RepeatScriptOptions
---@field paused boolean
---@field output_in_console boolean

---@class RepeatScript
---@field name string
---@field using_auto_name boolean
---@field script_text string
---@field func function
---@field period integer
---@field offset integer
---@field options RepeatScriptOptions
---@field last_run_result any
---@field last_run_success boolean
--
---@class EditRepeatScriptModal
---@field editing_script RepeatScript?
---@field open boolean
---@field name string
---@field script_text string
---@field period integer
---@field offset integer
---@field options RepeatScriptOptions
---@field script_error string?
---@field name_error string?
local EditRepeatScriptModal = {}
EditRepeatScriptModal.__index = EditRepeatScriptModal

---@param editing_script RepeatScript?
---@return EditRepeatScriptModal
function EditRepeatScriptModal.new(editing_script)
    local name = ""
    if editing_script and not editing_script.using_auto_name then
        name = editing_script.name
    end

    local options = editing_script and copy.shallow_copy(editing_script.options)
    if not options then
        options = {
            paused = false,
            output_in_console = false,
        }
    end

    return setmetatable({
        editing_script = editing_script,
        open = true,
        name = name,
        script_text = editing_script and editing_script.script_text or "",
        period = editing_script and editing_script.period or 60,
        offset = editing_script and editing_script.offset or 0,
        options = options,
    }, EditRepeatScriptModal)
end

function EditRepeatScriptModal:show()
    local title = self.editing_script
        and "Editing repeat script: " .. self.editing_script.name
        or "New repeat script: " .. self.name .. "###new_repeat_script"

    if not imgui.IsPopupOpen(title) then
        imgui.OpenPopup(title)
    end

    ui_helpers.window_appear_center()
    local should_show
    should_show, self.open = imgui.BeginPopupModal(title, true, imgui.WindowFlags.AlwaysAutoResize)
    if not should_show then
        return
    end

    local nc
    nc, self.name = imgui.InputText("Name", self.name)

    if nc then self.name_error = nil end

    local name_taken = false
    if self.name ~= "" then
        for _, script in ipairs(repeat_scripts.scripts) do
            if script ~= self.editing_script and script.name == self.name then
                name_taken = true
                break
            end
        end
    end

    if self.name_error then
        imgui.PushStyleColor(imgui.Col.Text, unpack(style.colour_fail))
        imgui.Text(self.name_error)
        imgui.PopStyleColor()
    elseif name_taken then
        imgui.PushStyleColor(imgui.Col.Text, unpack(style.colour_fail))
        imgui.Text(NAME_TAKEN_ERROR)
        imgui.PopStyleColor()
    end

    local line_height = imgui.GetTextLineHeight()
    imgui.PushItemWidth(-1)
    local script_changed
    script_changed, self.script_text = imgui.InputTextMultiline("##scr", self.script_text, -1, line_height * 7)
    imgui.PopItemWidth()

    if script_changed then
        self.script_error = nil
    end

    if self.script_error then
        imgui.PushStyleColor(imgui.Col.Text, unpack(style.colour_fail))
        imgui.TextWrapped(self.script_error)
        imgui.PopStyleColor()
    end

    local pause_title = self.editing_script and "Pause script" or "Start paused"
    _, self.options.paused = imgui.Checkbox(pause_title, self.options.paused)
    _, self.options.output_in_console = imgui.Checkbox("Show output in console", self.options.output_in_console)

    _, self.period = imgui.InputInt("Period", self.period)

    imgui.SameLine()
    _, self.offset = imgui.InputInt("Offset", self.offset)

    self.period = math.max(1, self.period)
    self.offset = math_util.clamp(self.offset, 0, self.period - 1)

    imgui.Separator()

    if name_taken then
        imgui.BeginDisabled()
    end

    if self.editing_script then
        if imgui.Button("Save changes") then
            local func, error = eval.loadstring_ish(self.script_text)
            if func then
                local name, using_auto = repeat_scripts.decide_name(self.name, self.script_text)
                self.editing_script.name = name
                self.editing_script.using_auto_name = using_auto
                self.editing_script.script_text = self.script_text
                self.editing_script.func = func
                self.editing_script.period = self.period
                self.editing_script.offset = self.offset
                self.editing_script.options = self.options
                self.open = false
            else
                self.script_error = error
            end
        end
        imgui.SameLine()
    end

    local new_title = self.editing_script and "Save as new" or "Create"

    if imgui.Button(new_title) then
        local success, error = repeat_scripts.add_script(
            self.name, self.script_text, self.period, self.offset, self.options)

        if success then
            self.open = false
        elseif error then
            self.script_error = error.script
            self.name_error = error.name
        end
    end

    if name_taken then
        imgui.EndDisabled()
    end

    imgui.EndPopup()
end

---@type RepeatScript[]
repeat_scripts.scripts = {}
local remove_script_nr

---@type EditRepeatScriptModal?
local modal

---@param script RepeatScript
function repeat_scripts.show_script_menu(script)
    if imgui.MenuItem("Edit...") then
        modal = EditRepeatScriptModal.new(script)
    end

    if imgui.MenuItem("Copy script") then
        imgui.SetClipboardText(script.script_text)
    end

    if imgui.MenuItem("Copy last result") then
        imgui.SetClipboardText(stringify(script.last_run_result, ""))
    end

    local _
    _, script.options.paused = imgui.MenuItem("Pause", "", script.options.paused)
    _, script.options.output_in_console = imgui.MenuItem("Output in console", "", script.options.output_in_console)
    imgui.PushStyleColor(imgui.Col.Text, unpack(style.colour_danger))
    if imgui.MenuItem("Remove") then
        for nr, s in ipairs(repeat_scripts.scripts) do
            if s == script then
                remove_script_nr = nr
                break
            end
        end
    end
    imgui.PopStyleColor()
end

function repeat_scripts.show()
    imgui.SetNextWindowSize(950, 350, imgui.Cond.FirstUseEver)

    local should_show
    should_show, repeat_scripts.open = imgui.Begin("Repeat Scripts", repeat_scripts.open)

    if not should_show then
        return
    end

    if imgui.Button("Add New...") then
        modal = EditRepeatScriptModal.new()
    end

    local _
    _, repeat_scripts.all_pause = imgui.Checkbox("Pause all", repeat_scripts.all_pause)

    local table_flags = bit.bor(
        imgui.TableFlags.Resizable,
        imgui.TableFlags.RowBg
    )

    if imgui.BeginTable("scripts", 6, table_flags) then
        imgui.TableSetupColumn("Name")
        imgui.TableSetupColumn("Period", imgui.TableColumnFlags.WidthFixed, 120)
        imgui.TableSetupColumn("Offset", imgui.TableColumnFlags.WidthFixed, 120)
        imgui.TableSetupColumn("Options", imgui.TableColumnFlags.WidthFixed, 80)
        imgui.TableSetupColumn("Pause", imgui.TableColumnFlags.WidthFixed, 30)
        imgui.TableSetupColumn("Result")
        imgui.TableHeadersRow()

        for nr, script in ipairs(repeat_scripts.scripts) do
            imgui.PushID(nr)

            imgui.TableNextColumn()
            imgui.Text(script.name)
            if imgui.IsItemHovered() and imgui.BeginTooltip() ~= false then
                imgui.Text(script.script_text)
                imgui.EndTooltip()
            end

            if imgui.BeginPopupContextItem("##scripttext") then
                if imgui.MenuItem("Copy") then
                    imgui.SetClipboardText(script.script_text)
                end
                imgui.EndPopup()
            end

            imgui.TableNextColumn()
            imgui.PushItemWidth(-1)
            local change_per, new_per = imgui.InputInt("##period", script.period)
            imgui.PopItemWidth()
            if change_per then
                script.period = math.max(1, new_per)
                script.offset = math_util.clamp(script.offset, 0, script.period - 1)
            end

            imgui.TableNextColumn()
            imgui.PushItemWidth(-1)
            local change_off, new_off = imgui.InputInt("##offset", script.offset)
            imgui.PopItemWidth()
            if change_off then
                script.offset = math_util.clamp(new_off, 0, script.period - 1)
            end

            imgui.TableNextColumn()
            if imgui.Button("Options##button" .. nr) then
                imgui.OpenPopup("options##" .. nr)
            end
            if imgui.BeginPopup("options##" .. nr) then
                repeat_scripts.show_script_menu(script)
                imgui.EndPopup()
            end

            imgui.TableNextColumn()
            imgui.PushItemWidth(-1)
            local _
            _, script.options.paused = imgui.Checkbox("##pause", script.options.paused)
            imgui.PopItemWidth()

            imgui.TableNextColumn()
            if not script.last_run_success then
                imgui.PushStyleColor(imgui.Col.Text, unpack(style.colour_fail))
            end

            local value_text
            if script.last_run_success or type(script.last_run_result) ~= "string" then
                value_text = stringify(script.last_run_result, "")
            else
                value_text = script.last_run_result
            end
            imgui.Text(value_text:gsub("%s+", " "))
            if imgui.IsItemHovered() and imgui.BeginTooltip() ~= false then
                imgui.Text(value_text)
                imgui.EndTooltip()
            end

            if not script.last_run_success then
                imgui.PopStyleColor()
            end

            if imgui.BeginPopupContextItem("##valuetext") then
                if imgui.MenuItem("Copy") then
                    imgui.SetClipboardText(value_text)
                end
                imgui.EndPopup()
            end

            imgui.PopID()
        end

        imgui.EndTable()
    end

    imgui.End()
end

---@param console Console
---@param is_paused boolean
function repeat_scripts.update(console, is_paused)
    if remove_script_nr then
        table.remove(repeat_scripts.scripts, remove_script_nr)
        remove_script_nr = nil
    end

    if modal then
        if modal.open then
            modal:show()
        else
            modal = nil
        end
    end

    if is_paused or repeat_scripts.all_pause then
        return
    end

    local current_frame = GameGetFrameNum()

    for _, script in ipairs(repeat_scripts.scripts) do
        if not script.options.paused and current_frame % script.period == script.offset then
            local run_options = {
                capture_output = script.options.output_in_console,
            }

            script.last_run_success, script.last_run_result =
                console:run_function(script.func, nil, run_options)
        end
    end
end

local auto_name_counter = 1

---@param name string
---@return RepeatScript?
function repeat_scripts.get_script_by_name(name)
    for _, script in ipairs(repeat_scripts.scripts) do
        if script.name == name then
            return script
        end
    end
end

---@param name string?
---@return string name
---@return boolean using_auto
function repeat_scripts.decide_name(name, script_text)
    local using_auto_name = false
    if name == nil or name == "" then
        using_auto_name = true
        name = "Script#" .. auto_name_counter .. " " .. script_text:gsub("%s+", " ")
        auto_name_counter = auto_name_counter + 1

        local AUTO_NAME_MAX_LENGTH = 25
        if #name > AUTO_NAME_MAX_LENGTH then
            name = name:sub(1, AUTO_NAME_MAX_LENGTH - 2) .. ".."
        end
    end

    return name, using_auto_name
end

---@class ScriptError
---@field name string?
---@field script string?

---@param name string?
---@param script_text string
---@param period integer
---@param offset? integer
---@param options table?
---@return boolean success
---@return ScriptError? error
function repeat_scripts.add_script(name, script_text, period, offset, options)
    local using_auto_name
    name, using_auto_name = repeat_scripts.decide_name(name, script_text)

    if repeat_scripts.get_script_by_name(name) then
        return false, {name=NAME_TAKEN_ERROR}
    end

    if not offset then
        offset = GameGetFrameNum() % period
    end

    local func, error = eval.loadstring_ish(script_text)
    if not func then
        return false, {script=error}
    end

    options = copy.shallow_copy(options or {})
    if options.paused == nil then options.paused = false end
    if options.output_in_console == nil then options.output_in_console = false end

    repeat_scripts.scripts[#repeat_scripts.scripts+1] = {
        name = name,
        using_auto_name = using_auto_name,
        script_text = script_text,
        func = func,
        period = period,
        offset = offset,
        options = options,
        last_run_result = nil,
        last_run_success = true,
    }

    return true
end

---@return integer? run_every
function repeat_scripts.show_run_options()
    if imgui.MenuItem("Run every frame") then return 1 end
    if imgui.MenuItem("Run every 60 frames") then return 60 end
    if imgui.MenuItem("Run every 600 frames") then return 600 end
end

return repeat_scripts

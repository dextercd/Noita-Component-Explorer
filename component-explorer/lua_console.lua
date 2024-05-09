---@module 'component-explorer.utils.strings'
local string_util = dofile_once("mods/component-explorer/utils/strings.lua")
---@module 'component-explorer.deps.datadumper'
local stringify = dofile_once("mods/component-explorer/deps/datadumper.lua")
---@module 'component-explorer.utils.eval'
local eval = dofile_once("mods/component-explorer/utils/eval.lua")
---@module 'component-explorer.user_scripts'
local us = dofile_once("mods/component-explorer/user_scripts.lua")

---@module 'component-explorer.entity_markers'
local entity_markers = dofile_once("mods/component-explorer/entity_markers.lua")
---@module 'component-explorer.globals'
local globals = dofile_once("mods/component-explorer/globals.lua")
---@module 'component-explorer.ui.help'
local help = dofile_once("mods/component-explorer/ui/help.lua")

---@module 'component-explorer.utils.copy'
local copy = dofile_once("mods/component-explorer/utils/copy.lua")

---@module 'component-explorer.repeat_scripts'
local repeat_scripts = dofile_once("mods/component-explorer/repeat_scripts.lua")

local lua_console = {}

local console_tools = {
    user_script = us.user_script,
    add_marker = entity_markers.add_marker,
    remove_marker = entity_markers.remove_marker,
    ModTextFileSetContent = ModTextFileSetContent,
    ModTextFileGetContent = ModTextFileGetContent,
    ModTextFileWhoSetContent = ModTextFileWhoSetContent,
    ModLuaFileSetAppends = ModLuaFileSetAppends,
    EZWand = dofile_once("mods/component-explorer/deps/EZWand.lua"),
    cursor = dofile_once("mods/component-explorer/cursor.lua"),
    watch_global = globals.watch,
    unwatch_global = globals.unwatch,
}

local function decorated_text(decoration, text)
    local output = ""
    for line in string_util.split_iter(text, "\n", true) do
        if output ~= "" then
            output = output .. "\n"
        end
        output = output .. decoration .. line
    end
    return output
end

---@class Console
---@field open boolean
---@field history any[]
---@field input string
---@field last_command string
---@field next_draw_scroll_to_bottom boolean
---@field do_focus_input boolean
---@field remove_items integer
---@field input_lines integer
local Console = {}
Console.__index = Console

---@return Console
---@nodiscard
function Console.new()
    return setmetatable({
        open = false,
        history = {},
        input = "",
        last_command = "",
        next_draw_scroll_to_bottom = false,
        do_focus_input = false,
        remove_items = 0,
        input_lines = 3,
    }, Console)
end

function Console:draw()
    local window_flags = imgui.WindowFlags.MenuBar

    local should_show
    imgui.SetNextWindowSize(600, 400, imgui.Cond.FirstUseEver)
    should_show, self.open = imgui.Begin("Console", self.open, window_flags)
    if not should_show then
        return
    end

    self:draw_contents()
    imgui.End()
end

function Console:scroll_to_bottom()
    self.next_draw_scroll_to_bottom = true
end

function Console:focus_input()
    self.do_focus_input = true
end

function Console:remove_history(count)
    self.remove_items = count
end

---@class RunOptions
---@field capture_output boolean

---@param options table?
---@return RunOptions
local function make_run_options(options)
    options = copy.shallow_copy(options or {})
    if options.capture_output == nil then
        options.capture_output = true
    end
    return options
end

---@param func function
---@param command_text string?
---@param run_options table?
---@return boolean success
---@return any result
function Console:run_function(func, command_text, run_options)
    run_options = make_run_options(run_options)

    local real_print
    local printed

    if run_options.capture_output then
        -- Change print so we can capture all values that are printed while
        -- evaluating the command
        real_print = print
        printed = ""

        print = function(...)
            -- Keep forwarding to the real Noita print function
            pcall(real_print, ...)

            local items = {...}
            for i, item in ipairs(items) do
                if i ~= 1 then
                    printed = printed .. "\t"
                end
                printed = printed .. tostring(item)
            end

            printed = printed .. "\n"
        end
    end

    for k, v in pairs(console_tools) do
        _G[k] = v
    end

    local success, result = pcall(func)

    if run_options.capture_output then
        print = real_print

        if printed == "" or result ~= nil then
            printed = printed .. stringify(result, "")
        end

        table.insert(self.history, {command_text, printed, success})
    end

    return success, result
end

---@param command_text string
---@param run_options table?
---@return boolean success
---@return any result
function Console:run_command_text(command_text, run_options)
    run_options = make_run_options(run_options)

    local success, result, func

    func, result = eval.loadstring_ish(command_text)
    if func then
        success, result = self:run_function(func, command_text, run_options)
        self.last_command = command_text
    elseif run_options.capture_output then
        table.insert(self.history, {command_text, result, false})
    end

    return success or false, result
end

---Create new repeat script, if there's an error report it in the console.
---@param script string
---@param run_every integer
function Console:add_repeat_script(script, run_every)
    local _, error = repeat_scripts.add_script(nil, script, run_every)
    if error then
        self.history[#self.history+1] = {
            script, error.script or error.name, false
        }
        self:scroll_to_bottom()
    end
end

---@param str_id string
---@param index integer
function Console:draw_item_context_menu(str_id, index)
    if not imgui.BeginPopupContextItem(str_id) then
        return
    end

    local command, output = unpack(self.history[index])

    if command then
        if imgui.MenuItem("Copy command") then
            imgui.SetClipboardText(command)
        end

        if imgui.MenuItem("Command to input") then
            self.input = command
        end

        if imgui.MenuItem("Redo") then
            self:run_command_text(command)
            self:scroll_to_bottom()
        end

        if imgui.BeginMenu("Run every") then
            local run_every = repeat_scripts.show_run_options()
            if run_every then
                self:add_repeat_script(command, run_every)
            end
            imgui.EndMenu()
        end
    end

    if imgui.MenuItem("Copy output") then
        imgui.SetClipboardText(output)
    end

    if imgui.MenuItem("Remove this history") then
        self:remove_history(index)
    end

    imgui.EndPopup()
end

function Console:draw_menu_bar_items()
    if imgui.MenuItem("Clear") then
        self.history = {}
    end

    if imgui.MenuItem("Redo") then
        self:run_command_text(self.last_command)
        self:scroll_to_bottom()
    end

    if imgui.BeginMenu("Copy") then
        if imgui.MenuItem("Copy commands") then
            local all_commands = {}
            for _, item in ipairs(self.history) do
                if item[1] then
                    all_commands[#all_commands+1] = item[1]
                end
            end
            imgui.SetClipboardText(table.concat(all_commands, "\n"))
        end

        if imgui.MenuItem("Copy output") then
            local all_output = {}
            for _, item in ipairs(self.history) do
                if item[1] then
                    all_output[#all_output+1] = item[2]
                end
            end
            imgui.SetClipboardText(table.concat(all_output, "\n"))
        end

        if imgui.MenuItem("Copy history") then
            local all_history = {}
            for _, item in ipairs(self.history) do
                if item[1] then
                    all_history[#all_history+1] = decorated_text("> ", item[1])
                    all_history[#all_history+1] = item[2]
                end
            end
            imgui.SetClipboardText(table.concat(all_history, "\n"))
        end
        imgui.EndMenu()
    end

    local repeat_scripts_title = "Repeat Scripts"
    if #repeat_scripts.scripts > 0 then
        repeat_scripts_title = repeat_scripts_title .. " (" .. #repeat_scripts.scripts .. ")"
    end

    if imgui.BeginMenu(repeat_scripts_title .. "###console_repeat_scripts") then
        local _
        _, repeat_scripts.open = imgui.MenuItem("Configuration Window", "", repeat_scripts.open)
        _, repeat_scripts.all_pause = imgui.MenuItem("Pause all", "", repeat_scripts.all_pause)

        for nr, script in ipairs(repeat_scripts.scripts) do
            if imgui.BeginMenu(script.name .. "##" .. nr) then
                repeat_scripts.show_script_menu(script)
                imgui.EndMenu()
            end
        end

        imgui.EndMenu()
    end
end

function Console:draw_menu_bar()
    if not imgui.BeginMenuBar() then
        return
    end

    self:draw_menu_bar_items()

    imgui.EndMenuBar()
end

function Console:draw_contents()
    self:draw_menu_bar()

    local style = imgui.GetStyle()
    local line_height = imgui.GetTextLineHeight()

    local footer_height = (
        self.input_lines * line_height
        + 2 * style.FramePadding_y
        + style.ItemSpacing_y
    )

    if imgui.BeginChild(
            "ScrollingRegion",
            0, -footer_height,
            false,
            imgui.WindowFlags.HorizontalScrollbar
        )
    then
        imgui.PushStyleVar(imgui.StyleVar.ItemSpacing, 4, 0.5)

        for i, item in ipairs(self.history) do
            if i ~= 0 then
                imgui.Dummy(0, 3)
            end

            local command, output, status = unpack(item)

            if not status then
                imgui.PushStyleColor(imgui.Col.Text, 1.0, 0.4, 0.4)
            end

            if command then
                imgui.Text(decorated_text("> ", command))
                self:draw_item_context_menu("command_ctx" .. i, i)
            end
            imgui.Text(output)
            self:draw_item_context_menu("output_ctx" .. i, i)

            if not status then
                imgui.PopStyleColor()
            end
        end

        if self.next_draw_scroll_to_bottom then
            imgui.SetScrollHereY(1)
            self.next_draw_scroll_to_bottom = false
        end

        imgui.PopStyleVar()
        imgui.EndChild()
        imgui.Separator()
    end

    local submit_input
    submit_input, self.input = imgui.InputTextMultiline(
        "##Input", self.input,
        -line_height * 4, line_height * self.input_lines,
        imgui.InputTextFlags.EnterReturnsTrue
    )

    if self.do_focus_input then
        self.do_focus_input = false
        imgui.SetKeyboardFocusHere(-1)
    end

    -- Right click console input
    if imgui.BeginPopupContextItem("console_input_context") then
        local _
        _, self.input_lines = imgui.SliderInt("Lines", self.input_lines, 3, 10)
        imgui.Text("Hidden feature :O")
        imgui.EndPopup()
    end

    imgui.SameLine()
    imgui.BeginGroup()

    local submit_button = imgui.Button("Submit")
    local run_every
    if imgui.BeginPopupContextItem() then
        run_every = repeat_scripts.show_run_options()
        imgui.EndPopup()
    end

    help.marker(
        "Use CTRL+Enter or the submit button to evaluate the Lua expression.\n\n" ..

        "You can use print or return to display values in the console, return displays " ..
        'items within tables while print will only display something like "table: 0x00741c68"\n\n' ..

        "Right click the submit button to make this a 'repeat script' instead." ..
        "(This also works for user scripts and you can find the option when right clicking a history item in the console.)"
    )

    imgui.EndGroup()

    if submit_input or submit_button then
        self:run_command_text(self.input)
        self:scroll_to_bottom()
        self:focus_input()
        self.input = ""
    elseif run_every then
        self:add_repeat_script(self.input, run_every)
        self.input = ""
        self:focus_input()
    end

    if self.remove_items ~= 0 then
        local new_history = {}
        for i = self.remove_items + 1, #self.history do
            table.insert(new_history, self.history[i])
        end
        self.history = new_history
        self.remove_items = 0
    end
end

lua_console.Console = Console

return lua_console

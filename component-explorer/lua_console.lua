local string_util = dofile_once("mods/component-explorer/string_util.lua")
dofile_once("mods/component-explorer/stringify.lua")
dofile_once("mods/component-explorer/eval.lua")

EZWand = dofile_once("mods/component-explorer/EZWand.lua")

local globals = {
    ModTextFileSetContent=ModTextFileSetContent,
    ModTextFileGetContent=ModTextFileGetContent,
}

function new_console(name)
    name = name or "Console"
    return {
        name = name,
        open = true,
        history = {},
        input = "",
        last_command = "",
        scroll_to_bottom = false,
        focus_input = false,
        remove_items = 0,
    }
end

function console_draw(console)
    local should_show
    imgui.SetNextWindowSize(600, 400, imgui.Cond.Once)
    should_show, console.open = imgui.Begin(console.name, console.open)
    if not should_show then
        return
    end

    console_contents_draw(console)

    imgui.End()
end

function console_scroll_to_bottom(console)
    console.scroll_to_bottom = true
end

function console_focus_input(console)
    console.focus_input = true
end

function console_remove_history(console, count)
    console.remove_items = count
end

local function decorated_text(decoration, text)
    local output = ""
    for line in string_util.splitstring(text, "\n", true) do
        if output ~= "" then
            output = output .. "\n"
        end
        output = output .. decoration .. line
    end
    return output
end

function console_run_command(console, command)
    -- Change print so we can capture all values that are printed while
    -- evaluating the command
    local real_print = print
    local printed = ""
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

    for k,v in pairs(globals) do
        _G[k] = v
    end

    local status, value = eval(command)

    print = real_print

    local output
    if printed ~= "" and value == nil then
        output = printed
    else
        output = printed .. stringify(value)
    end

    table.insert(console.history, {command, output, status})
    console.last_command = command
    console_scroll_to_bottom(console)
end

local function console_item_context_menu(str_id, console, index)
    if not imgui.BeginPopupContextItem(str_id) then
        return
    end

    local command, output = unpack(console.history[index])


    if imgui.MenuItem("Copy command") then
        imgui.SetClipboardText(command)
    end

    if imgui.MenuItem("Command to input") then
        console.input = command
    end

    if imgui.MenuItem("Redo") then
        console_run_command(console, command)
    end

    if imgui.MenuItem("Copy output") then
        imgui.SetClipboardText(output)
    end

    if imgui.MenuItem("Remove this history") then
        console_remove_history(console, index)
    end

    imgui.EndPopup()
end

function console_contents_draw(console)
    if imgui.SmallButton("Clear") then
        console.history = {}
    end

    imgui.SameLine()
    if imgui.SmallButton("Redo") then
        console_run_command(console, console.last_command)
    end

    imgui.SameLine()
    if imgui.SmallButton("Commands to clipboard") then
        local all_commands = ""
        for _, item in ipairs(console.history) do
            all_commands = all_commands .. item[1] .. "\n"
        end

        imgui.SetClipboardText(all_commands)
    end

    imgui.SameLine()
    if imgui.SmallButton("History to clipboard") then
        local all_history = ""
        for _, item in ipairs(console.history) do
            all_history = (
                all_history ..
                decorated_text("> ", item[1]) .. "\n" ..
                item[2] .. "\n"
            )
        end

        imgui.SetClipboardText(all_history)
    end

    imgui.Separator()

    local style = imgui.GetStyle()
    local line_height = imgui.GetTextLineHeight()

    local input_lines = 3

    local footer_height = (
        input_lines * line_height
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

        for i, item in ipairs(console.history) do
            if i ~= 0 then
                imgui.Dummy(0, 3)
            end

            local command, output, status = unpack(item)

            if not status then
                imgui.PushStyleColor(imgui.Col.Text, 1.0, 0.4, 0.4)
            end

            imgui.Text(decorated_text("> ", command))
            console_item_context_menu("command_ctx" .. i, console, i)
            imgui.Text(output)
            console_item_context_menu("output_ctx" .. i, console, i)

            if not status then
                imgui.PopStyleColor()
            end
        end

        if console.scroll_to_bottom then
            imgui.SetScrollHereY(1)
            console.scroll_to_bottom = false
        end

        imgui.PopStyleVar()
        imgui.EndChild()
        imgui.Separator()
    end

    local submit_input
    submit_input, console.input = imgui.InputTextMultiline(
        "##Input", console.input,
        -line_height * 4, line_height * input_lines,
        imgui.InputTextFlags.EnterReturnsTrue
    )

    if console.focus_input then
        console.focus_input = false
        imgui.SetKeyboardFocusHere(-1)
    end

    imgui.SameLine()
    imgui.BeginGroup()

    local submit_button = imgui.Button("Submit")
    help_marker(
        "Use CTRL+Enter or the submit button to evaluate the Lua expression.\n\n" ..

        'You can use print or return to display values in the console, return displays ' ..
        'items within tables while print will only display something like "table: 0x00741c68"'
    )

    imgui.EndGroup()

    if submit_input or submit_button then
        console_run_command(console, console.input)
        console_focus_input(console)
        console.input = ""
    end

    if console.remove_items ~= 0 then
        local new_history = {}
        for i = console.remove_items + 1, #console.history do
            table.insert(new_history, console.history[i])
        end
        console.history = new_history
        console.remove_items = 0
    end
end

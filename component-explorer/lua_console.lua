dofile_once("mods/component-explorer/stringify.lua")
dofile_once("mods/component-explorer/eval.lua")

function new_console(name)
    name = name or "Console"
    return {
        name = name,
        history = {
            {
                'print("Hello, world!")',
                '"Hello, world"',
            },
            {
                'print(9 * 9)',
                '81',
            },
        },
        input = "",
        last_command = "",
        scroll_to_bottom = false,
        focus_input = false,
    }
end

function console_draw(console)
    if not imgui.Begin(console.name) then
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

function console_run_command(console, command)
    local status, value = eval(command)
    console.last_command = command
    table.insert(console.history, {command, stringify(value)})

    console_scroll_to_bottom(console)
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
            all_history = (all_history ..
                "> " .. item[1] .. "\n" ..
                item[2] .. "\n"
            )
        end

        imgui.SetClipboardText(all_history)
    end

    imgui.Separator()

    local style = imgui.GetStyle()
    local footer_height = style.ItemSpacing_y + imgui.GetFrameHeightWithSpacing()

    if imgui.BeginChild(
            "ScrollingRegion",
            0, -footer_height,
            false,
            imgui.WindowFlags.HorizontalScrollbar
        )
    then
        imgui.PushStyleVar(imgui.StyleVar.ItemSpacing, 4, 0.5)

        for i, command in ipairs(console.history) do
            if i ~= 0 then
                imgui.Dummy(0, 3)
            end

            imgui.Text("> " .. command[1])
            imgui.Text(command[2])
        end

        if console.scroll_to_bottom then
            imgui.SetScrollHereY(1)
            console.scroll_to_bottom = false
        end

        imgui.PopStyleVar()
        imgui.EndChild()
        imgui.Separator()
    end

    local submit
    submit, console.input = imgui.InputText(
        "Input", console.input,
        imgui.InputTextFlags.EnterReturnsTrue
    )

    if submit then
        console_run_command(console, console.input)
        console_focus_input(console)
        console.input = ""
    end

    if console.focus_input then
        console.focus_input = false
        imgui.SetKeyboardFocusHere(-1)
    end
end

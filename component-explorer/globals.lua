window_open_globals = false

local VARIABLE_NOT_SET_VALUE = "COMPONENT_EXPLORER-4433bcc6"

local globals_name = ""
local globals_type = "number"

local type_options = {
    "number",
    "integer",
    "string",
    "true/false",
}

local globals_windows = {}
local remove_next = {}

function show_globals()
    imgui.SetNextWindowSize(400, 150, imgui.Cond.Once)
    local should_show
    should_show, window_open_globals = imgui.Begin(
        "Configure Globals", window_open_globals
    )

    if not should_show then return end

    imgui.SetNextItemWidth(150)
    local _
    _, globals_name = imgui.InputText("Global", globals_name)

    imgui.SameLine()
    imgui.SetNextItemWidth(140)
    if imgui.BeginCombo("type", globals_type) then
        for _, value in ipairs(type_options) do
            if imgui.Selectable(value, value == globals_type) then
                globals_type = value
            end
        end
        imgui.EndCombo()
    end

    if imgui.Button("Open") then
        if globals_name ~= "" then
            globals_windows[globals_name] = {
                type = globals_type,
            }
            globals_name = ""
        end
    end

    imgui.End()
end

function show_globals_windows()
    for name, data in pairs(globals_windows) do
        show_global_window(name, data)
    end

    for _, name in ipairs(remove_next) do
        globals_windows[name] = nil
    end
    remove_next = {}
end

function set_default(name, type)
    if type == "true/false" then
        GlobalsSetValue(name, "false")
    elseif type == "string" then
        GlobalsSetValue(name, "")
    else
        GlobalsSetValue(name, "0")
    end
end

function get_value(name, type)
    local text_value = GlobalsGetValue(name, VARIABLE_NOT_SET_VALUE)
    if text_value == VARIABLE_NOT_SET_VALUE then
        return nil
    end

    if type == "number" or type == "integer" then
        local success, num = pcall(tonumber, text_value)
        if not success or not num then
            set_default(name, type)
            return get_value(name, type)
        end

        return num
    end

    if type == "true/false" then
        return text_value ~= "false"
    end

    return text_value
end

function show_global_window(name, data)
    local window_name = name .. ": " .. data.type

    imgui.SetNextWindowSize(400, 70, imgui.Cond.Once)
    local should_show, open = imgui.Begin(window_name, true)

    if not open then
        table.insert(remove_next, name)
    end

    if not should_show then
        return
    end

    local drag_help = "Drag left/right to change value or use double click."

    local current_value = get_value(name, data.type)

    if current_value == nil then
        imgui.Text("Global not set")
        imgui.SameLine()
        if imgui.SmallButton("Set to default") then
            set_default(name, data.type)
            current_value = get_value(name, data.type)
        end
    end

    if current_value == nil then
        goto novalue
    end

    if data.type == "number" then
        imgui.SetNextItemWidth(100)
        local changed, value = imgui.DragFloat(name, current_value)
        imgui.SameLine() help_marker(drag_help)

        if changed then
            GlobalsSetValue(name, tostring(value))
        end
    elseif data.type == "integer" then
        imgui.SetNextItemWidth(100)
        local _, value = imgui.DragInt(name, current_value)
        imgui.SameLine() help_marker(drag_help)

        if value ~= current_value then
            GlobalsSetValue(name, ("%.0f"):format(value))
        end
    elseif data.type == "string" then
        imgui.SetNextItemWidth(200)
        local changed, value = imgui.InputText(name, current_value)
        if changed then
            GlobalsSetValue(name, value)
        end
    elseif data.type == "true/false" then
        local changed, value = imgui.Checkbox(name, current_value)
        if changed then
            GlobalsSetValue(name, tostring(value))
        end
    end

    ::novalue::

    imgui.End()
end

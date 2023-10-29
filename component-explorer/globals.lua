local globals = {}

globals.open = false

local VARIABLE_NOT_SET_VALUE = "COMPONENT_EXPLORER-4433bcc6"

local globals_name = ""
local globals_type = "number"

local type_options = {
    "number",
    "integer",
    "string",
    "true/false",
}

local watched_globals = {}
local sort_field = "name"
local order_asc = true

-- (Re)ordering of watched_globals table
local function order_globals()
    local cmp_fn = function(a, b)
        if order_asc then
            return a[sort_field] < b[sort_field]
        end
        return a[sort_field] > b[sort_field]
    end
    table.sort(watched_globals, cmp_fn)
end

local function set_global_table_order(sf, oa)
    if sf == sort_field and order_asc == oa then
        return
    end

    sort_field = sf
    order_asc = oa
    order_globals()
end

function globals.watch(name, datatype)
    globals.unwatch(name)
    datatype = datatype or "string"
    table.insert(watched_globals, {
        name=name,
        type=datatype,
    })
    order_globals()
end

function globals.unwatch(name)
    for k, v in ipairs(watched_globals) do
        if v.name == name then
            table.remove(watched_globals, k)
            return
        end
    end
end

local function set_default(name, type)
    if type == "true/false" then
        GlobalsSetValue(name, "false")
    elseif type == "string" then
        GlobalsSetValue(name, "")
    else
        GlobalsSetValue(name, "0")
    end
end

local function get_value(name, type)
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

local function add_global_ui()
    imgui.SetNextItemWidth(200)
    local flags = imgui.InputTextFlags.EnterReturnsTrue
    local hit_enter
    hit_enter, globals_name = imgui.InputText("View Global", globals_name, flags)

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

    imgui.SameLine()
    if imgui.Button("View") or hit_enter then
        if globals_name ~= "" then
            globals.watch(globals_name, globals_type)
            globals_name = ""
        end
    end
end

local function show_global_input(data)
    local drag_help = "Drag left/right to change value or use double click."

    local current_value = get_value(data.name, data.type)

    if current_value == nil then
        imgui.Text("Global not set")
        imgui.SameLine()
        if imgui.SmallButton("Set to default") then
            set_default(data.name, data.type)
            current_value = get_value(data.name, data.type)
        end
        return
    end

    if data.type == "number" then
        imgui.SetNextItemWidth(100)
        local changed, value = imgui.DragFloat("", current_value)
        imgui.SameLine() help_marker(drag_help)

        if changed then
            GlobalsSetValue(data.name, tostring(value))
        end
    elseif data.type == "integer" then
        imgui.SetNextItemWidth(100)
        local _, value = imgui.DragInt("", current_value)
        imgui.SameLine() help_marker(drag_help)

        if value ~= current_value then
            GlobalsSetValue(data.name, ("%.0f"):format(value))
        end
    elseif data.type == "string" then
        imgui.SetNextItemWidth(200)
        local changed, value = imgui.InputText("", current_value)
        if changed then
            GlobalsSetValue(data.name, value)
        end
    elseif data.type == "true/false" then
        local changed, value = imgui.Checkbox("", current_value)
        if changed then
            GlobalsSetValue(data.name, tostring(value))
        end
    end
end

local function handle_sort_spec()
    if not imgui.TableGetSortSpecs then return end

    local dirty, sortspec = imgui.TableGetSortSpecs()
    if dirty and sortspec then
        assert(#sortspec.Specs == 1)
        local columnspec = sortspec.Specs[1]

        local field
        if columnspec.ColumnIndex == 1 then field = "name" end
        if columnspec.ColumnIndex == 2 then field = "type" end
        set_global_table_order(field, columnspec.SortDirection == imgui.SortDirection.Ascending)

        imgui.TableSortSpecsMarkClean()
    end

end

local function show_globals_table_ui()
    local table_flags = imgui.TableFlags.Resizable
    if imgui.TableGetSortSpecs then
        table_flags = bit.bor(table_flags, imgui.TableFlags.Sortable)
    end

    if not imgui.BeginTable("Globals", 4, table_flags) then
        return
    end

    imgui.TableSetupColumn("Name")
    imgui.TableSetupColumn("Type")
    imgui.TableSetupColumn("Value", imgui.TableColumnFlags.NoSort)
    local close_flags = bit.bor(
        imgui.TableColumnFlags.WidthFixed,
        imgui.TableColumnFlags.NoResize,
        imgui.TableColumnFlags.NoSort
    )
    imgui.TableSetupColumn("Close", close_flags, 60)
    imgui.TableHeadersRow()

    handle_sort_spec()

    local delay_unwatch

    for _, data in ipairs(watched_globals) do
        imgui.PushID(data.name)
        imgui.TableNextRow()

        imgui.TableNextColumn()
        imgui.Text(data.name)

        imgui.TableNextColumn()
        imgui.Text(data.type)

        imgui.TableNextColumn()
        show_global_input(data)

        imgui.TableNextColumn()
        if imgui.SmallButton("X") then
            delay_unwatch = data.name
        end

        imgui.PopID()
    end

    if delay_unwatch then
        globals.unwatch(delay_unwatch)
    end

    imgui.EndTable()
end

function globals.show()
    imgui.SetNextWindowSize(600, 200, imgui.Cond.FirstUseEver)
    local should_show
    should_show, globals.open = imgui.Begin("Globals / flags", globals.open)

    if not should_show then return end

    add_global_ui()
    show_globals_table_ui()

    imgui.End()
end

return globals

local OVERLAY_OFFSET_X = 5
local OVERLAY_OFFSET_Y = 5

local OVERLAY_MAX_ITEMS = 20

local SELECT_ENTITY_KEYS = {
    imgui.Key._1,
    imgui.Key._2,
    imgui.Key._3,
    imgui.Key._4,
    imgui.Key._5,
    imgui.Key._6,
    imgui.Key._7,
    imgui.Key._8,
    imgui.Key._9,
    imgui.Key._0,
}

local function entities_in_range(x, y, radius)
    local all_entities = EntityGetInRadius(x, y, radius)
    local ret = {}

    for _, entity_id in ipairs(all_entities) do
        local parent = EntityGetParent(entity_id)
        if parent == 0 then
            table.insert(ret, entity_id)
        end
    end

    return ret
end

local function entity_label(entity_id)
    if not EntityGetIsAlive(entity_id) then
        return "*DEAD*"
    end

    local name = EntityGetName(entity_id)
    if name == "unknown" then name = "" end
    local tags = EntityGetTags(entity_id)

    local label_parts = {}

    if name ~= "" then
        table.insert(label_parts, name)
    end

    if tags ~= "" then
        table.insert(label_parts, "[" .. tags .. "]")
    end

    table.insert(label_parts, "(" .. entity_id .. ")")

    return table.concat(label_parts, " ")
end

local function index_wrap(index, wrap)
    return (index - 1) % wrap + 1
end

local function get_key(entity_index)
    if entity_index > 2 * #SELECT_ENTITY_KEYS then
        return nil
    end

    local key_index = index_wrap(entity_index, #SELECT_ENTITY_KEYS)
    return SELECT_ENTITY_KEYS[key_index]
end

local function is_mod_down(entity_index)
    local shift = imgui.IsKeyDown(imgui.Key.LeftShift)

    if entity_index <= 10 then
        return not shift
    end

    if entity_index <= 20 then
        return shift
    end

    return false
end

local function is_down(entity_index)
    local key = get_key(entity_index)
    if key == nil then
        return false
    end

    return imgui.IsKeyDown(key) and is_mod_down(entity_index)
end

local function is_released(entity_index)
    local key = get_key(entity_index)
    if key == nil then
        return false
    end

    return imgui.IsKeyReleased(key) and is_mod_down(entity_index)
end


overlay_open_entity_picker = false
local overlay_entities = {}
local skip_entities_refresh_once = false
local list_start_point = 1

function show_entity_picker_overlay()
    if imgui.IsKeyPressed(imgui.Key.Escape) then
        overlay_open_entity_picker = false
        return
    end

    local cursor_x, cursor_y = imgui.GetMousePos()

    imgui.SetNextWindowPos(cursor_x + OVERLAY_OFFSET_X, cursor_y + OVERLAY_OFFSET_Y)
    imgui.SetNextWindowBgAlpha(0.25)
    imgui.SetNextWindowViewport(imgui.GetMainViewportID())

    local window_flags = bit.bor(
        imgui.WindowFlags.NoDecoration,
        imgui.WindowFlags.NoScrollWithMouse,
        imgui.WindowFlags.NoInputs,
        imgui.WindowFlags.NoDocking,
        imgui.WindowFlags.AlwaysAutoResize,
        imgui.WindowFlags.NoSavedSettings,
        imgui.WindowFlags.NoFocusOnAppearing,
        imgui.WindowFlags.NoNav,
        imgui.WindowFlags.NoMove
    )

    local should_show
    should_show, overlay_open_entity_picker = imgui.Begin(
        "Entity picker",
        overlay_open_entity_picker,
        window_flags
    )

    if not should_show then
        return
    end

    local world_x, world_y = DEBUG_GetMouseWorld()

    local any_pressed = false
    local selected_entity = nil

    if not skip_entities_refresh_once then
        overlay_entities = entities_in_range(world_x, world_y, 20)
    end
    skip_entities_refresh_once = false

    local io = imgui.GetIO()
    if io.MouseWheel then
        if io.MouseWheel > 0 then
            list_start_point = list_start_point - 1
        elseif io.MouseWheel < 0 then
            list_start_point = list_start_point + 1
        end
    end

    for i=1,#overlay_entities do
        if i > OVERLAY_MAX_ITEMS then
            if io.MouseWheel then
                imgui.Text("... Use scroll wheel to reveal others")
            else
                imgui.Text("... Update to ImGui 1.14 to scroll list")
            end

            break
        end

        local entity_id = overlay_entities[index_wrap(i + list_start_point, #overlay_entities)]
        local label = entity_label(entity_id)

        local color
        if is_down(i) then
            any_pressed = true
            color = {0.96, 0.94, 0, 1}
        end

        if not EntityGetIsAlive(entity_id) then
            color = {1, 0.4, 0.4, 1}
        end

        if color then
            imgui.PushStyleColor(imgui.Col.Text, unpack(color))
        end

        imgui.Text(i .. ": " .. label)

        if color then
            imgui.PopStyleColor()
        end

        if is_released(i) then
            selected_entity = entity_id
        end
    end

    if any_pressed then
        skip_entities_refresh_once = true
    end

    if selected_entity and not any_pressed then
        watch_entity(selected_entity)
        overlay_open_entity_picker = false
    end

    imgui.End()
end

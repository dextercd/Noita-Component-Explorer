local stringify = dofile_once("mods/component-explorer/deps/datadumper.lua")
dofile_once("mods/component-explorer/field_enums.lua")
dofile_once("mods/component-explorer/entity.lua")
local file_viewer = dofile_once("mods/component-explorer/file_viewer.lua")
local matutil = dofile_once("mods/component-explorer/utils/matutil.lua")

---@module 'component-explorer.ui.help'
local help = dofile_once("mods/component-explorer/ui/help.lua")

---@module 'component-explorer.utils.ce_settings'
local ce_settings = dofile_once("mods/component-explorer/utils/ce_settings.lua")

---@module 'component-explorer.utils.math_util'
local math_util = dofile_once("mods/component-explorer/utils/math_util.lua")

function show_field_int(name, description, component_id, get, set)
    local value = (get or ComponentGetValue2)(component_id, name)

    imgui.SetNextItemWidth(200)
    local changed, value = imgui.InputInt(name, value)
    if changed then
        (set or ComponentSetValue2)(component_id, name, value)
    end

    if description then
        imgui.SameLine()
        help.marker(description)
    end
end

show_field_unsignedint = show_field_int
show_field_int16 = show_field_int
show_field_uint16 = show_field_int
show_field_int32 = show_field_int
show_field_uint32 = show_field_int
show_field_uint32_t = show_field_int
show_field_AudioSourceHandle = show_field_int
show_field_EntityTypeID = show_field_int
show_field_LensValue_int = show_field_int

function show_field_int64(name, description, component_id, get, set)
    local value = (get or ComponentGetValue)(component_id, name)

    imgui.SetNextItemWidth(200)
    local changed
    changed, value = imgui.InputText(name, value, imgui.InputTextFlags.CharsDecimal)
    if changed then
        (set or ComponentSetValue)(component_id, name, math_util.int64_clamp(value))
    end

    if description then
        imgui.SameLine()
        help.marker(description)
    end
end

function show_field_uint64(name, description, component_id, get, set)
    local value = (get or ComponentGetValue)(component_id, name)

    imgui.SetNextItemWidth(200)
    local changed
    changed, value = imgui.InputText(name, value, imgui.InputTextFlags.CharsDecimal)
    if changed then
        (set or ComponentSetValue)(component_id, name, math_util.uint64_clamp(value))
    end

    if description then
        imgui.SameLine()
        help.marker(description)
    end
end

-- float format
local function ff(type)
    local configured = ce_settings.get("preferred_decimal_format")

    if
        type == "double" and configured == "double_scientific" or
        --[[ any type ... ]] configured == "all_scientific"
    then
        return "%e"
    end

    if configured == "magnitude" then return "%g" end

    if type == "double" then return "%.6f" end
    return "%.3f"
end

function show_field_float(name, description, component_id, get, set)
    local value = (get or ComponentGetValue2)(component_id, name)

    imgui.SetNextItemWidth(200)
    local changed, value = imgui.InputFloat(name, value, 0.1, 0.0, ff("float"))
    if changed then
        (set or ComponentSetValue2)(component_id, name, value)
    end

    if description then
        imgui.SameLine()
        help.marker(description)
    end
end
show_field_LensValue_float = show_field_float

function show_field_double(name, description, component_id, get, set)
    local value = (get or ComponentGetValue2)(component_id, name)

    imgui.SetNextItemWidth(200)
    local changed, value = imgui.InputDouble(name, value, 0.1, 0.0, ff("double"))
    if changed then
        (set or ComponentSetValue2)(component_id, name, value)
    end

    if description then
        imgui.SameLine()
        help.marker(description)
    end
end

function show_field_bool(name, description, component_id, get, set)
    local value = (get or ComponentGetValue2)(component_id, name)

    local changed, value = imgui.Checkbox(name, value)
    if changed then
        (set or ComponentSetValue2)(component_id, name, value)
    end

    if description then
        imgui.SameLine()
        help.marker(description)
    end
end

function show_field_std_string(name, description, component_id, get, set)
    local value = (get or ComponentGetValue2)(component_id, name)

    imgui.SetNextItemWidth(300)
    local changed, value = imgui.InputText(name, value)
    if changed then
        (set or ComponentSetValue2)(component_id, name, value)
    end

    if description then
        imgui.SameLine()
        help.marker(description)
    end
end

show_field_USTRING = show_field_std_string

function show_field_file_single(name, description, component_id, get, set)
    local value = (get or ComponentGetValue2)(component_id, name)

    imgui.SetNextItemWidth(300)
    local changed, value = imgui.InputText(name, value)
    if changed then
        (set or ComponentSetValue2)(component_id, name, value)
    end

    imgui.SameLine()
    file_viewer.open_button(value)

    if description then
        imgui.SameLine()
        help.marker(description)
    end
end

-- Not supporting this right now
show_field_file_multi = show_field_std_string

function show_field_vec2(name, description, component_id, get, set)
    local x, y = (get or ComponentGetValue2)(component_id, name)

    imgui.SetNextItemWidth(300)
    local changed, nx, ny = imgui.InputFloat2(name, x, y)
    if changed then
        (set or ComponentSetValue2)(component_id, name, nx, ny)
    end

    if description then
        imgui.SameLine()
        help.marker(description)
    end
end

function show_field_ivec2(name, description, component_id, get, set)
    local x, y = (get or ComponentGetValue2)(component_id, name)

    imgui.SetNextItemWidth(300)
    local changed, nx, ny = imgui.InputInt2(name, x, y)
    if changed then
        (set or ComponentSetValue2)(component_id, name, nx, ny)
    end

    if description then
        imgui.SameLine()
        help.marker(description)
    end
end

function show_field_types_xform(name, description, component_id)
    imgui.Text(name)
    if description then
        imgui.SameLine()
        help.marker(description)
    end

    local x, y, scale_x, scale_y, rot = ComponentGetValue2(component_id, name)

    local pos_changed
    pos_changed, x, y = imgui.InputFloat2("Position", x, y)

    local rot_changed
    rot_changed, rot = imgui.InputFloat("Rotation", rot)

    local scale_changed
    scale_changed, scale_x, scale_y = imgui.InputFloat2("Scale", scale_x, scale_y)

    if pos_changed or rot_changed or scale_changed then
         ComponentSetValue2(component_id, name, x, y, scale_x, scale_y, rot)
    end
end

show_field_types_vector2 = show_field_vec2
show_field_ValueRange = show_field_vec2
show_field_ValueRangeInt = show_field_ivec2

function show_field_abgr(name, description, component_id)
    local value = ComponentGetValue2(component_id, name)

    local a = bit.rshift(value, 24) / 255
    local b = bit.band(bit.rshift(value, 16), 255) / 255
    local g = bit.band(bit.rshift(value, 8), 255) / 255
    local r = bit.band(value, 255) / 255

    local changed, nr, ng, nb, na = imgui.ColorEdit4(name, r, g, b, a)
    if changed then
        local ir = nr * 255
        local ig = ng * 255
        local ib = nb * 255
        local ia = na * 255
        local new_value = bit.bor(
            bit.lshift(ia, 24),
            bit.lshift(ib, 16),
            bit.lshift(ig, 8),
            ir
        )

        ComponentSetValue2(component_id, name, new_value)
    end

    if description then
        imgui.SameLine()
        help.marker(description)
    end
end

function show_field_types_fcolor(name, description, component_id)
    local r, g, b, a = ComponentGetValue2(component_id, name)

    local changed, r, g, b, a = imgui.ColorEdit4(name, r, g, b, a)
    if changed then
        ComponentSetValue2(component_id, name, r, g, b, a)
    end

    if description then
        imgui.SameLine()
        help.marker(description)
    end
end

function show_field_LensValue_bool(name, description, component_id)
    local value = ComponentGetValue2(component_id, name) ~= 0

    local changed, value = imgui.Checkbox(name, value)
    if changed then
        ComponentSetValue2(component_id, name, value)
    end

    if description then
        imgui.SameLine()
        help.marker(description)
    end
end

function show_field_types_aabb(name, description, component_id)
    local min_x, min_y, max_x, max_y = ComponentGetValue2(component_id, name)

    local c1, c2
    c1, min_x, min_y = imgui.InputFloat2(name .. " min", min_x, min_y)
    if description then
        imgui.SameLine()
        help.marker(description)
    end

    c2, max_x, max_y = imgui.InputFloat2(name .. " max", max_x, max_y)

    if c1 or c2 then
        ComponentSetValue2(component_id, name, min_x, min_y, max_x, max_y)
    end
end

function show_field_spread_aabb(prefix, description, component_id)
    local min_x = ComponentGetValue2(component_id, prefix .. "_min_x")
    local min_y = ComponentGetValue2(component_id, prefix .. "_min_y")
    local max_x = ComponentGetValue2(component_id, prefix .. "_max_x")
    local max_y = ComponentGetValue2(component_id, prefix .. "_max_y")

    local changed_min, changed_max
    changed_min, min_x, min_y = imgui.InputFloat2(prefix .. " min", min_x, min_y)
    if description then
        imgui.SameLine()
        help.marker(description)
    end

    changed_max, max_x, max_y = imgui.InputFloat2(prefix .. " max", max_x, max_y)

    if changed_min then
        ComponentSetValue2(component_id, prefix .. "_min_x", min_x)
        ComponentSetValue2(component_id, prefix .. "_min_y", min_y)
    end

    if changed_max then
        ComponentSetValue2(component_id, prefix .. "_max_x", max_x)
        ComponentSetValue2(component_id, prefix .. "_max_y", max_y)
    end
end

function show_field_enum(name, description, component_id, enum_values)
    local value = ComponentGetMetaCustom(component_id, name)
    if imgui.BeginCombo(name, value) then
        for _, enum_value in ipairs(enum_values) do
            if imgui.Selectable(enum_value, value == enum_value) then
                ComponentSetMetaCustom(component_id, name, enum_value)
            end
        end
        imgui.EndCombo()
    end

    if description then
        imgui.SameLine()
        help.marker(description)
    end
end

function show_field_static_text(name, description, component_id)
    local text = tostring(ComponentGetValue2(component_id, name) or "")
    imgui.Text(name .. ": " .. text)

    if description then
        imgui.SameLine()
        help.marker(description)
    end
end

function show_field_EntityID(name, description, component_id, get, set)
    local entity_id = (get or ComponentGetValue2)(component_id, name)

    imgui.SetNextItemWidth(200)
    local changed, entity_id = imgui.InputInt(name, entity_id)
    if changed then
        (set or ComponentSetValue2)(component_id, name, entity_id)
    end

    imgui.SameLine()
    if EntityGetIsAlive(entity_id) then
        open_entity_button(entity_id)
    else
        imgui.Text("(not found)")
    end

    if description then
        imgui.SameLine()
        help.marker(description)
    end
end

local function display_default(idx, value)
    imgui.Text(tostring(idx) .. ": " .. tostring(value))
end

function show_field_ro_list(name, description, component_id, display)
    display = display or display_default
    local values = ComponentGetValue2(component_id, name)

    local in_tree = imgui.TreeNode(name .. " (#" .. #values .. ")###" .. name)
    if description then
        imgui.SameLine()
        help.marker(description)
    end

    if not in_tree then
        return
    end

    for idx, value in ipairs(values) do
        display(idx, value)
    end

    imgui.TreePop()
end

function show_field_VECTOR_ENTITYID(name, description, component_id)
    local function show_entity_id(idx, entity_id)
        imgui.Text(tostring(entity_id))
        imgui.SameLine()
        if EntityGetIsAlive(entity_id) then
            open_entity_small_button(entity_id)
        else
            imgui.Text("(not found)")
        end
    end
    return show_field_ro_list(name, description, component_id, show_entity_id)
end
show_field_VEC_ENTITY = show_field_VECTOR_ENTITYID
show_field_ENTITY_VEC = show_field_VECTOR_ENTITYID

function show_field_VISITED_VEC(name, description, component_id)
    local function show_visited(idx, place)
        local text = GameTextGetTranslatedOrNot(place)
        if place ~= text then
            text = text .. " (" .. place .. ")"
        end
        imgui.Text(text)
    end
    return show_field_ro_list(name, description, component_id, show_visited)
end

function show_field_material_id_list(name, description, component_id)
    local function show_material(idx, matid)
        local name = matutil.material_name(matid) or "<not found>"
        imgui.Text(tostring(idx) .. ": " .. name)
    end
    return show_field_ro_list(name, description, component_id, show_material)
end

function show_field_material_pairs(name, description, component_id)
    local materials = ComponentGetValue2(component_id, name)
    local pair_count = #materials / 2

    local in_tree = imgui.TreeNode(name .. " (#" .. pair_count .. ")###" .. name)
    if description then
        imgui.SameLine()
        help.marker(description)
    end

    if not in_tree then
        return
    end

    for idx=1,#materials,2 do
        local from = materials[idx]
        local to = materials[idx + 1]
        imgui.Text(from .. " -> " .. to)
    end

    imgui.TreePop()
end

function show_field_unsupported(field_name, description, component_id, field_type)
    imgui.Text(field_name .. " (" .. field_type .. ")")
    imgui.SameLine()
    help.exclam_marker("Field is unsupported. Let me know if you think this is a mistake")
    if description then
        imgui.SameLine()
        help.marker(description)
    end
end

local type_stored_in_vector = {"int", "float", "string"}

function show_field_unknown(name, type, description, component_id)
    if not imgui.TreeNode("UNKNOWN: " .. name .. " (" .. type .. ")") then
        return
    end

    if description then
        imgui.SameLine()
        help.marker(description)
    end

    imgui.Text("ComponentGetValue(component_id, name)                     " .. stringify({ComponentGetValue(component_id, name)}, ""))
    imgui.Text("ComponentGetValue2(component_id, name)                    " .. stringify({ComponentGetValue2(component_id, name)}, ""))
    imgui.Text("ComponentGetValueBool(component_id, name)                 " .. stringify({ComponentGetValueBool(component_id, name)}, ""))
    imgui.Text("ComponentGetValueInt(component_id, name)                  " .. stringify({ComponentGetValueInt(component_id, name)}, ""))
    imgui.Text("ComponentGetValueFloat(component_id, name)                " .. stringify({ComponentGetValueFloat(component_id, name)}, ""))
    imgui.Text("ComponentGetValueVector2(component_id, name)              " .. stringify({ComponentGetValueVector2(component_id, name)}, ""))
    imgui.Text("ComponentGetMetaCustom(component_id, name)                " .. stringify({ComponentGetMetaCustom(component_id, name)}, ""))
    imgui.Text("ComponentObjectGetMembers(component_id, name)             " .. stringify({ComponentObjectGetMembers(component_id, name)}, ""))
    -- imgui.Text("ComponentGetMembers(component_id)                         " .. stringify({ComponentGetMembers(component_id)}, ""))

    local members = ComponentObjectGetMembers(component_id, name) or {}, ""
    for member, value in pairs(members) do
        imgui.Text("----- " .. member)
        imgui.Text("ComponentObjectGetValue(component_id, name, member)      " .. stringify({ComponentObjectGetValue(component_id, name, member)}, ""))
        -- imgui.Text("ComponentObjectGetValueBool(component_id, name, member)  " .. stringify({ComponentObjectGetValueBool(component_id, name, member)}, ""))
        -- imgui.Text("ComponentObjectGetValueInt(component_id, name, member)   " .. stringify({ComponentObjectGetValueInt(component_id, name, member)}, ""))
        -- imgui.Text("ComponentObjectGetValueFloat(component_id, name, member) " .. stringify({ComponentObjectGetValueFloat(component_id, name, member)}, ""))
        imgui.Text("ComponentObjectGetValue2(component_id, name, member)     " .. stringify({ComponentObjectGetValue2(component_id, name, member)}, ""))
    end

    for _, type in ipairs(type_stored_in_vector) do
        imgui.Text("##### " .. type)
        imgui.Text("ComponentGetVectorSize(component_id, name, type)          " .. stringify({ComponentGetVectorSize(component_id, name, type)}, ""))
        imgui.Text("ComponentGetVectorValue(component_id, name, type, 0)      " .. stringify({ComponentGetVectorValue(component_id, name, type, 0)}, ""))
        imgui.Text("ComponentGetVector(component_id, name, type)              " .. stringify({ComponentGetVector(component_id, name, type)}, ""))
    end

    imgui.TreePop()
end

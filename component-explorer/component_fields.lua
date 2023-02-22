dofile_once("mods/component-explorer/utils/stringify.lua")
dofile_once("mods/component-explorer/field_enums.lua")
dofile_once("mods/component-explorer/entity.lua")

function show_field_int(name, description, component_id, get, set)
    local value = (get or ComponentGetValue2)(component_id, name)

    imgui.SetNextItemWidth(200)
    local changed, value = imgui.InputInt(name, value)
    if changed then
        (set or ComponentSetValue2)(component_id, name, value)
    end

    if description then
        imgui.SameLine()
        help_marker(description)
    end
end

show_field_unsignedint = show_field_int
show_field_int16 = show_field_int
show_field_uint16 = show_field_int
show_field_int32 = show_field_int
show_field_uint32 = show_field_int
show_field_int64 = show_field_int
show_field_uint64 = show_field_int

function show_field_float(name, description, component_id, get, set)
    local value = (get or ComponentGetValue2)(component_id, name)

    imgui.SetNextItemWidth(200)
    local changed, value = imgui.InputFloat(name, value, 0.1)
    if changed then
        (set or ComponentSetValue2)(component_id, name, value)
    end

    if description then
        imgui.SameLine()
        help_marker(description)
    end
end

show_field_double = show_field_float

function show_field_bool(name, description, component_id, get, set)
    local value = (get or ComponentGetValue2)(component_id, name)

    local changed, value = imgui.Checkbox(name, value)
    if changed then
        (set or ComponentSetValue2)(component_id, name, value)
    end

    if description then
        imgui.SameLine()
        help_marker(description)
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
        help_marker(description)
    end
end

show_field_USTRING = show_field_std_string

function show_field_vec2(name, description, component_id, get, set)
    local x, y = (get or ComponentGetValue2)(component_id, name)

    imgui.SetNextItemWidth(300)
    local changed, nx, ny = imgui.InputFloat2(name, x, y)
    if changed then
        (set or ComponentSetValue2)(component_id, name, nx, ny)
    end

    if description then
        imgui.SameLine()
        help_marker(description)
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
        help_marker(description)
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
        help_marker(description)
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
        help_marker(description)
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
        help_marker(description)
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
        help_marker(description)
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
        help_marker(description)
    end
end

function show_field_static_text(name, description, component_id)
    local text = tostring(ComponentGetValue2(component_id, name) or "")
    imgui.Text(name .. ": " .. text)

    if description then
        imgui.SameLine()
        help_marker(description)
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
    open_entity_button(entity_id)

    if description then
        imgui.SameLine()
        help_marker(description)
    end
end

local type_stored_in_vector = {"int", "float", "string"}

function show_field_unknown(name, type, description, component_id)
    if not imgui.TreeNode("UNKNOWN: " .. name .. " (" .. type .. ")") then
        return
    end

    if description then
        imgui.SameLine()
        help_marker(description)
    end

    imgui.Text("ComponentGetValue(component_id, name)                     " .. stringify({ComponentGetValue(component_id, name)}))
    imgui.Text("ComponentGetValue2(component_id, name)                    " .. stringify({ComponentGetValue2(component_id, name)}))
    imgui.Text("ComponentGetValueBool(component_id, name)                 " .. stringify({ComponentGetValueBool(component_id, name)}))
    imgui.Text("ComponentGetValueInt(component_id, name)                  " .. stringify({ComponentGetValueInt(component_id, name)}))
    imgui.Text("ComponentGetValueFloat(component_id, name)                " .. stringify({ComponentGetValueFloat(component_id, name)}))
    imgui.Text("ComponentGetValueVector2(component_id, name)              " .. stringify({ComponentGetValueVector2(component_id, name)}))
    imgui.Text("ComponentGetMetaCustom(component_id, name)                " .. stringify({ComponentGetMetaCustom(component_id, name)}))
    imgui.Text("ComponentObjectGetMembers(component_id, name)             " .. stringify({ComponentObjectGetMembers(component_id, name)}))
    -- imgui.Text("ComponentGetMembers(component_id)                         " .. stringify({ComponentGetMembers(component_id)}))

    local members = ComponentObjectGetMembers(component_id, name) or {}
    for member, value in pairs(members) do
        imgui.Text("----- " .. member)
        imgui.Text("ComponentObjectGetValue(component_id, name, member)      " .. stringify({ComponentObjectGetValue(component_id, name, member)}))
        -- imgui.Text("ComponentObjectGetValueBool(component_id, name, member)  " .. stringify({ComponentObjectGetValueBool(component_id, name, member)}))
        -- imgui.Text("ComponentObjectGetValueInt(component_id, name, member)   " .. stringify({ComponentObjectGetValueInt(component_id, name, member)}))
        -- imgui.Text("ComponentObjectGetValueFloat(component_id, name, member) " .. stringify({ComponentObjectGetValueFloat(component_id, name, member)}))
        imgui.Text("ComponentObjectGetValue2(component_id, name, member)     " .. stringify({ComponentObjectGetValue2(component_id, name, member)}))
    end

    for _, type in ipairs(type_stored_in_vector) do
        imgui.Text("##### " .. type)
        imgui.Text("ComponentGetVectorSize(component_id, name, type)          " .. stringify({ComponentGetVectorSize(component_id, name, type)}))
        imgui.Text("ComponentGetVectorValue(component_id, name, type, 0)      " .. stringify({ComponentGetVectorValue(component_id, name, type, 0)}))
        imgui.Text("ComponentGetVector(component_id, name, type)              " .. stringify({ComponentGetVector(component_id, name, type)}))
    end

    imgui.TreePop()
end

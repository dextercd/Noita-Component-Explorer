dofile_once("mods/component-explorer/stringify.lua")

function show_field_int(name, description, component_id)
    local value = ComponentGetValue2(component_id, name)

    imgui.SetNextItemWidth(200)
    local changed, value = imgui.InputInt(name, value)
    if changed then
        ComponentSetValue2(component_id, name, value)
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

function show_field_float(name, description, component_id)
    local value = ComponentGetValue2(component_id, name)

    imgui.SetNextItemWidth(200)
    local changed, value = imgui.InputFloat(name, value, 0.1)
    if changed then
        ComponentSetValue2(component_id, name, value)
    end

    if description then
        imgui.SameLine()
        help_marker(description)
    end
end

show_field_double = show_field_float

function show_field_bool(name, description, component_id)
    local value = ComponentGetValue2(component_id, name)

    local changed, value = imgui.Checkbox(name, value)
    if changed then
        ComponentSetValue2(component_id, name, value)
    end

    if description then
        imgui.SameLine()
        help_marker(description)
    end
end

function show_field_std_string(name, description, component_id)
    local value = ComponentGetValue2(component_id, name)

    imgui.SetNextItemWidth(300)
    local changed, value = imgui.InputText(name, value)
    if changed then
        ComponentSetValue2(component_id, name, value)
    end

    if description then
        imgui.SameLine()
        help_marker(description)
    end
end

function show_field_vec2(name, description, component_id)
    local x, y = ComponentGetValue2(component_id, name)

    imgui.SetNextItemWidth(300)
    local changed, nx, ny = imgui.InputFloat2(name, x, y)
    if changed then
        ComponentSetValue2(component_id, name, nx, ny)
    end

    if description then
        imgui.SameLine()
        help_marker(description)
    end
end

function show_field_ivec2(name, description, component_id)
    local x, y = ComponentGetValue2(component_id, name)

    imgui.SetNextItemWidth(300)
    local changed, nx, ny = imgui.InputInt2(name, x, y)
    if changed then
        ComponentSetValue2(component_id, name, nx, ny)
    end

    if description then
        imgui.SameLine()
        help_marker(description)
    end
end

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


local type_stored_in_vector = {"int", "float", "string"}

function show_field_unknown(name, type, description, component_id)
    if not imgui.TreeNode("UNKNOWN: " .. name .. " (" .. type .. ")") then
        return
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

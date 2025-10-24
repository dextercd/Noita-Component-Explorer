local nxml = dofile_once("mods/component-explorer/deps/nxml.lua")

local function as_set(tbl)
    local set = {}
    for _, value in ipairs(tbl) do
        set[value] = true
    end
    return set
end

local simple_field_types = as_set({
    "int", "unsignedint", "int16", "uint16", "int32", "uint32", "int64",
    "uint64", "float", "double", "bool", "std::string", "std_string",
    "USTRING",
})

local skip_field_types = as_set({
    "EntityID", "LuaManager*", "b2Body*", "b2ObjectID",
})

local int_material_field_names = as_set({
    "material", "material2", "ragdoll_material",
    "material_make_always_cast", "material_remove_shuffle", "material_animate_wand", "material_animate_wand_alt", "material_increase_uses_remaining", "material_sacrifice",
    "chunk_material",
    "from_material", "to_material",
    "good_fx_material", "neutral_fx_material", "evil_fx_material",
    "food_material",
    "food_particle_effect_material",
    "ignored_material",
})

local simple_object_types = as_set({
    "ConfigDamagesByType",
    "ConfigGunActionInfo",
    "ConfigGun",
    "ConfigExplosion",
    "ConfigLaser",
})

function add_field(component_id, component, field_type, field_name)
    if skip_field_types[field_type] then
        return
    elseif field_type == "int" and int_material_field_names[field_name] then
        component.attr[field_name] = CellFactory_GetName(ComponentGetValue2(component_id, field_name))
    elseif simple_field_types[field_type] or string.find(field_type, "::Enum", 1, true) then
        component.attr[field_name] = ComponentGetValue2(component_id, field_name)
    elseif string.find(field_type, "LensValue<", 1, true) then
        component.attr[field_name] = ComponentGetMetaCustom(component_id, field_name)
    elseif field_type == "StatusEffectType" then
        component.attr[field_name] = ComponentGetMetaCustom(component_id, field_name)
    elseif field_type == "vec2" or field_type == "ivec2" then
        local x, y = ComponentGetValue2(component_id, field_name)
        component.attr[field_name .. ".x"] = x
        component.attr[field_name .. ".y"] = y
    elseif field_type == "types::fcolor" then
        local r, g, b, a = ComponentGetValue2(component_id, field_name)
        component.attr[field_name .. ".r"] = r
        component.attr[field_name .. ".g"] = g
        component.attr[field_name .. ".b"] = b
        component.attr[field_name .. ".a"] = a
    elseif field_type == "ValueRange" then
        local min, max = ComponentGetValue2(component_id, field_name)
        component.attr[field_name .. ".min"] = min
        component.attr[field_name .. ".max"] = max
    elseif field_type == "types::aabb" or field_type == "types::iaabb" then
        local min_x, min_y, max_x, max_y = ComponentGetValue2(component_id, field_name)
        component.attr[field_name .. ".min_x"] = min_x
        component.attr[field_name .. ".min_y"] = min_y
        component.attr[field_name .. ".max_x"] = max_x
        component.attr[field_name .. ".max_y"] = max_y
    elseif field_type == "types::xform" then
        local x, y, scale_x, scale_y, rotation = ComponentGetValue2(component_id, field_name)
        local transform = nxml.new_element(field_name)
        transform.attr["position.x"] = x
        transform.attr["position.y"] = y
        transform.attr["rotation"] = rotation
        transform.attr["scale.x"] = scale_x
        transform.attr["scale.y"] = scale_y
        component:add_child(transform)
    elseif simple_object_types[field_type] then
        local object = nxml.new_element(field_name, ComponentObjectGetMembers(component_id, field_name))
        component:add_child(object)
    else
        print("No idea what to do with " .. field_name .. " (" .. field_type .. ")")
    end
end

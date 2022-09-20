dofile_once("mods/component-explorer/serialise_component.lua")
local nxml = dofile_once("mods/component-explorer/deps/nxml.lua")

function serialise_entity(entity_id)
    local entity = nxml.new_element("Entity")

    local name = EntityGetName(entity_id)
    if name ~= "unknown" and name ~= "" then
        entity.attr.name = name
    end

    local tags = EntityGetTags(entity_id)
    if tags ~= "" then
        entity.attr.tags = tags
    end

    local transform = entity_transform(entity_id)
    if transform then
        entity:add_child(transform)
    end

    local component_ids = EntityGetAllComponents(entity_id)
    for _, component_id in ipairs(component_ids) do
        entity:add_child(serialise_component(component_id))
    end

    local child_entity_ids = EntityGetAllChildren(entity_id) or {}
    for _, child_entity_id in ipairs(child_entity_ids) do
        entity:add_child(serialise_entity(child_entity_id))
    end

    return entity
end

function entity_transform(entity_id)
    local transform = nxml.new_element("_Transform")
    local x, y, rotation, scale_x, scale_y = EntityGetTransform(entity_id)

    if x ~= 0 or y ~= 0 then
        transform.attr["position.x"] = x
        transform.attr["position.y"] = y
    end

    if rotation ~= 0 then
        transform.attr["rotation"] = rotation
    end

    if scale_x ~= 0 or scale_y ~= 0 then
        transform.attr["scale.x"] = scale_x
        transform.attr["scale.y"] = scale_y
    end

    if #transform.attr ~= 0 then
        return transform
    end

    return nil
end


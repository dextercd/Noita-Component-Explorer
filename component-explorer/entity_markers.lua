local entity_markers = {}

local entities_with_markers = {}

function entity_markers.has_marker(entity_id)
    local quick_value = entities_with_markers[entity_id]
    if quick_value ~= nil then
        return quick_value
    end
    return entity_markers.really_has_marker(entity_id)
end

function entity_markers.really_has_marker(entity_id)
    if not EntityGetIsAlive(entity_id) then
        return
    end

    local children = EntityGetAllChildren(entity_id)
    if not children then
        return
    end

    for _, child_id in ipairs(children) do
        if EntityGetName(child_id) == "ce_marker" then
            entities_with_markers[entity_id] = child_id
            return child_id
        end
    end
end

function entity_markers.add_marker(entity_id)
    if not EntityGetIsAlive(entity_id) then
        return
    end

    local has_marker = entity_markers.really_has_marker(entity_id)
    entities_with_markers[entity_id] = has_marker
    if has_marker then
        return
    end

    local marker_id = EntityLoad("mods/component-explorer/entities/entity_marker.xml")
    EntityAddChild(entity_id, marker_id)
    entities_with_markers[entity_id] = marker_id
end

function entity_markers.remove_marker(entity_id)
    entities_with_markers[entity_id] = nil
    if not EntityGetIsAlive(entity_id) then
        return
    end

    for _, child_id in ipairs(EntityGetAllChildren(entity_id)) do
        if EntityGetName(child_id) == "ce_marker" then
            EntityKill(child_id)
        end
    end
end

return entity_markers

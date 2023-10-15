local stable_id = {}

local assigned_ids = {}
local key_counters = {}

function stable_id.get(resource, id, key)
    if assigned_ids[resource] == nil then
        assigned_ids[resource] = {}
    end

    if assigned_ids[resource][id] == nil then
        if key_counters[resource] == nil then
            key_counters[resource] = {}
        end

        local current = key_counters[resource][key] or 0
        local new = current + 1
        key_counters[resource][key] = new
        assigned_ids[resource][id] = resource .. "$" .. key .. "$" .. new
    end

    return assigned_ids[resource][id]
end

return stable_id

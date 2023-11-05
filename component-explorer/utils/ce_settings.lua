local ce_settings = {}

local mod_id = "component-explorer"
local settings = {}

local function load_setting_value(key)
    local full_key = mod_id .. "." .. key
    local value = ModSettingGet(full_key)

    -- Seems like 'value_default=false' gets turned into nil by Noita
    if value == nil then
        return false
    end

    return value
end

function ce_settings.load()
    settings = {}
end

function ce_settings.get(key)
    return load_setting_value(key)
    --[[
    if settings[key] == nil then
        settings[key] = load_setting_value(key)
    end

    return settings[key]
    --]]
end

function ce_settings.set(key, value)
    ModSettingSet(mod_id .. "." .. key, value)
    settings[key] = value
end

return ce_settings

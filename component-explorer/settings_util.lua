local mod_id = "component-explorer"
local settings = {}
local settings_keys = {
    "window_open_entity_list",
    "window_open_lua_console",
    "window_open_logs",
    "overlay_open_logs",
    "xml_indent_char",
    "xml_space_count",
    "xml_include_privates",
}

local function load_setting_value(key)
    local full_key = mod_id .. "." .. key
    local value = ModSettingGet(full_key)

    -- Seems like 'value_default=false' gets turned into nil by Noita
    if value == nil then
        return false
    end

    return value
end

function load_settings()
    for _, key in ipairs(settings_keys) do
        settings[key] = load_setting_value(key)
    end
end

function setting_get(key)
    return settings[key]
end

load_settings()

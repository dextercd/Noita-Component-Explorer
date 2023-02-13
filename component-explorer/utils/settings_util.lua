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
    "pause_wands",
    "pause_escape",
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
    settings = {}
end

function setting_get(key)
    if settings[key] == nil then
        settings[key] = load_setting_value(key)
    end

    return settings[key]
end

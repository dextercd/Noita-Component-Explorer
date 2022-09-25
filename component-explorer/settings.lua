dofile("data/scripts/lib/mod_settings.lua")

local mod_id = "component-explorer"
mod_settings_version = 2
mod_settings = {
    {
        category_id = "default_windows",
        ui_name = "Default windows",
        ui_description = "What windows should be opened by default",
        settings = {
            {
                id = "window_open_entity_list",
                ui_name = "Entity list",
                ui_description = "Window that displays all entities",
                value_default = false,
                scope = MOD_SETTING_SCOPE_RUNTIME,
            },
            {
                id = "window_open_lua_console",
                ui_name = "Lua Console",
                ui_description = "Console where you can input Lua expressions",
                value_default = false,
                scope = MOD_SETTING_SCOPE_RUNTIME,
            },
            {
                id = "window_open_logs",
                ui_name = "Logs window",
                ui_description = "logger.txt monitor window",
                value_default = false,
                scope = MOD_SETTING_SCOPE_RUNTIME,
            },
            {
                id = "overlay_open_logs",
                ui_name = "Logs Overlay",
                ui_description = "Overlay displaying the logger.txt file",
                value_default = true,
                scope = MOD_SETTING_SCOPE_RUNTIME,
            },
        },
    },
    {
        category_id = "xml",
        ui_name = "XML Defaults",
        ui_description = "What XML settings are selected by default",
        settings = {
            {
                id = "xml_indent_char",
                ui_name = "Indentation Character",
                ui_description = "What character to use for indentation in the XML exports",
                value_default = "space",
                values = {{"space", "Spaces"}, {"tab", "Tabs"}},
                scope = MOD_SETTING_SCOPE_RUNTIME,
            },
            {
                id = "xml_space_count",
                ui_name = "Spaces indentation: count",
                ui_description = "When using spaces for indentations, how many to use per indentation level",
                value_default = 4,
                value_min = 1,
                value_max = 8,
                scope = MOD_SETTING_SCOPE_RUNTIME,
            },
            {
                id = "xml_include_privates",
                ui_name = "Private fields",
                ui_description = "Include fields that are markes as 'Private' in the component_documentation.txt file",
                value_default = false,
                scope = MOD_SETTING_SCOPE_RUNTIME,
            },
        },
    },
}

function ModSettingsUpdate(init_scope)
    local old_version = mod_settings_get_version(mod_id)
    mod_settings_update(mod_id, mod_settings, init_scope)
end

function ModSettingsGuiCount()
    return mod_settings_gui_count(mod_id, mod_settings)
end

function ModSettingsGui(gui, in_main_menu)
    mod_settings_gui(mod_id, mod_settings, gui, in_main_menu)
end

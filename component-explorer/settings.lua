dofile("data/scripts/lib/mod_settings.lua")

local mod_id = "component-explorer"
mod_settings_version = 2
mod_settings = {
    {
        category_id = "main_window",
        ui_name = "Main window",
        ui_description = "Where to put the main window?",
        settings = {
            {
                id = "main_window_side",
                ui_name = "Main window side",
                ui_description = "What side of the screen should the window be?",
                value_default = "top",
                values = {{"top", "Top"}, {"bottom", "Bottom"}, {"left", "Left"}, {"right", "Right"}},
                scope = MOD_SETTING_SCOPE_RUNTIME,
            },
            {
                id = "main_window_side_offset",
                ui_name = "Main window offset",
                ui_description = "How far along the selected side should the window be?",
                value_default = 95,
                value_min = 0,
                value_max = 100,
                value_display_formatting = " $0 %",
                scope = MOD_SETTING_SCOPE_RUNTIME,
            }
        },
    },
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
    {
        category_id = "pause",
        ui_name = "Pause settings",
        ui_description = "What should the mod do when the game is paused?",
        settings = {
            {
                id = "pause_wands",
                ui_name = "Run in wands menu",
                ui_description = "Should the windows be shown in the wand pickup menu?",
                value_default = true,
                scope = MOD_SETTING_SCOPE_RUNTIME,
            },
            {
                id = "pause_escape",
                ui_name = "Run in escape menu",
                ui_description = "Should component explorer windows be shown in the escape menu?",
                value_default = true,
                scope = MOD_SETTING_SCOPE_RUNTIME,
            },
        },
    },
    {
        category_id = "keyboard",
        ui_name = "Keyboard shortcuts",
        ui_description = "Customize how Component Explorer uses keyboard shortcuts.",
        settings = {
            {
                id = "keyboard_shortcuts",
                ui_name = "Enable Shortcuts",
                ui_description = "Enable/disable all keyboard shortcuts",
                value_default = true,
                scope = MOD_SETTING_SCOPE_RUNTIME,
            }
        }
    },
    {
        category_id = "data_display",
        ui_name = "Data Display",
        ui_description = "How should Component Explorer display data to you?",
        settings = {
            {
                id = "preferred_decimal_format",
                ui_name = "Preferred decimal format",
                value_default = "magnitude",
                values = {
                    {"decimal", "Decimal"},
                    {"all_scientific", "Scientific (all)"},
                    {"double_scientific", "Scientific (only doubles)"},
                    {"magnitude", "Switch on magnitude"},
                },
                scope = MOD_SETTING_SCOPE_RUNTIME,
            }
        }
    },
    {
        category_id = "cursor",
        ui_name = "Cursor settings",
        ui_description = "Default settings for the cursor at launch.",
        settings = {
            {
                id = "keep_visible",
                ui_name = "Visible outside config",
                ui_description = "Keep the cursor visible even when the cursor config is closed.",
                value_default = false,
                scope = MOD_SETTING_SCOPE_RUNTIME,
            },
            {
                id = "parent",
                ui_name = "Cursor parent",
                ui_description = "Relative to what should the cursor be positioned?",
                value_default = "player",
                values = {
                    {"camera", "Camera"},
                    {"world", "World"},
                    {"player", "Player"},
                },
                scope = MOD_SETTING_SCOPE_RUNTIME,
            }
        },
    },
    {
        category_id = "file_viewer",
        ui_name = "File viewer settings",
        ui_description = "Settings that affects the file viewer window.",
        settings = {
            {
                id = "line_numbers",
                ui_name = "Show line numbers in file viewer",
                value_default = true,
                scope = MOD_SETTING_SCOPE_RUNTIME,
            }
        }
    },
    {
        category_id = "unsafe",
        ui_name = "Unsafe Explorer",
        ui_description = "These settings require unsafe explorer to take effect",
        settings = {
            {
                id = "window_open_logs",
                ui_name = "Open Logs window by default",
                ui_description = "logger.txt monitor window",
                value_default = false,
                scope = MOD_SETTING_SCOPE_RUNTIME,
            },
            {
                id = "overlay_open_logs",
                ui_name = "Open Logs Overlay by default",
                ui_description = "Overlay displaying the logger.txt file",
                value_default = false,
                scope = MOD_SETTING_SCOPE_RUNTIME,
            },
            {
                id = "logger_txt",
                ui_name = "Enable logger.txt output",
                ui_description = "Need this if you want to use the logger window or overlay.",
                value_default = true,
                scope = MOD_SETTING_SCOPE_RUNTIME,
            }
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

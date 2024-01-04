---@module 'component-explorer.utils.file_util'
local file_util = dofile_once("mods/component-explorer/utils/file_util.lua")

dofile_once("data/scripts/gun/gun_enums.lua")

local function register_origins(origin)
    for _, action in ipairs(actions) do
        if action.origin == nil then
            action.origin = origin
        end
    end
end

local original_do_mod_appends = do_mod_appends
do_mod_appends = function(appends_for)
    if appends_for == "data/scripts/gun/gun_actions.lua" then
        register_origins("Vanilla")
    else
        local mod_id = string.match(appends_for, "mods/([^/]*)")
        register_origins(mod_id or "Unknown")
    end

    original_do_mod_appends(appends_for)
end
dofile("data/scripts/gun/gun_actions.lua")
do_mod_appends = original_do_mod_appends

local actions = actions

for _, action in ipairs(actions) do
    action.display_name = GameTextGetTranslatedOrNot(action.name)
    action.display_description = GameTextGetTranslatedOrNot(action.description)
end

local action_types = {}

local gun_enums_source = file_util.ModTextFileGetContent("data/scripts/gun/gun_enums.lua")
for k, v in string.gmatch(gun_enums_source, "ACTION_TYPE_([%w_]+)%s*=%s*(%d+)") do
    action_types[tonumber(v)] = k
end

local unique_action_types = {}
for i=0,#action_types do
    table.insert(unique_action_types, action_types[i])
end

---@param act integer
---@return string
local function action_type_to_name(act)
    return action_types[act]
end

return {
    actions=actions,
    unique_action_types=unique_action_types,
    action_type_to_name=action_type_to_name,
}

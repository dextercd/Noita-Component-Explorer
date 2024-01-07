dofile_once("data/scripts/gun/gun_actions.lua")

---@module 'component-explorer.utils.wiki'
local wiki = dofile_once("mods/component-explorer/utils/wiki.lua")

---@module 'component-explorer.utils.tcsv'
local tcsv = dofile_once("mods/component-explorer/utils/tcsv.lua")

local wiki_spell_names = {}

---action_long_distance_cast -> Long-distance cast
---@type {[string]: string}
local english_lookup = {}

---@param csv_file string
local function register_en_translations(csv_file)
    local csv = tcsv.parse(ModTextFileGetContent(csv_file), csv_file, false)
    for i=2,#csv.rows do
        local row = csv.rows[i]
        english_lookup[row[1]] = row[2]
    end
end

register_en_translations("data/translations/common_dev.csv")
register_en_translations("data/translations/common.csv")

wiki_spell_names.by_action_id = {}
for _, action in ipairs(actions) do
    local name = action.name

    -- Modded spells might not be using translations
    if name:sub(1, 1) == "$" then
        local without_dollar = name:sub(2)
        local english_name = english_lookup[without_dollar]
        if english_name then
            name = wiki.normalise_spell_name(english_name)
        else
            -- Probably not correct, just a last ditch effort
            name = without_dollar
        end
    end

    wiki_spell_names.by_action_id[action.id] = name
end

local to_action_id = {}
for action_id, name in pairs(wiki_spell_names.by_action_id) do
    to_action_id[name:lower()] = action_id
end

function wiki_spell_names.to_action_id(name)
    return to_action_id[name:lower()]
end

return wiki_spell_names

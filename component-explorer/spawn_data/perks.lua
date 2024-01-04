dofile_once("data/scripts/perks/perk.lua")

function register_origins(origin)
    for _, perk in ipairs(perk_list) do
        if perk.origin == nil then
            perk.origin = origin
        end
    end
end

local original_do_mod_appends = do_mod_appends
do_mod_appends = function(appends_for)
    if appends_for == "data/scripts/perks/perk_list.lua" then
        register_origins("Vanilla")
    else
        local mod_id = string.match(appends_for, "mods/([^/]*)")
        register_origins(mod_id or "Unknown")
    end

    original_do_mod_appends(appends_for)
end
dofile("data/scripts/perks/perk_list.lua")
do_mod_appends = original_do_mod_appends

local perk_list = perk_list

for _, perk in ipairs(perk_list) do
    perk.display_name = GameTextGetTranslatedOrNot(perk.ui_name)
    perk.display_description = GameTextGetTranslatedOrNot(perk.ui_description)
end

return perk_list

---@module 'component-explorer.wand_sprites'
local wand_sprites = dofile_once("mods/component-explorer/wand_sprites.lua")

---@module 'component-explorer.utils.wiki_spell_names'
local wiki_spell_names = dofile_once("mods/component-explorer/utils/wiki_spell_names.lua")

---@module 'component-explorer.utils.wiki'
local wiki = dofile_once("mods/component-explorer/utils/wiki.lua")

---@module 'component-explorer.utils.strings'
local string_util = dofile_once("mods/component-explorer/utils/strings.lua")

local wiki_wand = {}

---Turn an EZWand object into a list of values used in Wand/Wand Card templates
---@param ezwand table
---@param to_wand_card boolean
---@return table
function wiki_wand.get_wand_values(ezwand, to_wand_card)
    local values = {}
    local wiki_file_name = wand_sprites.wiki_sprite_filename(ezwand)

    if to_wand_card then
        local item_name = nil

        local item_comp = EntityGetFirstComponentIncludingDisabled(ezwand.entity_id, "ItemComponent")
        if item_comp then
            if ComponentGetValue2(item_comp, "always_use_item_name_in_ui") then
                item_name = ComponentGetValue2(item_comp, "item_name")
            end
        end

        if item_name then
            table.insert(values, {"wandName", GameTextGetTranslatedOrNot(item_name)})
        end
    end

    if wiki_file_name then
        table.insert(values, {"wandPic", wiki_file_name})
    end

    if ezwand.shuffle then
        table.insert(values, {"shuffle", "Yes"})
    end

    if ezwand.spellsPerCast ~= 1 then
        table.insert(values, {"spellsCast", ezwand.spellsPerCast})
    end

    if to_wand_card then
        table.insert(values, {"castDelay", ("%.2f"):format(ezwand.castDelay / 60)})
        table.insert(values, {"rechargeTime", ("%.2f"):format(ezwand.rechargeTime / 60)})
        table.insert(values, {"manaMax", ("%.2f"):format(ezwand.manaMax)})
        table.insert(values, {"manaCharge", ("%.2f"):format(ezwand.manaChargeSpeed)})
    end

    local spells, attached_spells = ezwand:GetSpells()

    if to_wand_card then
        table.insert(values, {"capacity", ezwand.capacity})
    else
        table.insert(values, {"capacity", #spells})
    end

    if to_wand_card then
        table.insert(values, {"spread", ezwand.spread})
        table.insert(values, {"speed", ("%.2f"):format(ezwand.speedMultiplier)})
    end

    for _, spell in ipairs(attached_spells) do
        local wiki_name = wiki_spell_names.by_action_id[spell.action_id]
        table.insert(values, {"alwaysCasts", wiki_name})
    end

    local spell_nr = 1
    for _, spell in ipairs(spells) do
        local wiki_name = wiki_spell_names.by_action_id[spell.action_id]
        table.insert(values, {"spell" .. spell_nr, wiki_name})
        spell_nr = spell_nr + 1
    end

    return values
end

---Turn an EZWand object into wiki wand text
---@param ezwand table
---@param to_wand_card boolean
---@return string
function wiki_wand.wand_to_wiki_text(ezwand, to_wand_card)
    local wand_values = wiki_wand.get_wand_values(ezwand, to_wand_card)

    if to_wand_card then
        return wiki.format_template("Wand Card", wand_values, 12)
    else
        return wiki.format_template("Wand", wand_values, 11)
    end
end

---Turn range text like "(3 - 8.5)" to values 3, 8.5. Also parses a single value successfully.
---@param range string|number
---@return number
---@return number
function wiki_wand.field_range_value(range)
    if type(range) == "number" then
        return range, range
    end

    range = string_util.strip(range)
    range = string_util.remove_prefix(range, "x") -- speed = x 1.25
    range = string_util.strip(range)

    if range:sub(1, 1) ~= "(" then
        local value = tonumber(range)
        if value == nil then
            error("Couldn't parse range/value")
        end
        return value, value
    end
    local min, max
    local dash_pos = range:find("-", 3, true)
    if dash_pos then
        min = tonumber(range:sub(2, dash_pos - 1))
        max = tonumber(range:sub(dash_pos + 1, #range - 1))
    end

    if min == nil or max == nil then
        error("Couldn't parse range/value")
    end

    if min > max then
        min, max = max, min
    end

    return min, max
end

wiki_wand.FIELD_RANGES = {
    {"i", "spellsCast"},
    {"f", "castDelay"},
    {"f", "rechargeTime"},
    {"i", "manaMax"},
    {"i", "manaCharge"},
    {"i", "capacity"},
    {"f", "spread"},
    {"f", "speed"},
}

wiki_wand.SUPPORTS_FIELD_RANGE = {}
for _, field_range in ipairs(wiki_wand.FIELD_RANGES) do
    local field_name = field_range[2]
    wiki_wand.SUPPORTS_FIELD_RANGE[field_name] = true
end

local function set_sprite_by_filename(ezwand, filename)
    local data = wand_sprites.from_wiki_name(filename)
    if data == nil then return false end

    ezwand:SetSprite(
        data.sprite_file or data.image_file,
        data.offset_x, data.offset_y,
        data.tip_x, data.tip_y)

    return true
end

function wiki_wand.load_data_to_wand(wand, template_data)
    map = {}
    for _, v in ipairs(template_data.values) do
        if wiki_wand.SUPPORTS_FIELD_RANGE[v[1]] then
            map[v[1]] = wiki_wand.field_range_value(v[2])
        else
            map[v[1]] = v[2]
        end
    end

    if map.wandPic then
        set_sprite_by_filename(wand, map.wandPic)
    end

    if map.wandName then
        local item_comp = EntityGetFirstComponentIncludingDisabled(wand.entity_id, "ItemComponent")
        ComponentSetValue2(item_comp, "always_use_item_name_in_ui", true)
        ComponentSetValue2(item_comp, "item_name", map.wandName)
    end

    wand.shuffle = map.shuffle == "true"
    wand.spellsPerCast = tonumber(map.spellsCast) or 1

    map.castDelay = tonumber(map.castDelay)
    map.rechargeTime = tonumber(map.rechargeTime)
    map.manaMax = tonumber(map.manaMax)
    map.manaCharge = tonumber(map.manaCharge)
    map.capacity = tonumber(map.capacity)
    map.spread = tonumber(map.spread)
    map.speed = tonumber(map.speed)

    if map.castDelay then
        wand.castDelay = map.castDelay * 60
    end

    if map.rechargeTime then
        wand.rechargeTime = map.rechargeTime * 60
    end

    if map.manaMax then
        wand.manaMax = map.manaMax
    end

    if map.manaCharge then
        wand.manaChargeSpeed = map.manaCharge
    end

    wand.capacity = map.capacity

    if map.spread then
        wand.spread = map.spread
    end

    if map.speed then
        wand.speedMultiplier = map.speed
    end

    wand:DetachSpells()
    for _, item in ipairs(template_data.values) do
        if item[1] == "alwaysCasts" then
            local action_id = wiki_spell_names.to_action_id(item[2])
            wand:AttachSpells(action_id)
        end
    end

    wand:RemoveSpells()
    for spell_nr=1, map.capacity do
        local spell_name = map["spell" .. spell_nr]
        if spell_name ~= nil then
            local action_id = wiki_spell_names.to_action_id(spell_name)
            wand:AddSpells(action_id)
        end
    end
end

return wiki_wand

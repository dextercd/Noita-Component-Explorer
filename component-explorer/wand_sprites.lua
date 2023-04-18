dofile("mods/component-explorer/unique_wand_sprites.lua")
local wiki = dofile_once("mods/component-explorer/utils/wiki.lua")
local string_util = dofile_once("mods/component-explorer/utils/strings.lua")

local wand_sprites = {}

dofile_once("data/scripts/gun/procedural/wands.lua")

local procedural_wands = {}
for _, wand in ipairs(wands) do
    local sprite_path = string_util.split(wand.file, "/", true)
    local sprite_filename = sprite_path[#sprite_path]
    local wiki_name = wiki.normalise_name(sprite_filename)
    procedural_wands[wiki_name] = {
        offset_x = wand.grip_x,
        offset_y = wand.grip_y,
        tip_x = (wand.tip_x - wand.grip_x),
        tip_y = (wand.tip_y - wand.grip_y),
        image_file = wand.file,
        wiki_file = wiki_name,
    }
end

function wand_sprites.from_wiki_name(name)
    name = wiki.normalise_name(name)

    local procedural = procedural_wands[name]
    if procedural then return procedural end

    for _, v in ipairs(unique_wand_sprites) do
        if v.wiki_file == name then
            return v
        end
    end

    return nil
end

function wand_sprites.wiki_sprite_filename(wand)
    local sprite1
    local sprite2

    if wand.ability_component then
        sprite1 = ComponentGetValue2(wand.ability_component, "sprite_file")
    end

    local sprite_comp = EntityGetFirstComponentIncludingDisabled(wand.entity_id, "SpriteComponent", "item")
    if sprite_comp then
        sprite2 = ComponentGetValue2(sprite_comp, "image_file")
    end

    -- Some wand scripts like data/scripts/gun/procedural/wand_vihta.lua replace
    -- the sprite on the sprite/item component but not the ability component.

    for _, v in ipairs(unique_wand_sprites) do
        if (sprite2 and sprite2 == v.image_file) or sprite1 == v.sprite_file then
            -- For some reason the offsets that were extracted aren't accurate.
            -- Replacing with 4 seems more accurate overall but not perfect.
            v.offset_x = 4
            v.offset_y = 4
            return v.wiki_file
        end
    end

    if string_util.ends_with(sprite1, ".png") then
        local path = string_util.split(sprite1, "/", true)
        local filename = path[#path]
        return wiki.normalise_name(filename)
    end

    return nil
end

return wand_sprites

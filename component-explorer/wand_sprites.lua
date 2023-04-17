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

function wand_sprites.to_wiki_name(sprite_file)
    if string_util.ends_with(sprite_file, ".png") then
        local path = string_util.split(sprite_file, "/", true)
        local filename = path[#path]
        return wiki.normalise_name(filename)
    end

    for _, v in ipairs(unique_wand_sprites) do
        if v.sprite_file == sprite_file then
            -- For some reason the offsets that were extracted aren't accurate.
            -- Replacing with 4 seems more accurate overall but not perfect.
            v.offset_x = 4
            v.offset_y = 4
            return v.wiki_file
        end
    end

    return nil
end

return wand_sprites

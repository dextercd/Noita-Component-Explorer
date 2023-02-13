local style = dofile_once("mods/component-explorer/style.lua")
local EZWand = dofile_once("mods/component-explorer/deps/EZWand.lua")
local string_util = dofile_once("mods/component-explorer/utils/strings.lua")
local wiki_spell_names = dofile_once("mods/component-explorer/utils/wiki_spell_names.lua")
local wiki = dofile_once("mods/component-explorer/utils/wiki.lua")

local function get_wand_values(wand, wand_card)
    local values = {}
    local sprite_path = string_util.split(wand:GetSprite(), "/", true)
    local sprite_filename = sprite_path[#sprite_path]

    if wand_card then
        table.insert(values, {"wandName", "My Wand"})
    end

    table.insert(values, {"wandPic", sprite_filename})

    if wand.shuffle then
        table.insert(values, {"shuffle", "Yes"})
    end

    if wand.spellsPerCast ~= 1 then
        table.insert(values, {"spellsCast", wand.spellsPerCast})
    end

    if wand_card then
        table.insert(values, {"castDelay", ("%.2f"):format(wand.castDelay / 60)})
        table.insert(values, {"rechargeTime", ("%.2f"):format(wand.rechargeTime / 60)})
        table.insert(values, {"manaMax", ("%.2f"):format(wand.manaMax)})
        table.insert(values, {"manaCharge", ("%.2f"):format(wand.manaChargeSpeed)})
    end

    local spells, attached_spells = wand:GetSpells()
    table.insert(values, {"capacity", #spells})

    if wand_card then
        table.insert(values, {"spread", wand.spread})
        table.insert(values, {"speed", ("%.2f"):format(wand.speedMultiplier)})
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

local function wand_get_wiki_text(wand, wand_card)
    local wand_values = get_wand_values(wand, wand_card)

    if wand_card then
        return wiki.format_template("Wand Card", wand_values, 12)
    else
        return wiki.format_template("Wand", wand_values, 11)
    end
end

window_open_wiki_wands = false

local function wiki_wands_contents()
    local wand = EZWand.GetHeldWand()
    if not wand then
        imgui.PushStyleColor(imgui.Col.Text, unpack(style.colour_warn))
        imgui.Text("No wand currently held")
        imgui.PopStyleColor()
        return
    end

    if not imgui.BeginTabBar("wiki_wand_tabs") then
        return
    end

    if imgui.BeginTabItem("Wand") then
        local wand_text = wand_get_wiki_text(wand, false)
        if imgui.Button("Copy") then
            imgui.SetClipboardText(wand_text)
        end

        imgui.Text(wand_text)
        imgui.EndTabItem()
    end

    if imgui.BeginTabItem("Wand Card") then
        local wand_text = wand_get_wiki_text(wand, true)
        if imgui.Button("Copy") then
            imgui.SetClipboardText(wand_text)
        end

        imgui.Text(wand_text)
        imgui.EndTabItem()
    end

    if imgui.BeginTabItem("About") then
        imgui.TextWrapped(table.concat({
            "The Noita wiki (noita.wiki.gg) could use more inspiring wand builds and demo GIF's!\n",
            "Noita includes a built-in GIF recorder and this mod should make it easier to use the wand templates on the wiki.",
            "\n\n",
            "In most cases the spells are the most important thing and the exact wand stats aren't that important, ",
            "so you should prefer the 'Wand' template over the 'Wand Card' template usually.",
            "\n\n",
            "If you need help with something, you can visit the #noita-wiki channel in the Noita Discord server."
        }))
        imgui.EndTabItem()
    end

    imgui.EndTabBar()
end

function show_wiki_wands()
    local should_show
    should_show, window_open_wiki_wands = imgui.Begin("Wiki Wands", window_open_wiki_wands)

    if not should_show then
        return
    end

    wiki_wands_contents()

    imgui.End()
end

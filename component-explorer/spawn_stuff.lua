local spawn_stuff = {}

spawn_stuff.open = false

function spawn_stuff.show()
    -- Loaded with a delay because these files need to use the translations

    ---@module 'component-explorer.spawn_stuff.creatures'
    local creature_content = dofile_once("mods/component-explorer/spawn_stuff/creatures.lua")

    ---@module 'component-explorer.spawn_stuff.items'
    local item_content = dofile_once("mods/component-explorer/spawn_stuff/items.lua")

    ---@module 'component-explorer.spawn_stuff.perks'
    local perk_content = dofile_once("mods/component-explorer/spawn_stuff/perks.lua")

    ---@module 'component-explorer.spawn_stuff.spells'
    local spell_content = dofile_once("mods/component-explorer/spawn_stuff/spells.lua")

    ---@module 'component-explorer.spawn_stuff.materials'
    local material_content = dofile_once("mods/component-explorer/spawn_stuff/materials.lua")

    imgui.SetNextWindowSize(480, 200, imgui.Cond.FirstUseEver)

    local show
    show, spawn_stuff.open = imgui.Begin("Spawn Stuff", spawn_stuff.open)

    if not show then
        return
    end

    if imgui.BeginTabBar("spawn_stuff") then
        if imgui.BeginTabItem("Creatures") then
            if imgui.BeginChild("#creatures_child") then
                creature_content()
                imgui.EndChild()
            end
            imgui.EndTabItem()
        end

        if imgui.BeginTabItem("Items") then
            if imgui.BeginChild("#items_child") then
                item_content()
                imgui.EndChild()
            end
            imgui.EndTabItem()
        end

        if imgui.BeginTabItem("Perks") then
            if imgui.BeginChild("#perks_child") then
                perk_content()
                imgui.EndChild()
            end
            imgui.EndTabItem()
        end

        if imgui.BeginTabItem("Spells") then
            if imgui.BeginChild("#spells_child") then
                spell_content()
                imgui.EndChild()
            end
            imgui.EndTabItem()
        end

        if imgui.BeginTabItem("Materials") then
            if imgui.BeginChild("#materials_child") then
                material_content()
                imgui.EndChild()
            end
            imgui.EndTabItem()
        end

        imgui.EndTabBar()
    end

    imgui.End()
end

return spawn_stuff

Hey mod developer!

Your custom perks, spells, and materials should show up automatically. In the
case of materials, the origin is only deduced correctly when
`ModMaterialFilesGet()` is available.

Creatures and items use a hardcoded list. See the items.lua and
creatures.lua file for the kind of data it contains. You can append to
this list in your mod if you want your things to show up in Component Explorer.

This is what that would look like:

```lua
-- File: mods/<your mod>/init.lua
ModLuaFileAppend(
    "mods/component-explorer/spawn_data/creatures.lua",
    "mods/<your mod>/files/ce_creatures.lua"
)
```

```lua
-- File: mods/<your mod>/files/ce_creatures.lua
local creatures = dofile_once("mods/component-explorer/spawn_data/creatures.lua")

table.insert(creatures,
    {
        file="mods/<your mod>/files/animals/omega_hamis.xml",
        herd="spider",
        name="$animal_yourmod_omegahamis",
        origin="<Your Mod>",
        tags="mortal,teleportable_NOT,friend,hittable_NOT"
    })
```

After adding that code into your mod, the creature should show up inside
Component Explorer.

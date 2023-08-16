beta_version = dofile("mods/component-explorer/utils/beta_version.lua")

if beta_version.august_beta then
    dofile("mods/component-explorer/components_beta.lua")
else
    dofile("mods/component-explorer/components_main.lua")
end

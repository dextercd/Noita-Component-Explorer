beta_version = dofile("mods/component-explorer/utils/beta_version.lua")

if beta_version.august_beta then
    dofile("mods/component-explorer/serialise_component_beta.lua")
else
    dofile("mods/component-explorer/serialise_component_main.lua")
end

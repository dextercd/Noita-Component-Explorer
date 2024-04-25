local beta_version = dofile("mods/component-explorer/utils/beta_version.lua")

if beta_version.is_beta then
    return dofile("mods/component-explorer/serialise_component_beta.lua")
else
    return dofile("mods/component-explorer/serialise_component_main.lua")
end

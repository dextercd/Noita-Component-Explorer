local beta_version = dofile("mods/component-explorer/utils/beta_version.lua")

if beta_version.dec31_beta then
    return dofile("mods/component-explorer/configs_beta.lua")
else
    return dofile("mods/component-explorer/configs_main.lua")
end


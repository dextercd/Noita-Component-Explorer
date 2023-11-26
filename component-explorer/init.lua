if not is_unsafe_explorer and ModIsEnabled("unsafe-explorer") then
    return
end

if not load_imgui then
    function OnWorldInitialized()
        EntityLoad("mods/component-explorer/entities/imgui_warning.xml")
    end
    error("Missing ImGui.")
else
    function OnModPostInit()
        -- Delay dofile calls until latter end of mod initialisation, so that other
        -- mods can do ModLuaFileAppend to the component-explorer files.
        dofile("mods/component-explorer/main.lua")
    end
end

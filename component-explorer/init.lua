if not is_unsafe_explorer and ModIsEnabled("unsafe-explorer") then
    return
end

if not load_imgui then
    function OnWorldInitialized()
        EntityLoad("mods/component-explorer/entities/imgui_warning.xml")
    end
    error("Missing ImGui.")
else
    local success, result
    function OnModPostInit()
        -- Delay dofile calls until latter end of mod initialisation, so that other
        -- mods can do ModLuaFileAppend to the component-explorer files.
        success, result = pcall(dofile, "mods/component-explorer/main.lua")
    end

    function OnWorldInitialized()
        if not success then
            print("CE init error: " .. tostring(result))
        end
    end
end

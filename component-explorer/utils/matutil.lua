local matutil = {}

local _all_materials = nil
function matutil.get_all_material_names()
    if _all_materials == nil then
        _all_materials = {}
        local i = 0
        while true do
            local material_name = CellFactory_GetName(i)
            if material_name == "unknown" then
                break
            end

            table.insert(_all_materials, material_name)
            i = i + 1
        end
    end
    return _all_materials
end

function matutil.material_name(matid)
    return matutil.get_all_material_names()[matid + 1]
end

return matutil

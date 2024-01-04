---@module 'component-explorer.utils.file_util'
local file_util = dofile_once("mods/component-explorer/utils/file_util.lua")

---@module 'component-explorer.utils.copy'
local copy = dofile_once("mods/component-explorer/utils/copy.lua")

---@module 'component-explorer.deps.nxml'
local nxml = dofile_once("mods/component-explorer/deps/nxml.lua")

local materials_by_name = {}
local parent_pending = {}

local function add_celldata_with_base(celldata, base, origin)
    local mat = copy.shallow_copy(base)

    local copy_attr = function(attr, default)
        local value = celldata.attr[attr]
        if value then
            mat[attr] = value
        elseif mat[attr] == nil then
            mat[attr] = default
        end
    end

    copy_attr("name")
    mat.id = CellFactory_GetType(mat.name)
    copy_attr("ui_name")
    copy_attr("tags", "")
    copy_attr("cell_type", "liquid")
    copy_attr("liquid_sand")
    copy_attr("liquid_static")

    if mat.cell_type == "fire" then
        mat.material_type = "Fire"
    elseif mat.cell_type == "gas" then
        mat.material_type = "Gas"
    elseif mat.cell_type == "solid" then
        mat.material_type = "Solid"
    elseif mat.cell_type == "liquid" then
        if mat.liquid_static == "1" then
            mat.material_type = "Static"
        elseif mat.liquid_sand == "1" then
            mat.material_type = "Powder"
        else
            mat.material_type = "Liquid"
        end
    end

    mat.display_name = mat.ui_name and GameTextGetTranslatedOrNot(mat.ui_name)
    if mat.display_name == nil or mat.display_name == "" then
        mat.display_name = mat.name
    end

    mat.origin = origin

    materials_by_name[mat.name] = mat
end

local function add_celldata(celldata, origin)
    local mat_name = celldata.attr.name

    local base
    if celldata.name == "CellDataChild" then
        local parent_name = celldata.attr._parent
        local parent = materials_by_name[parent_name]
        if parent then
            base = parent
        else
            parent_pending[parent_name] = parent_pending[parent_name] or {}
            table.insert(parent_pending[parent_name], celldata)
            return
        end
    elseif celldata.name == "CellData" then
        base = {}
    else
        error("Unknown celldata type")
    end

    add_celldata_with_base(celldata, base, origin)

    if parent_pending[mat_name] then
        for _, child_celldata in ipairs(parent_pending[mat_name]) do
            add_celldata(child_celldata, origin)
        end
        parent_pending[mat_name] = {}
    end
end

local function register_materials_file(materials_file, origin)
    local celldatas = nxml.parse(file_util.ModTextFileGetContent(materials_file))

    for _, child in ipairs(celldatas.children) do
        if child.name == "CellData" or child.name == "CellDataChild" then
            add_celldata(child, origin)
        end
    end

    for _, pending in pairs(parent_pending) do
        for _, celldata in ipairs(pending) do
            add_celldata_with_base(celldata, {}, origin)
        end
    end
end

if ModMaterialsFileAdd then
    -- ModMaterialsFileAdd available, we can use register_materials_file for
    -- the vanilla materials file and modded ones.
    for _, mat_file in ipairs(ModMaterialFilesGet()) do
        local origin
        if mat_file == "data/materials.xml" then
            origin = "Vanilla"
        else
            origin = string.match(mat_file, "mods/([^/]*)")
        end
        register_materials_file(mat_file, origin or "Unknown")
    end
else
    -- ModMaterialsFileAdd not available, use register_materials_file for
    -- vanilla and try to identify and register all modded materials.
    register_materials_file("data/materials.xml", "Vanilla")

    local vanilla_mats = {}
    for _, mat in pairs(materials_by_name) do
        vanilla_mats[mat.id] = true
    end

    local function mat_set(mat_ids)
        local set = {}
        for _, mat_name in ipairs(mat_ids) do
            set[mat_name] = true
        end
        return set
    end
    local liquids = mat_set(CellFactory_GetAllLiquids(false, true))
    local liquids_and_statics = mat_set(CellFactory_GetAllLiquids(true, true))
    local powders = mat_set(CellFactory_GetAllSands(false, true))
    local powders_and_statics = mat_set(CellFactory_GetAllSands(false, true))
    local gases = mat_set(CellFactory_GetAllGases(true, true))
    local fires = mat_set(CellFactory_GetAllFires(true, true))
    local solids = mat_set(CellFactory_GetAllSolids(true, true))

    local all_sets = {
        liquids_and_statics,
        powders_and_statics,
        gases,
        fires,
        solids
    }

    local full_set ={}
    for _, set in ipairs(all_sets) do
        for mat_name, _ in pairs(set) do
            full_set[mat_name] = true
        end
    end

    local all_mat_names = {}
    for mat_name, _ in pairs(full_set) do
        table.insert(all_mat_names, mat_name)
    end
    table.sort(all_mat_names)

    for _, mat_name in ipairs(all_mat_names) do
        local mat_id = CellFactory_GetType(mat_name)
        if vanilla_mats[mat_id] then goto continue end

        local cell_type =
            ((liquids_and_statics[mat_name] or powders_and_statics[mat_name]) and "liquid")
            or (gases[mat_name] and "gas")
            or (fires[mat_name] and "fire")
            or (solids[mat_name] and "solid")

        local material_type =
            (liquids[mat_name] and "Liquid")
            or (powders[mat_name] and "Powder")
            or (not liquids[mat_name] and (liquids_and_statics[mat_name] or powders_and_statics[mat_name]) and "Static")
            or (gases[mat_name] and "Gas")
            or (fires[mat_name] and "Fire")
            or (solids[mat_name] and "Solid")
            or "Uhmm"

        local mat = {
            origin="Modded",
            id=mat_id,
            name=mat_name,
            ui_name=CellFactory_GetUIName(mat_name),
            tags=table.concat(CellFactory_GetTags(mat_id), ","),
            cell_type=cell_type,
            material_type=material_type,
        }

        mat.display_name = mat.ui_name and GameTextGetTranslatedOrNot(mat.ui_name)
        if mat.display_name == nil or mat.display_name == "" then
            mat.display_name = mat.name
        end

        materials_by_name[mat.name] = mat

        ::continue::
    end
end

local materials = {}
for _, mat in pairs(materials_by_name) do
    table.insert(materials, mat)
end
table.sort(materials, function(a, b) return a.id < b.id end)

return materials

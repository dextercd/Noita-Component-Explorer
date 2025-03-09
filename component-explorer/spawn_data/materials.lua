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

for _, mat_file in ipairs(ModMaterialFilesGet()) do
    local origin
    if mat_file == "data/materials.xml" then
        origin = "Vanilla"
    else
        origin = string.match(mat_file, "mods/([^/]*)")
    end
    register_materials_file(mat_file, origin or "Unknown")
end

local materials = {}
for _, mat in pairs(materials_by_name) do
    table.insert(materials, mat)
end
table.sort(materials, function(a, b) return a.id < b.id end)

return materials

---@module 'component-explorer.utils.strings'
local string_util = dofile_once("mods/component-explorer/utils/strings.lua")

---@module 'component-explorer.ui.ui_combo'
local ui_combo = dofile_once("mods/component-explorer/ui/ui_combo.lua")

---@module 'component-explorer.utils.player_util'
local player_util = dofile_once("mods/component-explorer/utils/player_util.lua")

---@module 'component-explorer.spawn_data.materials'
local materials = dofile_once("mods/component-explorer/spawn_data/materials.lua")

local function get_unique_attrs(attr)
    local set = {}
    for _, mat in ipairs(materials) do
        set[mat[attr]] = true
    end

    local ret = {}
    for item, _ in pairs(set) do
        table.insert(ret, item)
    end

    table.sort(ret)
    return ret
end
local unique_origins = get_unique_attrs("origin")
local unique_material_types = get_unique_attrs("material_type")

local function make_empty_stash(x, y)
    local stash = EntityLoad("data/entities/items/pickup/powder_stash.xml", x, y)
    while true do
        local mat_id = GetMaterialInventoryMainMaterial(stash)
        if mat_id == 0 then
            return stash
        end
        AddMaterialInventoryMaterial(stash, CellFactory_GetName(mat_id), 0)
    end
end

---@param entity integer
---@return integer
local function container_matinv_size(entity)
    local sucker_comp = EntityGetFirstComponentIncludingDisabled(entity, "MaterialSuckerComponent")
    if sucker_comp then
        return ComponentGetValue2(sucker_comp, "barrel_size")
    end

    -- Fallback default
    return 1000
end

local filter_search = ""
---@type string?
local filter_origin = nil
---@type string?
local filter_material_type = nil

local container_options = {"Flask", "Pouch"}
local container_choice = nil

local function mat_container_choice(mat)
    if container_choice then return container_choice end

    if mat.material_type == "Powder" or mat.material_type == "Static" then
        return "Pouch"
    else
        return "Flask"
    end
end

return function()
    local _

    imgui.SetNextItemWidth(200)
    _, filter_search = imgui.InputText("Search", filter_search)

    imgui.SameLine()
    imgui.SetNextItemWidth(150)
    _, filter_material_type = ui_combo.optional("Material Type", unique_material_types, filter_material_type)

    if #unique_origins > 1 then
        imgui.SameLine()
        imgui.SetNextItemWidth(150)
        _, filter_origin = ui_combo.optional("Origin", unique_origins, filter_origin)
    end

    imgui.Separator()

    imgui.SetNextItemWidth(150)
    _, container_choice = ui_combo.optional("Spawn Container", container_options, container_choice, "--Depends--")
    if not imgui.BeginChild("table") then
        return
    end

    local filtered_materials
    if filter_search == "" and filter_material_type == nil and filter_origin == nil then
        filtered_materials = materials
    else
        filtered_materials = {}
        for _, mat in ipairs(materials) do
            if
                (filter_search == "" or (
                    string_util.ifind(mat.display_name, filter_search, 1, true) or
                    string_util.ifind(mat.name, filter_search, 1, true) or
                    string_util.ifind(mat.tags, filter_search, 1, true)
                ))
                and (filter_material_type == nil or mat.material_type == filter_material_type)
                and (filter_origin == nil or mat.origin == filter_origin)
            then
                table.insert(filtered_materials, mat)
            end
        end
    end

    local flags = bit.bor(
        imgui.TableFlags.Resizable,
        imgui.TableFlags.Hideable,
        imgui.TableFlags.RowBg
    )

    if imgui.BeginTable("mats", 7, flags) then
        imgui.TableSetupColumn("#", imgui.TableColumnFlags.WidthFixed)
        imgui.TableSetupColumn("Display")
        imgui.TableSetupColumn("Name", imgui.TableColumnFlags.DefaultHide)
        imgui.TableSetupColumn("Tags", imgui.TableColumnFlags.DefaultHide)
        imgui.TableSetupColumn("Type", imgui.TableColumnFlags.WidthFixed)
        imgui.TableSetupColumn("Origin", imgui.TableColumnFlags.WidthFixed)
        imgui.TableSetupColumn("Spawn", imgui.TableColumnFlags.WidthFixed)
        imgui.TableHeadersRow()

        local clipper = imgui.ListClipper.new()
        clipper:Begin(#filtered_materials)

        while clipper:Step() do
            for i=clipper.DisplayStart,clipper.DisplayEnd - 1 do
                local mat = filtered_materials[i + 1]
                imgui.PushID(mat.name)

                imgui.TableNextColumn()
                imgui.Text(tostring(mat.id))

                imgui.TableNextColumn()
                imgui.Text(mat.display_name)

                imgui.TableNextColumn()
                imgui.Text(mat.name)

                imgui.TableNextColumn()
                imgui.Text(mat.tags)

                imgui.TableNextColumn()
                imgui.Text(mat.material_type)
                if imgui.IsItemHovered() and imgui.IsMouseReleased(imgui.MouseButton.Right) then
                    filter_material_type = mat.material_type
                end

                imgui.TableNextColumn()
                imgui.Text(mat.origin)
                if #unique_origins > 1 and imgui.IsItemHovered() and imgui.IsMouseReleased(imgui.MouseButton.Right) then
                    filter_origin = mat.origin
                end

                imgui.TableNextColumn()
                local mat_container = mat_container_choice(mat)
                if imgui.SmallButton(mat_container) then
                    local player = player_util.get_player()
                    if player then
                        local x, y = EntityGetTransform(player)
                        local container
                        if mat_container == "Pouch" then
                            container = make_empty_stash(x, y)
                        else
                            container = EntityLoad("data/entities/items/pickup/potion_empty.xml", x, y)
                        end
                        AddMaterialInventoryMaterial(container, mat.name, container_matinv_size(container))
                    end
                end

                imgui.PopID()
            end
        end

        imgui.EndTable()
    end

    imgui.EndChild()
end

local string_util = dofile_once("mods/component-explorer/utils/strings.lua")
local style = dofile_once("mods/component-explorer/style.lua")
local matutil = dofile_once("mods/component-explorer/utils/matutil.lua")
---@module 'component-explorer.ui.help'
local help = dofile_once("mods/component-explorer/ui/help.lua")

local matinv_field = {}

local NONE_MAT_SELECTED = "--Material to add--"

local _component_state = {}
function component_state(component_id)
    if _component_state[component_id] == nil then
        _component_state[component_id] = {
            selected_material = NONE_MAT_SELECTED,
            selected_count = 0,
            add_mat_search = "",
            search = "",
        }
    end

    return _component_state[component_id]
end

local function add_material_input(entity_id, component_id, value)
    local c = component_state(component_id)
    imgui.SetNextItemWidth(200)
    if imgui.BeginCombo("##material_to_add", c.selected_material) then

        local _
        _, c.add_mat_search = imgui.InputTextWithHint("##add_mat_filter", "Filter list", c.add_mat_search)
        imgui.SameLine()
        if imgui.Button("X") then
            c.add_mat_search = ""
        end

        for i, mat in ipairs(matutil.get_all_material_names()) do
            if value[i] == 0 and string_util.ifind(mat, c.add_mat_search, 1, true) then
                if imgui.Selectable(mat, mat == c.selected_material) then
                    c.selected_material = mat
                end
            end
        end
        imgui.EndCombo()
    end

    imgui.SameLine()
    imgui.SetNextItemWidth(180)
    local _
    _, c.selected_count = imgui.InputInt("##add_mat_count", c.selected_count)

    local valid = c.selected_count ~= 0 and c.selected_material ~= NONE_MAT_SELECTED

    if not valid then imgui.BeginDisabled() end

    imgui.SameLine()
    if imgui.Button("Add##add_material_button") then
        AddMaterialInventoryMaterial(entity_id, c.selected_material, c.selected_count)
        c.selected_material = NONE_MAT_SELECTED
        c.selected_count = 0
    end

    if not valid then imgui.EndDisabled() end
end

function matinv_field.show_field_MATERIAL_VEC_DOUBLES(name, description, entity_id, component_id)
    imgui.Text(name)
    if description then
        imgui.SameLine()
        help.marker(description)
    end

    local can_edit = (
        component_id ==
        EntityGetFirstComponentIncludingDisabled(entity_id, "MaterialInventoryComponent")
    )

    if not can_edit then
        imgui.PushStyleColor(imgui.Col.Text, unpack(style.colour_fail))
        imgui.TextWrapped(
            "Unfortunately, due to Noita API limitations, for every entity " ..
            "we can only change the contents of one material inventory. This " ..
            "one can not be changed.")
        imgui.PopStyleColor()
    end

    ---@type number[]
    local value = (get or ComponentGetValue2)(component_id, name)

    if can_edit then
        add_material_input(entity_id, component_id, value)
    end

    local c = component_state(component_id)

    local _
    _, c.search = imgui.InputTextWithHint("##mat_list_search", "Search inventory", c.search)

    for material_id_, count in ipairs(value) do
        if count ~= 0 then
            local material_id = material_id_ - 1
            local material_name = matutil.material_name(material_id)
            if string_util.ifind(material_name, c.search, 1, true) then
                if can_edit then
                    imgui.SetNextItemWidth(180)
                    -- Noita's AddMaterialInventoryMaterial function only
                    -- accepts integers, but the component field can store
                    -- doubles. Detect this case and inform the user.
                    local whole_count = math.floor(count)
                    local changed, new_count = imgui.InputInt(material_name, whole_count)

                    if changed then
                        AddMaterialInventoryMaterial(entity_id, material_name, new_count)
                    end

                    if whole_count ~= count then
                        imgui.SameLine()
                        imgui.Text(tostring(count))
                        imgui.SameLine()
                        help.marker(
                            "There's a fractional amount of material in the inventory, " ..
                            "but the Lua API can only write whole numbers.")
                    end
                else
                    imgui.Text(material_name .. ": " .. count)
                end
            end
        end
    end
end

return matinv_field

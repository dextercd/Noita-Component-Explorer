local string_util = dofile_once("mods/component-explorer/utils/strings.lua")
dofile_once("mods/component-explorer/entity.lua")

local entity_list = {}

entity_list.open = setting_get("window_open_entity_list")

local entity_search = ""
local include_child_entities = false

local sort_by_idx = 1
local sort_asc = true

local function handle_sort_spec()
    if not imgui.TableGetSortSpecs then return end
    local dirty, sortspec = imgui.TableGetSortSpecs()
    if dirty and sortspec then
        local columnspec = sortspec.Specs[1]
        sort_by_idx = columnspec.ColumnIndex + 1
        sort_asc = columnspec.SortDirection == imgui.SortDirection.Ascending
    end
end

local function get_entities_data()
    local entity_ids = EntityGetInRadius(0, 0, math.huge)
    local ret = {}
    for _, entity_id in ipairs(entity_ids) do

        local name = EntityGetName(entity_id)

        table.insert(ret, {
            entity_id,
            name,
            EntityGetTags(entity_id),
            EntityGetFilename(entity_id)
        })
    end

    local sort_fn = function(left, right)
        local a, b = left[sort_by_idx], right[sort_by_idx]
        if not sort_asc then
            a, b = b, a
        end

        if a == "" then a = nil end
        if b == "" then b = nil end

        if a == nil and b == nil then return false end
        if b == nil then return false end
        if a == nil then return true end

        return a < b
    end

    table.sort(ret, sort_fn)
    return ret
end

function entity_list.show()
    local should_show
    should_show, entity_list.open = imgui.Begin("Entities list", entity_list.open)

    if not should_show then
        return
    end

    local entities_data = get_entities_data()

    _, entity_search = imgui.InputText("Search", entity_search)
    _, include_child_entities = imgui.Checkbox("Include child entities", include_child_entities)

    local table_flags = imgui.TableFlags.Resizable
    if imgui.TableGetSortSpecs then
        table_flags = bit.bor(table_flags, imgui.TableFlags.Sortable)
    end

    if imgui.BeginTable("entity_table", 5, table_flags) then
        imgui.TableSetupColumn("ID", imgui.TableColumnFlags.WidthFixed)
        imgui.TableSetupColumn("Name", imgui.TableColumnFlags.WidthFixed)
        imgui.TableSetupColumn("Tags", imgui.TableColumnFlags.WidthStretch, 6)
        imgui.TableSetupColumn("File", imgui.TableColumnFlags.WidthStretch, 12)
        imgui.TableSetupColumn("Open", bit.bor(imgui.TableColumnFlags.WidthFixed, imgui.TableColumnFlags.NoSort))
        imgui.TableHeadersRow()

        handle_sort_spec()

        for _, entity_data in ipairs(entities_data) do
            local entity = entity_data[1]

            local name = entity_data[2]
            local tags = entity_data[3]
            local file = entity_data[4]

            if (string_util.ifind(name, entity_search, 1, true) or
                string_util.ifind(tags, entity_search, 1, true) or
                string_util.ifind(file, entity_search, 1, true)) and
               (include_child_entities or EntityGetParent(entity) == 0)
            then
                if name == "" then name = "<empty string>" end
                if tags == "" then tags = "<no tags>" end
                if file == "" then file = "<empty string>" end

                imgui.TableNextColumn()
                imgui.Text(tostring(entity))
                imgui.TableNextColumn()
                imgui.Text(name)
                imgui.TableNextColumn()
                imgui.Text(tags)
                imgui.TableNextColumn()
                imgui.Text(file)
                imgui.TableNextColumn()
                open_entity_small_button(entity)
            end
        end

        imgui.EndTable()
    end

    imgui.End()
end

return entity_list

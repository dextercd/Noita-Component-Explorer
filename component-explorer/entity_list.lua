local string_util = dofile_once("mods/component-explorer/utils/strings.lua")
dofile_once("mods/component-explorer/entity.lua")

---@module 'component-explorer.style'
local style = dofile_once("mods/component-explorer/style.lua")

---@module 'component-explorer.utils.ce_settings'
local ce_settings = dofile_once("mods/component-explorer/utils/ce_settings.lua")

local entity_list = {}

entity_list.open = ce_settings.get("window_open_entity_list")

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

local get_entity_ids

if EntitiesGetMaxID ~= nil then
    local last_entity_id_checked = nil

    local current_entities = {}

    get_entity_ids = function()
        local min_id
        if last_entity_id_checked == nil then
            -- First time this is called

            min_id = GameGetWorldStateEntity()

            -- Other entities could have been created before the WorldState.
            -- That's buggy but CE must account for that.
            local check_min_id = min_id - 1
            while check_min_id > 1 and check_min_id > min_id - 100 do
                if EntityGetIsAlive(check_min_id) then
                    min_id = check_min_id
                end
                check_min_id = check_min_id - 1
            end
        else
            min_id = last_entity_id_checked + 1
        end

        local max_id = EntitiesGetMaxID()

        for e=min_id,max_id do
            current_entities[e] = true
        end

        last_entity_id_checked = max_id

        -- Clear out entities that no longer exist and build return table
        local gone = {}
        local ret = {}
        for e, _ in pairs(current_entities) do
            if EntityGetIsAlive(e) then
                ret[#ret+1] = e
            else
                gone[#gone+1] = e
            end
        end

        for _, e in ipairs(gone) do
            current_entities[e] = nil
        end

        return ret
    end
else
    get_entity_ids = function()
        return EntityGetInRadius(0, 0, math.huge)
    end
end


local function get_entities_data()
    local entity_ids = get_entity_ids()
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

---@class ExtraColumn
---@field name string
---@field func fun(entity_id: integer): any

---@type ExtraColumn[]
entity_list.extra_columns = {}

function entity_list.show()
    local should_show
    should_show, entity_list.open = imgui.Begin("Entities list", entity_list.open)

    if not should_show then
        return
    end

    local entities_data = get_entities_data()

    _, entity_search = imgui.InputText("Search", entity_search)
    _, include_child_entities = imgui.Checkbox("Include child entities", include_child_entities)

    local table_flags = bit.bor(imgui.TableFlags.Resizable, imgui.TableFlags.Hideable, imgui.TableFlags.RowBg)

    if imgui.TableGetSortSpecs then
        table_flags = bit.bor(table_flags, imgui.TableFlags.Sortable)
    end

    if imgui.BeginTable("entity_table", 5 + #entity_list.extra_columns, table_flags) then
        imgui.TableSetupColumn("ID", imgui.TableColumnFlags.WidthFixed)
        imgui.TableSetupColumn("Name", imgui.TableColumnFlags.WidthFixed)
        imgui.TableSetupColumn("Tags", imgui.TableColumnFlags.WidthStretch, 6)
        imgui.TableSetupColumn("File", imgui.TableColumnFlags.WidthStretch, 12)

        for _, extra_column in ipairs(entity_list.extra_columns) do
            local flags =  bit.bor(imgui.TableColumnFlags.WidthFixed, imgui.TableColumnFlags.NoSort)
            imgui.TableSetupColumn(extra_column.name, flags, 12)
        end

        imgui.TableSetupColumn("Actions", bit.bor(imgui.TableColumnFlags.WidthFixed, imgui.TableColumnFlags.NoSort))
        imgui.TableHeadersRow()

        handle_sort_spec()

        for _, entity_data in ipairs(entities_data) do
            local entity_id = entity_data[1]

            local name = entity_data[2]
            local tags = entity_data[3]
            local file = entity_data[4]

            if (string_util.ifind(name, entity_search, 1, true) or
                string_util.ifind(tags, entity_search, 1, true) or
                string_util.ifind(file, entity_search, 1, true)) and
               (include_child_entities or EntityGetParent(entity_id) == 0)
            then
                imgui.PushID(entity_id)

                if name == "" then name = "<empty string>" end
                if tags == "" then tags = "<no tags>" end
                if file == "" then file = "<empty string>" end

                imgui.TableNextColumn()
                imgui.Text(tostring(entity_id))
                imgui.TableNextColumn()
                imgui.Text(name)
                imgui.TableNextColumn()
                imgui.Text(tags)
                imgui.TableNextColumn()
                imgui.Text(file)

                for _, extra_column in ipairs(entity_list.extra_columns) do
                    imgui.TableNextColumn()
                    local succ, ret = pcall(extra_column.func, entity_id)

                    if not succ then
                        imgui.PushStyleColor(imgui.Col.Text, unpack(style.colour_fail))
                        imgui.Text(ret)
                        imgui.PopStyleColor()
                    elseif ret then
                        -- extra_column.func can use imgui internally, but returning
                        -- a value is also OK.
                        imgui.Text(tostring(ret))
                    end
                end

                imgui.TableNextColumn()
                open_entity_small_button(entity_id)
                imgui.SameLine()
                local kill_entity = style.danger_small_button("Kill")

                -- Highlight entities at weird locations
                local x, y = EntityGetTransform(entity_id)
                if x ~= x or y ~= y then
                    imgui.TableSetBgColor(imgui.TableBgTarget.RowBg1, 0, 0, 0.455, 1)
                elseif x == 1/0 or y == 1/0 or x == -1/0 or y == -1/0 then
                    imgui.TableSetBgColor(imgui.TableBgTarget.RowBg1, 0.455, 0, 0, 1)
                end

                imgui.PopID()

                if kill_entity then
                    EntityKill(entity_id)
                end
            end
        end

        imgui.EndTable()
    end

    imgui.End()
end

return entity_list

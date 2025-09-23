local string_util = dofile_once("mods/component-explorer/utils/strings.lua")
dofile_once("mods/component-explorer/entity.lua")

---@module 'component-explorer.style'
local style = dofile_once("mods/component-explorer/style.lua")

---@module 'component-explorer.utils.ce_settings'
local ce_settings = dofile_once("mods/component-explorer/utils/ce_settings.lua")

---@module 'component-explorer.entity'
local ce_entity = dofile_once("mods/component-explorer/entity.lua")

local entity_list = {}

entity_list.open = ce_settings.get("window_open_entity_list")

local entity_search = ""
local include_child_entities = false

local sort_by_idx = 1
local sort_asc = true

local COL_IDX_ID = 0
local COL_IDX_NAME = 1
local COL_IDX_TAG = 2
local COL_IDX_FILE = 3

local function handle_sort_spec()
    if not imgui.TableGetSortSpecs then return end
    local dirty, sortspec = imgui.TableGetSortSpecs()
    if dirty and sortspec then
        local columnspec = sortspec.Specs[1]
        sort_by_idx = columnspec.ColumnIndex
        sort_asc = columnspec.SortDirection == imgui.SortDirection.Ascending
    end
end

local last_entity_id_checked = nil

local current_entities = {}

local function get_entity_ids()
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

    -- Calling EntityGetIsAlive for thousands of entities is really slow, so
    -- check if they're in this set first.
    local non_nan_entities_list = EntityGetInRadius(0, 0, math.huge)
    local non_nan_entities_set = {}
    for _, eid in ipairs(non_nan_entities_list) do
        non_nan_entities_set[eid] = true
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
        if non_nan_entities_set[e] or EntityGetIsAlive(e) then
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

local function get_entity_names(ids)
    local EntityGetName = EntityGetName
    local result = {}
    for i=1, #ids do
        result[i] = EntityGetName(ids[i])
    end
    return result
end

local function get_entity_tags(ids)
    local EntityGetTags = EntityGetTags
    local result = {}
    for i=1, #ids do
        result[i] = EntityGetTags(ids[i])
    end
    return result
end

local function get_entity_files(ids)
    local EntityGetFilename = EntityGetFilename
    local result = {}
    for i=1, #ids do
        result[i] = EntityGetFilename(ids[i])
    end
    return result
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

    local entity_ids = get_entity_ids()

    local _entity_names = nil
    local _entity_tags = nil
    local _entity_files = nil

    local function entity_names()
        _entity_names = _entity_names or get_entity_names(entity_ids)
        return _entity_names
    end

    local function entity_tags()
        _entity_tags = _entity_tags or get_entity_tags(entity_ids)
        return _entity_tags
    end

    local function entity_files()
        _entity_files = _entity_files or get_entity_files(entity_ids)
        return _entity_files
    end

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

        if not include_child_entities then
            local filtered_ids = {}
            local next_idx = 1
            for _, entity_id in ipairs(entity_ids) do
                if EntityGetParent(entity_id) == 0 then
                    filtered_ids[next_idx] = entity_id
                    next_idx = next_idx + 1
                end
            end

            entity_ids = filtered_ids
        end

        if entity_search ~= "" then
            local names = entity_names()
            local tags = entity_tags()
            local files = entity_files()

            local filtered_ids = {}
            local next_idx = 1

            for idx, entity_id in ipairs(entity_ids) do
                if (string_util.ifind(names[idx], entity_search, 1, true) or
                    string_util.ifind(tags[idx], entity_search, 1, true) or
                    string_util.ifind(files[idx], entity_search, 1, true))
                then
                    filtered_ids[next_idx] = entity_id
                    next_idx = next_idx + 1
                end
            end

            entity_ids = filtered_ids
            _entity_names = nil
            _entity_tags = nil
            _entity_files = nil
        end

        local sort_col = (sort_by_idx == COL_IDX_ID and entity_ids)
                      or (sort_by_idx == COL_IDX_NAME and entity_names())
                      or (sort_by_idx == COL_IDX_TAG and entity_tags())
                      or (--[[sort_by_idx == COL_IDX_FILE and]] entity_files())

        local sort_mux = {}
        for idx, value in ipairs(sort_col) do
            sort_mux[idx] = {idx, value}
        end

        local sort_fn = function(left, right)
            local a, b = left[2], right[2]
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

        table.sort(sort_mux, sort_fn)

        local clipper = imgui.ListClipper.new()
        clipper:Begin(#sort_mux)

        while clipper:Step() do for mux_id_minus_one=clipper.DisplayStart,clipper.DisplayEnd-1 do
            local idx = sort_mux[mux_id_minus_one + 1][1]

            local entity_id = entity_ids[idx]
            local name = (_entity_names and _entity_names[idx]) or EntityGetName(entity_id)
            local tags = (_entity_tags and _entity_tags[idx]) or EntityGetTags(entity_id)
            local file = (_entity_files and _entity_files[idx]) or EntityGetFilename(entity_id)

            imgui.PushID(entity_id)

            if name == "" then name = "<empty name string>" end
            if tags == "" then tags = "<no tags>" end
            if file == "" then file = "<empty file string>" end

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
            ce_entity.open_entity_small_button(entity_id)
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
        end end

        imgui.EndTable()
    end

    imgui.End()
end

return entity_list

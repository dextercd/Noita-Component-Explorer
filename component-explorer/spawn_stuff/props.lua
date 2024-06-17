---@module 'component-explorer.spawn_data.props'
local props = dofile_once("mods/component-explorer/spawn_data/props.lua")

---@module 'component-explorer.utils.strings'
local string_util = dofile_once("mods/component-explorer/utils/strings.lua")

---@module 'component-explorer.cursor'
local cursor = dofile_once("mods/component-explorer/cursor.lua")

---@module 'component-explorer.ui.combo'
local combo = dofile_once("mods/component-explorer/ui/combo.lua")

---@module 'component-explorer.entity'
local entity = dofile_once("mods/component-explorer/entity.lua")

for _, prop in ipairs(props) do
    prop.material = prop.material or ""
end

local function get_unique_attrs(attr)
    local set = {}
    for _, c in ipairs(props) do
        set[c[attr]] = true
    end

    local ret = {}
    for item, _ in pairs(set) do
        table.insert(ret, item)
    end

    table.sort(ret)
    return ret
end

local unique_origins = get_unique_attrs("origin")

local filter_search = ""
---@type string?
local filter_origin = nil

return function()
    local _

    imgui.SetNextItemWidth(200)
    _, filter_search = imgui.InputText("Search", filter_search)

    if #unique_origins > 1 then
        imgui.SameLine()
        imgui.SetNextItemWidth(150)
        _, filter_origin = combo.optional("Origin", unique_origins, filter_origin)
    end

    local filtered_props

    if filter_search == "" and filter_origin == nil then
        filtered_props = props
    else
        filtered_props = {}
        for _, c in ipairs(props) do
            if
                (filter_search == "" or (
                    (c.name and string_util.ifind(c.name, filter_search, 1, true)) or
                    string_util.ifind(c.tags, filter_search, 1, true) or
                    string_util.ifind(c.material, filter_search, 1, true) or
                    string_util.ifind(c.file, filter_search, 1, true)
                ))
                and (filter_origin == nil or c.origin == filter_origin)
            then
                table.insert(filtered_props, c)
            end
        end
    end

    if not imgui.BeginChild("table") then
        return
    end

    local column_count = 6

    local has_image_support = imgui.LoadImage ~= nil
    if has_image_support then
        column_count = column_count + 1
    end

    local flags = bit.bor(
        imgui.TableFlags.Resizable,
        imgui.TableFlags.Hideable,
        imgui.TableFlags.RowBg
    )
    if imgui.BeginTable("props", column_count, flags) then
        if has_image_support then
            imgui.TableSetupColumn("img",  imgui.TableColumnFlags.WidthFixed)
        end
        imgui.TableSetupColumn("Name")
        imgui.TableSetupColumn("File")
        imgui.TableSetupColumn("Material", imgui.TableColumnFlags.DefaultHide)
        imgui.TableSetupColumn("Tags", imgui.TableColumnFlags.DefaultHide)
        imgui.TableSetupColumn("Origin", bit.bor(imgui.TableColumnFlags.DefaultHide, imgui.TableColumnFlags.WidthFixed))
        imgui.TableSetupColumn("Spawn", imgui.TableColumnFlags.WidthFixed)
        imgui.TableHeadersRow()

        -- Keep all images loaded, not just the visible ones
        if has_image_support then
            local image_paths = {}
            for _, c in ipairs(props) do
                if c.image then
                    table.insert(image_paths, c.image)
                end
            end
            -- Files are placed alphabetically in the data.wak, loading them in
            -- that order is much faster.
            table.sort(image_paths)
            for _, path in ipairs(image_paths) do
                imgui.LoadImage(path)
            end
        end

        local clipper = imgui.ListClipper.new()
        clipper:Begin(#filtered_props)
        while clipper:Step() do
            for i=clipper.DisplayStart,clipper.DisplayEnd - 1 do
                local c = filtered_props[i + 1]
                imgui.PushID(c.file)

                if has_image_support then
                    imgui.TableNextColumn()
                    if c.image then
                        local img = imgui.LoadImage(c.image)
                        if img then
                            local image_height = imgui.GetTextLineHeight()
                            local image_width = image_height / img.height * img.width
                            imgui.Image(img, image_width, image_height)
                        end
                    end
                end

                imgui.TableNextColumn()
                imgui.Text(c.name)

                imgui.TableNextColumn()
                imgui.Text(c.file)

                imgui.TableNextColumn()
                imgui.Text(c.material)

                imgui.TableNextColumn()
                imgui.Text(c.tags)

                imgui.TableNextColumn()
                imgui.Text(c.origin)
                if #unique_origins > 1 and imgui.IsItemHovered() and imgui.IsMouseReleased(imgui.MouseButton.Right) then
                    filter_origin = c.origin
                end

                imgui.TableNextColumn()
                if imgui.SmallButton("Spawn") then
                    local spawned_prop = EntityLoad(c.file, cursor.pos())

                    if imgui.IsKeyDown(imgui.Key.LeftShift) then
                        entity.watch_entity(spawned_prop)
                    end
                end

                imgui.PopID()
            end
        end

        imgui.EndTable()
    end

    imgui.EndChild()
end

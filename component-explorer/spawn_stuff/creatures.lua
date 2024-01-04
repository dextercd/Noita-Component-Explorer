---@module 'component-explorer.spawn_data.creatures'
local creatures_ = dofile_once("mods/component-explorer/spawn_data/creatures.lua")

---@module 'component-explorer.utils.copy'
local copy = dofile_once("mods/component-explorer/utils/copy.lua")

---@module 'component-explorer.utils.strings'
local string_util = dofile_once("mods/component-explorer/utils/strings.lua")

---@module 'component-explorer.cursor'
local cursor = dofile_once("mods/component-explorer/cursor.lua")

---@module 'component-explorer.ui.ui_combo'
local ui_combo = dofile_once("mods/component-explorer/ui/ui_combo.lua")

---@module 'component-explorer.utils.file_util'
local file_util = dofile_once("mods/component-explorer/utils/file_util.lua")

local function get_enhanced_creatures()
    local ret = {}
    for _, c_ in ipairs(creatures_) do
        local c = copy.shallow_copy(c_)

        if not file_util.text_file_exists(c.file) then
            goto continue
        end

        -- Add display_name attribute
        if c.name then
            c.display_name = GameTextGetTranslatedOrNot(c.name)
        elseif c.statsname then
            c.display_name = c.statsname
        else
            c.display_name = string.match(c.file, "[^/]*$")
        end

        -- See if there's an animal_icon we can use if no img_path is set yet
        if imgui.LoadImage and c.img_path == nil then
            local file_name = string.match(c.file, "([^/]*)%.xml$")
            local potential_img_path = "data/ui_gfx/animal_icons/" .. file_name .. ".png"
            if imgui.LoadImage(potential_img_path) then
                c.img_path = potential_img_path
            end
        end

        table.insert(ret, c)
        ::continue::
    end

    table.sort(ret, function(a, b) return a.display_name < b.display_name end)
    return ret
end

local creatures = get_enhanced_creatures()

local function get_unique_attrs(attr)
    local set = {}
    for _, c in ipairs(creatures) do
        set[c[attr]] = true
    end

    local ret = {}
    for item, _ in pairs(set) do
        table.insert(ret, item)
    end

    table.sort(ret)
    return ret
end

local unique_herds = get_unique_attrs("herd")
local unique_origins = get_unique_attrs("origin")

local filter_search = ""
---@type string?
local filter_herd = nil
---@type string?
local filter_origin = nil

return function()
    local _

    imgui.SetNextItemWidth(200)
    _, filter_search = imgui.InputText("Search", filter_search)

    imgui.SameLine()
    imgui.SetNextItemWidth(150)
    _, filter_herd = ui_combo.optional("Herd", unique_herds, filter_herd)

    if #unique_origins > 1 then
        imgui.SameLine()
        imgui.SetNextItemWidth(150)
        _, filter_origin = ui_combo.optional("Origin", unique_origins, filter_origin)
    end

    local filtered_creatures

    if filter_search == "" and filter_herd == nil and filter_origin == nil then
        filtered_creatures = creatures
    else
        filtered_creatures = {}
        for _, c in ipairs(creatures) do
            if
                (filter_search == "" or (
                    string_util.ifind(c.display_name, filter_search, 1, true) or
                    (c.name and string_util.ifind(c.name, filter_search, 1, true)) or
                    (c.statsname and string_util.ifind(c.statsname, filter_search, 1, true)) or
                    string_util.ifind(c.tags, filter_search, 1, true) or
                    string_util.ifind(c.file, filter_search, 1, true)
                ))
                and (filter_herd == nil or c.herd == filter_herd)
                and (filter_origin == nil or c.origin == filter_origin)
            then
                table.insert(filtered_creatures, c)
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
    if imgui.BeginTable("creatures", column_count, flags) then
        if has_image_support then
            imgui.TableSetupColumn("img",  imgui.TableColumnFlags.WidthFixed)
        end
        imgui.TableSetupColumn("Name")
        imgui.TableSetupColumn("File")
        imgui.TableSetupColumn("Tags", imgui.TableColumnFlags.DefaultHide)
        imgui.TableSetupColumn("Herd", imgui.TableColumnFlags.WidthFixed)
        imgui.TableSetupColumn("Origin", bit.bor(imgui.TableColumnFlags.DefaultHide, imgui.TableColumnFlags.WidthFixed))
        imgui.TableSetupColumn("Spawn", imgui.TableColumnFlags.WidthFixed)
        imgui.TableHeadersRow()

        -- Keep all images loaded, not just the visible ones
        if has_image_support then
            local image_paths = {}
            for _, c in ipairs(creatures) do
                if c.img_path then
                    table.insert(image_paths, c.img_path)
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
        clipper:Begin(#filtered_creatures)
        while clipper:Step() do
            for i=clipper.DisplayStart,clipper.DisplayEnd - 1 do
                local c = filtered_creatures[i + 1]
                imgui.PushID(c.file)

                if has_image_support then
                    imgui.TableNextColumn()
                    if c.img_path then
                        local img = imgui.LoadImage(c.img_path)
                        if img then
                            local style = imgui.GetStyle()
                            local image_size = imgui.GetTextLineHeight() + style.CellPadding_y * 2
                            imgui.Image(img, image_size, image_size)
                        end
                    end
                end

                imgui.TableNextColumn()
                imgui.Text(c.display_name)

                imgui.TableNextColumn()
                imgui.Text(c.file)

                imgui.TableNextColumn()
                imgui.Text(c.tags)

                imgui.TableNextColumn()
                imgui.Text(c.herd)
                if imgui.IsItemHovered() and imgui.IsMouseReleased(imgui.MouseButton.Right) then
                    filter_herd = c.herd
                end

                imgui.TableNextColumn()
                imgui.Text(c.origin)
                if #unique_origins > 1 and imgui.IsItemHovered() and imgui.IsMouseReleased(imgui.MouseButton.Right) then
                    filter_origin = c.origin
                end

                imgui.TableNextColumn()
                if imgui.SmallButton("Spawn") then
                    EntityLoad(c.file, cursor.pos())
                end

                imgui.PopID()
            end
        end

        imgui.EndTable()
    end

    imgui.EndChild()
end

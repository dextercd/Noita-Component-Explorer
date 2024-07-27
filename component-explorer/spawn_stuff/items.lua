---@module 'component-explorer.spawn_data.items'
local items_ = dofile_once("mods/component-explorer/spawn_data/items.lua")

---@module 'component-explorer.utils.copy'
local copy = dofile_once("mods/component-explorer/utils/copy.lua")

---@module 'component-explorer.utils.strings'
local string_util = dofile_once("mods/component-explorer/utils/strings.lua")

---@module 'component-explorer.cursor'
local cursor = dofile_once("mods/component-explorer/cursor.lua")

---@module 'component-explorer.ui.combo'
local combo = dofile_once("mods/component-explorer/ui/combo.lua")

---@module 'component-explorer.utils.file_util'
local file_util = dofile_once("mods/component-explorer/utils/file_util.lua")

local function get_enhanced_items()
    local ret = {}
    for _, c_ in ipairs(items_) do
        local c = copy.shallow_copy(c_)

        if not file_util.text_file_exists(c.file) then
            goto continue
        end

        local preferred_name = c.item_name or c.ui_name
        if preferred_name then
            c.display_name = GameTextGetTranslatedOrNot(preferred_name)
        else
            c.display_name = string.match(c.file, "[^/]*$")
        end

        table.insert(ret, c)
        ::continue::
    end

    table.sort(ret, function(a, b) return a.display_name < b.display_name end)
    return ret
end

local items = get_enhanced_items()

local function get_unique_attrs(attr)
    local set = {}
    for _, c in ipairs(items) do
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

local function popup_contents(item)
    if imgui.MenuItem("Copy file path") then
        imgui.SetClipboardText(item.file)
    end

    if imgui.MenuItem("Copy name") then
        imgui.SetClipboardText(item.display_name)
    end
end

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

    local filtered_items

    if filter_search == "" and filter_origin == nil then
        filtered_items = items
    else
        filtered_items = {}
        for _, c in ipairs(items) do
            if
                (filter_search == "" or (
                    string_util.ifind(c.display_name, filter_search, 1, true) or
                    (c.ui_name and string_util.ifind(c.ui_name, filter_search, 1, true)) or
                    string_util.ifind(c.tags, filter_search, 1, true) or
                    string_util.ifind(c.file, filter_search, 1, true)
                ))
                and (filter_origin == nil or c.origin == filter_origin)
            then
                table.insert(filtered_items, c)
            end
        end
    end

    if not imgui.BeginChild("table") then
        return
    end

    local flags = bit.bor(
        imgui.TableFlags.Resizable,
        imgui.TableFlags.Hideable,
        imgui.TableFlags.RowBg
    )
    if imgui.BeginTable("items", 5, flags) then
        imgui.TableSetupColumn("Name")
        imgui.TableSetupColumn("File")
        imgui.TableSetupColumn("Tags", imgui.TableColumnFlags.DefaultHide)
        imgui.TableSetupColumn("Origin", bit.bor(imgui.TableColumnFlags.DefaultHide, imgui.TableColumnFlags.WidthFixed))
        imgui.TableSetupColumn("Spawn", imgui.TableColumnFlags.WidthFixed)
        imgui.TableHeadersRow()

        local clipper = imgui.ListClipper.new()
        clipper:Begin(#filtered_items)

        while clipper:Step() do
            for i=clipper.DisplayStart,clipper.DisplayEnd - 1 do
                local c = filtered_items[i + 1]

                imgui.PushID(c.file)

                imgui.TableNextColumn()
                imgui.Text(c.display_name)

                imgui.TableNextColumn()
                imgui.Text(c.file)

                imgui.TableNextColumn()
                imgui.Text(c.tags)

                imgui.TableNextColumn()
                imgui.Text(c.origin)
                if #unique_origins > 1 and imgui.IsItemHovered() and imgui.IsMouseReleased(imgui.MouseButton.Right) then
                    filter_origin = c.origin
                end

                imgui.TableNextColumn()
                if imgui.SmallButton("Spawn") then
                    EntityLoad(c.file, cursor.pos())
                end

                if imgui.BeginPopupContextItem() then
                    popup_contents(c)
                    imgui.EndPopup()
                end

                imgui.PopID()
            end
        end

        imgui.EndTable()
    end

    imgui.EndChild()
end

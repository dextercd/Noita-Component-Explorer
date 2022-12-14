local string_util = dofile_once("mods/component-explorer/string_util.lua")
dofile_once("mods/component-explorer/entity.lua")

local all_entities = {}
local entity_search = ""
local include_child_entities = false

function show_entity_list_window()
    local should_show
    should_show, window_open_entity_list = imgui.Begin("Entities list", window_open_entity_list)

    if not should_show then
        return
    end

    all_entities = EntityGetInRadius(0, 0, math.huge)

    _, entity_search = imgui.InputText("Search", entity_search)
    _, include_child_entities = imgui.Checkbox("Include child entities", include_child_entities)

    local table_flags = imgui.TableFlags.Resizable
    if imgui.BeginTable("entity_table", 5, table_flags) then
        local fontsz = imgui.GetFontSize()
        imgui.TableSetupColumn("ID", imgui.TableColumnFlags.WidthFixed)
        imgui.TableSetupColumn("Name", imgui.TableColumnFlags.WidthFixed)
        imgui.TableSetupColumn("Tags", imgui.TableColumnFlags.WidthStretch, 6)
        imgui.TableSetupColumn("File", imgui.TableColumnFlags.WidthStretch, 12)
        imgui.TableSetupColumn("Open", imgui.TableColumnFlags.WidthFixed)
        imgui.TableHeadersRow()

        for _, entity in ipairs(all_entities) do
            local name = EntityGetName(entity)
            if name == "unknown" then name = "" end
            local tags = EntityGetTags(entity)
            local file = EntityGetFilename(entity)

            if (string_util.ifind(name, entity_search, 1, true) or
                string_util.ifind(tags, entity_search, 1, true) or
                string_util.ifind(file, entity_search, 1, true)) and
               (include_child_entities or EntityGetParent(entity) == 0)
            then
                if name == "" then name = "<no name>" end
                if tags == "" then tags = "<no tags>" end
                if file == "" then file = "<no filename>" end

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



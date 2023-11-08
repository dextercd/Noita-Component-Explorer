---@module 'component-explorer.utils.tcsv'
local tcsv = dofile_once("mods/component-explorer/utils/tcsv.lua")

---@module 'component-explorer.file_viewer'
local file_viewer = dofile_once("mods/component-explorer/file_viewer.lua")

---@module 'component-explorer.style'
local style = dofile_once("mods/component-explorer/style.lua")

---@module 'component-explorer.utils.strings'
local string_util = dofile_once("mods/component-explorer/utils/strings.lua")

local ModTextFileGetContent = ModTextFileGetContent

local translations = {}
translations.open = false

local function csv_report_table(csv, state)
    if #csv.warnings > 0 then
        imgui.PushStyleColor(imgui.Col.Text, unpack(style.colour_warn))
        local show_warns = imgui.TreeNode("Warnings (" .. #csv.warnings .. ")###csv_warnings")
        imgui.PopStyleColor()

        if show_warns then
            for _, warning in ipairs(csv.warnings) do
                imgui.BulletText(warning)
            end
            imgui.TreePop()
        end
        imgui.Separator()
    end

    if imgui.TreeNode("Usage help") then
        imgui.TextWrapped(table.concat({
            "If you're viewing a file with many languages (i.e. common.csv)," ..
            " you'll probably want to resize this window to be really large.",
            "Right click the table to hide and unhide languages."
        }, "\n"))
        imgui.TreePop()
    end

    state.search = state.search or ""
    local _
    _, state.search = imgui.InputText("Search", state.search)

    local flags = bit.bor(
        imgui.TableFlags.Resizable,
        imgui.TableFlags.Hideable,
        imgui.TableFlags.Borders,
        imgui.TableFlags.ContextMenuInBody
    )

    if imgui.BeginTable("##direct_input_csv", #csv.langs + 1, flags) then

        -- Header row
        imgui.TableSetupColumn("Key", imgui.TableColumnFlags.NoHide)
        for _, lang in ipairs(csv.langs) do
            imgui.TableSetupColumn(lang)
        end
        imgui.TableHeadersRow()

        -- Search
        local enabled_columns = {1}
        for lang_idx=1,#csv.langs do
            local column_flags = imgui.TableGetColumnFlags(lang_idx)
            if bit.band(column_flags, imgui.TableColumnFlags.IsEnabled) ~= 0 then
                table.insert(enabled_columns, lang_idx + 1)
            end
        end

        local filtered_rows
        if state.search == "" then
            filtered_rows = csv.rows
        else
            filtered_rows = {}
            for _, row in ipairs(csv.rows) do
                for _, col in ipairs(enabled_columns) do
                    if string_util.ifind(row[col], state.search, 1, true) then
                        table.insert(filtered_rows, row)
                        goto next_row
                    end
                end

                ::next_row::
            end
        end

        -- Table body
        local clipper = imgui.ListClipper.new()
        clipper:Begin(#filtered_rows)
        while clipper:Step() do
            for i=clipper.DisplayStart,clipper.DisplayEnd - 1 do
                row = filtered_rows[i + 1]
                for _, val in ipairs(row) do
                    imgui.TableNextColumn()

                    -- Replace newlines because ListClipper only works if all
                    -- lines are the same height.
                    imgui.Text(val:gsub("\n", "\\n"))

                    if imgui.IsItemHovered() then
                        imgui.BeginTooltip()
                        imgui.Text(val)
                        imgui.EndTooltip()
                    end
                end
            end
        end

        imgui.EndTable()
    end
end

local common_csv = nil
local common_csv_state = {}

local function show_common_csv()
    local path = "data/translations/common.csv"

    imgui.Text("File viewer: " .. path)
    imgui.SameLine()
    file_viewer.small_open_button(path)

    if common_csv == nil then
        common_csv = tcsv.parse(ModTextFileGetContent(path), path, false)
    end
    csv_report_table(common_csv, common_csv_state)
end

local di_state = {}
local di_text = ""
local di_csv = nil
local di_trans_mod = false

local function show_direct_input()
    local input_changed
    input_changed, di_text = imgui.InputTextMultiline("Input", di_text, 0, imgui.GetTextLineHeight() * 6)

    local trans_mod_changed
    trans_mod_changed, di_trans_mod = imgui.Checkbox("Parse as translation mod", di_trans_mod)

    if di_csv == nil or input_changed or trans_mod_changed then
        di_csv = tcsv.parse(di_text, "direct_input.xml", di_trans_mod)
    end

    imgui.Separator()
    csv_report_table(di_csv, di_state)
end

local fi_state = {}
local fi_path = ""
local fi_csv = nil
local fi_trans_mod = false

local function show_file_input()
    local path_changed
    path_changed, fi_path = imgui.InputText("Path", fi_path)

    imgui.SameLine()
    local refresh = imgui.Button("Refresh")

    local trans_mod_changed
    trans_mod_changed, fi_trans_mod = imgui.Checkbox("Parse as translation mod", fi_trans_mod)

    local valid_path = string_util.ifind(fi_path, ".csv$")

    if not valid_path then
        fi_csv = nil
    end

    if valid_path and (path_changed or trans_mod_changed or refresh) then
        fi_csv = nil

        local content = ModTextFileGetContent(fi_path)
        if content then
            fi_csv = tcsv.parse(content, "direct_input.xml", fi_trans_mod)
        end
    end

    imgui.Separator()
    imgui.Text("File viewer: " .. fi_path)
    imgui.SameLine()
    file_viewer.small_open_button(fi_path)

    imgui.Separator()
    if fi_csv then
        csv_report_table(fi_csv, fi_state)
    end
end

function translations.show()
    local should_show
    should_show, translations.open = imgui.Begin("Translations", translations.open)

    if not should_show then
        return
    end

    if imgui.BeginTabBar("##translationtabs") then
        if imgui.BeginTabItem("common.csv") then
            if imgui.BeginChild("##common_csv") then
                show_common_csv()
                imgui.EndChild()
            end
            imgui.EndTabItem()
        end

        if imgui.BeginTabItem("File path") then
            if imgui.BeginChild("##file_path") then
                show_file_input()
                imgui.EndChild()
            end
            imgui.EndTabItem()
        end

        if imgui.BeginTabItem("Direct input") then
            if imgui.BeginChild("##direct_input") then
                show_direct_input()

                imgui.EndChild()
            end

            imgui.EndTabItem()
        end

        imgui.EndTabBar()
    end

    imgui.End()
end

return translations

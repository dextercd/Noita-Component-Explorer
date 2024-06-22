---@module 'component-explorer.utils.lua_appends'
local lua_appends = dofile_once("mods/component-explorer/utils/lua_appends.lua")

---@module 'component-explorer.style'
local style = dofile_once("mods/component-explorer/style.lua")

local ModTextFileGetContent = ModTextFileGetContent
local ModTextFileWhoSetContent = ModTextFileWhoSetContent

local file_viewer = {}

local cached_content = {}
local function get_content(path)
    if not cached_content[path] then
        cached_content[path] = ModTextFileGetContent(path) or ""
    end

    return cached_content[path]
end

local function clear_content_cache(path)
    cached_content[path] = nil
end

---@param path string
---@return boolean
local function is_supported_file_type(path)
    local l4 = path:sub(-4)
    if #l4 < 4 then return false end

    if l4 == ".lua" then return true end
    if l4 == ".xml" then return true end
    if l4 == ".txt" then return true end
    if l4 == ".csv" then return true end

    if imgui.LoadImage then
        if l4 == ".png" then return true end
        if l4 == ".bmp" then return true end
    end

    local l5 = path:sub(-5)
    if #l5 < 5 then return false end

    if l5 == ".frag" then return true end
    if l5 == ".vert" then return true end
    if l5 == ".json" then return true end

    return false
end

local function all_level_append_count(appends)
    local height = #appends
    for _, append in ipairs(appends) do
        height = height + all_level_append_count(append.appends)
    end
    return height
end

local function show_appends_tree(appends)
    for _, append in ipairs(appends) do
        if #append.appends > 0 then
            local node_open = imgui.TreeNode(append.path)

            imgui.SameLine()
            file_viewer.small_open_button(append.path)

            if node_open then
                show_appends_tree(append.appends)
                imgui.TreePop()
            end
        else
            imgui.Bullet()
            imgui.Text(append.path)
            imgui.SameLine()
            file_viewer.small_open_button(append.path)
        end
    end
end

---@param path string
function file_viewer.show_file(path)
    imgui.Text("File: " .. path)
    imgui.SameLine()
    if imgui.SmallButton("Copy path") then
        imgui.SetClipboardText(path)
    end

    local l4 = path:sub(-4)
    if l4 == ".bmp" or l4 == ".png" then
        return file_viewer.show_image_file(path)
    else
        return file_viewer.show_text_file(path)
    end
end

function file_viewer.show_text_file(path)
    local content = get_content(path)
    local who_set_content = ModTextFileWhoSetContent(path)

    imgui.SameLine()
    if imgui.SmallButton("Copy content") then
        imgui.SetClipboardText(content or "Hi :)")
    end
    imgui.Separator()

    local appends = nil
    local imstyle = imgui.GetStyle()

    local footer_inner_height, footer_height = 0, 0
    local lines = 0
    if path:sub(-4) == ".lua" then
        appends = lua_appends.get_recursive(path)
        lines = lines + 1 + all_level_append_count(appends)
    end

    if who_set_content ~= "" then
        lines = lines + 1
    end

    if lines > 0 then
        local line_height = imgui.GetTextLineHeightWithSpacing()
        footer_inner_height = math.min(lines, 5) * line_height
        footer_height = footer_inner_height + imstyle.ItemSpacing_y * 2
    end

    if imgui.BeginChild("content", 0, -footer_height, false, imgui.WindowFlags.HorizontalScrollbar) then
        if content == nil or content == "" then
            imgui.PushStyleColor(imgui.Col.Text, unpack(style.colour_warn))
            imgui.Text("ModTextFileGetContent returned nil.")
            imgui.PopStyleColor()
            imgui.Text("Please check the following:")
            imgui.Bullet() imgui.Text("The file exists")
            imgui.Bullet() imgui.Text("File path is correct")
            imgui.Text("It's also possible the file is simply empty.")
            if imgui.Button("Reload file") then
                clear_content_cache(path)
            end
        else
            imgui.Text(content)
        end
        imgui.EndChild()
    end

    if appends or who_set_content ~= "" then
        imgui.Separator()

        if imgui.BeginChild("mod_modifications", 0, footer_inner_height) then
            if who_set_content ~= "" then
                imgui.Text("ModTextFileWhoSetContent: " .. who_set_content)
            end

            if appends then
                imgui.Text("Lua Appends:")
                if #appends == 0 then
                    imgui.SameLine()
                    imgui.Text("None")
                else
                    show_appends_tree(appends)
                end
            end

            imgui.EndChild()
        end
    end
end

local hover_zoom = 4

function file_viewer.show_image_file(path)
    local img = imgui.LoadImage(path)
    if not img then
        imgui.PushStyleColor(imgui.Col.Text, unpack(style.colour_fail))
        imgui.Text("Couldn't load image")
        imgui.PopStyleColor()
        return
    end

    imgui.Text("Size: " .. img.width .. " x " .. img.height)

    imgui.SetNextItemWidth(200)
    local _
    _, hover_zoom = imgui.SliderFloat("Hover zoom", hover_zoom, 1, 10)

    local window_width = imgui.GetWindowWidth()

    local ideal_scale_factor = math.max(1, window_width / img.width)
    local scale_factor = math.floor(ideal_scale_factor)

    local pos_x, pos_y = imgui.GetCursorScreenPos()
    imgui.Image(img, img.width * scale_factor, img.height * scale_factor)

    if imgui.IsItemHovered() then
        if imgui.BeginTooltip() ~= false then
            local region_sz = 300

            -- local zoomed_sz_x = img.width / (img.width * scale_factor / region_sz) / hover_zoom
            local zoomed_sz_x = math.min(region_sz / scale_factor / hover_zoom, img.width)
            local zoomed_sz_y = math.min(zoomed_sz_x, img.height)

            local mouse_pos_x, mouse_pos_y = imgui.GetMousePos()
            local tex_x = (mouse_pos_x - pos_x) / scale_factor - zoomed_sz_x * 0.5
            local tex_y = (mouse_pos_y - pos_y) / scale_factor - zoomed_sz_y * 0.5

            if tex_x < 0 then tex_x = 0 end
            if tex_y < 0 then tex_y = 0 end
            if tex_x > img.width - zoomed_sz_x then tex_x = img.width - zoomed_sz_x end
            if tex_y > img.height - zoomed_sz_y then tex_y = img.height - zoomed_sz_y end

            imgui.Text(("Min: %.2f %.2f"):format(tex_x, tex_y))
            imgui.Text(("Max: %.2f %.2f"):format(tex_x + zoomed_sz_x, tex_y + zoomed_sz_y))

            local uv_0_x = tex_x / img.width
            local uv_1_x = (tex_x + zoomed_sz_x) / img.width
            local uv_0_y = tex_y / img.height
            local uv_1_y = (tex_y + zoomed_sz_y) / img.height

            imgui.Image(img,
                region_sz, region_sz * (zoomed_sz_y / zoomed_sz_x),
                uv_0_x, uv_0_y,
                uv_1_x, uv_1_y
            )

            imgui.EndTooltip()
        end
    end
end


---@type string?
local set_this_selected = nil
local switch_tab_immediately = true

file_viewer.open = false

local open_files_lookup = {}
local open_files = {}

function file_viewer.open_file(to_open)
    if not is_supported_file_type(to_open) then
        error("Unsupported file type")
    end
    if not open_files_lookup[to_open] then
        table.insert(open_files, to_open)
        open_files_lookup[to_open] = true
    end

    if switch_tab_immediately then
        set_this_selected = to_open
    end

    file_viewer.open = true
end

function file_viewer.close_file(to_close)
    for idx, open in ipairs(open_files) do
        if to_close == open then
            table.remove(open_files, idx)
            open_files_lookup[to_close] = nil
            return
        end
    end
end

local function open_button_ex(path, buttonfn)
    if file_viewer.open and open_files_lookup[path] then
        if buttonfn("Close") then
            file_viewer.close_file(path)
        end

        return
    end

    if not is_supported_file_type(path) then
        -- Dummy in case SameLine was called before this
        imgui.Dummy(0, 0)
        return
    end

    if buttonfn("View") then
        file_viewer.open_file(path)
    end
end

function file_viewer.open_button(path)
    imgui.PushID("fvopenbtn" .. path)
    open_button_ex(path, imgui.Button)
    imgui.PopID()
end

function file_viewer.small_open_button(path)
    imgui.PushID("fvopensmallbtn" .. path)
    open_button_ex(path, imgui.SmallButton)
    imgui.PopID()
end

local open_input = ""
local function open_file_gui()
    local submit
    submit, open_input = imgui.InputText("Path", open_input, imgui.InputTextFlags.EnterReturnsTrue)

    local valid_file = is_supported_file_type(open_input)
    if not valid_file then imgui.BeginDisabled() end

    imgui.SameLine()
    if imgui.Button("Open") then
        submit = true
    end

    if not valid_file then imgui.EndDisabled() end

    imgui.Text((valid_file or open_input == "") and "" or "File type not supported.")

    local _
    _, switch_tab_immediately = imgui.Checkbox("Switch tab when opening file", switch_tab_immediately)

    if valid_file and submit then
        file_viewer.open_file(open_input)
        open_input = ""
    end
end

function file_viewer.show()
    imgui.SetNextWindowSize(560, 720, imgui.Cond.FirstUseEver)

    local should_show
    should_show, file_viewer.open = imgui.Begin("File Viewer", file_viewer.open)

    if not should_show then
        return
    end

    local barflags = imgui.TabBarFlags.TabListPopupButton

    local to_close = nil
    if imgui.BeginTabBar("##fileviewertabs", barflags) then
        if imgui.BeginTabItem("Open...") then
            open_file_gui()
            imgui.EndTabItem()
        end

        for _, file in ipairs(open_files) do
            local flags = 0
            if file == set_this_selected then
                flags = bit.bor(flags, imgui.TabItemFlags.SetSelected)
            end
            local visible, open = imgui.BeginTabItem(file, true, flags)
            if visible then
                file_viewer.show_file(file)
                imgui.EndTabItem()
            end

            if not open then
                to_close = file
            end
        end

        imgui.EndTabBar()
    end

    set_this_selected = nil

    if to_close then
        file_viewer.close_file(to_close)
    end

    imgui.End()
end

-- For use in console
watch_file = file_viewer.open_file
unwatch_file = file_viewer.close_file

return file_viewer

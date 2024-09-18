---@module 'component-explorer.animation_viewer.anim_parser'
local anim_parser = dofile_once("mods/component-explorer/animation_viewer/anim_parser.lua")

---@module 'component-explorer.deps.nxml'
local nxml = dofile_once("mods/component-explorer/deps/nxml.lua")

local ModTextFileGetContent = ModTextFileGetContent

local anim_viewer = {}
anim_viewer.open = false

local file_path = ""
local path_content = ""

local direct_input_text = ""

---@class AnimState
---@field frame integer
---@field current_animation string
---@field time number
---@field sprite Sprite?
---@field play boolean
---@field xml_error string?
---@field sprite_errors string[]

---@return AnimState
local function make_state()
    ---@type AnimState
    local new_state = {
        frame = 0,
        current_animation = "unknown",
        time = 0,
        sprite = nil,
        play = false,
        xml_error = nil,
        sprite_errors = {},
    }
    return new_state
end

---@param state AnimState
local function state_reset(state)
    state.xml_error = nil
    state.sprite = nil
    state.sprite_errors = {}
end

local direct_input_state = make_state()
local path_state = make_state()

---Shows image from xml file
---@param sprite Sprite
---@param animation string
---@param frame integer
local function show_sprite_frame(sprite, animation, frame)
    local avail_w, avail_h = imgui.GetContentRegionAvail()
    if avail_w <= 0 or avail_h <= 0 then
        return
    end

    local rect_anim = sprite.rect_animations_by_name[animation]
    local img = imgui.LoadImage(sprite.filename)
    if img then
        local frame_column = frame % rect_anim.frames_per_row
        local frame_row = math.floor(frame / rect_anim.frames_per_row)

        local uv0_x = (rect_anim.pos_x + frame_column * rect_anim.frame_width) / img.width
        local uv0_y = (rect_anim.pos_y + frame_row * rect_anim.frame_height) / img.height

        local pixels_w = rect_anim.frame_width
        local pixels_h = rect_anim.frame_height
        if rect_anim.shrink_by_one_pixel then
            pixels_w = pixels_w - 1
            pixels_h = pixels_h - 1
        end
        local uv1_x = uv0_x + pixels_w / img.width
        local uv1_y = uv0_y + pixels_h / img.height

        local display_ratio = pixels_w / pixels_h

        local avail_ratio = avail_w / avail_h

        local disp_w, disp_h
        local x, y = imgui.GetCursorPos()
        if display_ratio < avail_ratio then
            disp_h = avail_h
            disp_w = disp_h * display_ratio
            x = x + (avail_w - disp_w) / 2
        else
            disp_w = avail_w
            disp_h = disp_w / display_ratio
            y = y + (avail_h - disp_h) / 2
        end
        imgui.SetCursorPos(x, y) -- Center

        imgui.Image(img, disp_w, disp_h, uv0_x, uv0_y, uv1_x, uv1_y)
    end
end

---@param state AnimState
---@param xml_source string
local function load_animation(state, xml_source)
    state_reset(state)

    local parse_errors = {}
    local error_reporter = function(type, msg)
        parse_errors[#parse_errors+1] = "parser warning: [" .. type .. "] " .. msg
    end

    local success, result = pcall(nxml.parse, xml_source, {error_reporter=error_reporter})
    if success then
        state.sprite, state.sprite_errors = anim_parser.parse_sprite(result)
    else
        parse_errors[#parse_errors+1] = result
    end

    if #parse_errors > 0 then
        state.xml_error = table.concat(parse_errors, "\n")
    else
        state.xml_error = nil
    end
end


function anim_viewer.show()
    local should_show
    should_show, anim_viewer.open = imgui.Begin("Animation", anim_viewer.open)
    if not should_show then
        return
    end

    ---@type AnimState
    local state

    if imgui.BeginTabBar("inputmethod") then
        if imgui.BeginTabItem("File Path") then
            state = path_state

            local changed
            imgui.SetNextItemWidth(450)
            changed, file_path = imgui.InputText("Path", file_path)
            if changed then
                state_reset(state)
                path_content = ""
                if file_path:sub(-4) == ".xml" then
                    path_content = ModTextFileGetContent(file_path) or ""
                    if path_content == "" then
                        state.xml_error = "File not found"
                    else
                        load_animation(state, path_content)
                    end

                end
            end

            if path_content ~= "" then
                imgui.SameLine()
                if imgui.Button("Edit") then
                    switch_direct_input = true
                    direct_input_text = path_content
                    direct_input_state = path_state

                    path_state = make_state()
                    file_path = ""
                end
            end

            imgui.EndTabItem()
        end

        local di_tab_flags = 0
        if switch_direct_input then
            switch_direct_input = false
            di_tab_flags = bit.bor(di_tab_flags, imgui.TabItemFlags.SetSelected)
        end
        if imgui.BeginTabItem("Direct Input", nil, di_tab_flags) then
            state = direct_input_state

            local changed
            imgui.PushItemWidth(-1)
            changed, direct_input_text = imgui.InputTextMultiline("##directinput", direct_input_text, 0, imgui.GetTextLineHeight() * 10)
            imgui.PopItemWidth()
            if changed then
                load_animation(state, direct_input_text)
            end
            imgui.EndTabItem()
        end

        imgui.EndTabBar()
    end

    local error_count = #state.sprite_errors
    if state.xml_error then
        error_count = error_count + 1
    end

    if error_count > 0 and imgui.CollapsingHeader("Errors (" .. error_count .. ")###sprite_errors") then
        if state.xml_error then
            imgui.TextWrapped(state.xml_error)
        end

        for _, sprite_error in ipairs(state.sprite_errors) do
            imgui.BulletText(sprite_error)
        end
    end

    imgui.Separator()

    if state.sprite then
        if not state.current_animation then state.current_animation = state.sprite.default_animation end
        if not state.sprite.rect_animations_by_name[state.current_animation] then
            for _, rect_anim in ipairs(state.sprite.rect_animations) do
                state.current_animation = rect_anim.name
                break
            end
        end

        imgui.SetNextItemWidth(190)
        if imgui.BeginCombo("##anim", state.current_animation) then
            for i, rect_anim in pairs(state.sprite.rect_animations) do
                if imgui.Selectable(rect_anim.name .. "##" .. i, rect_anim.name == state.current_animation) then
                    state.current_animation = rect_anim.name
                end
            end
            imgui.EndCombo()
        end

        local rect_anim = state.sprite.rect_animations_by_name[state.current_animation]

        imgui.SameLine()
        if imgui.Button(state.play and "Pause" or "Play") then
            state.play = not state.play
        end

        if state.play then
            state.time = state.time + 1/60
            while state.time > rect_anim.frame_wait do
                state.frame = (state.frame + 1) % rect_anim.frame_count
                state.time = state.time - rect_anim.frame_wait
            end
        end

        imgui.PushButtonRepeat(true)

        imgui.SameLine()
        if imgui.Button("<") then
            state.frame = state.frame - 1
        end

        local _
        imgui.SameLine()
        imgui.SetNextItemWidth(imgui.GetFontSize() * 2)
        local frame_disp = state.frame + 1
        _, frame_disp = imgui.InputInt("###cf", frame_disp, 0)
        state.frame = frame_disp-1

        imgui.SameLine()
        imgui.Text("/ " .. rect_anim.frame_count)

        imgui.SameLine()
        if imgui.Button(">") then
            state.frame = state.frame + 1
        end

        state.frame = state.frame % rect_anim.frame_count

        imgui.PopButtonRepeat()

        show_sprite_frame(state.sprite, state.current_animation, state.frame)
    end

    imgui.End()
end

return anim_viewer

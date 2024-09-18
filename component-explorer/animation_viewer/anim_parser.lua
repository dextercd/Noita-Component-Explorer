local xml_viewer = {}

---@class Sprite
---@field filename string
---@field default_animation string
---@field rect_animations RectAnimation[]
---@field rect_animations_by_name {[string]: RectAnimation}

---@class RectAnimation
---@field name string
---@field frame_count integer
---@field frame_width integer
---@field frame_height integer
---@field frames_per_row integer
---@field shrink_by_one_pixel boolean
---@field pos_x integer
---@field pos_y integer
---@field frame_wait number

---@param xml any
---@return Sprite?
---@return string[] errors
function xml_viewer.parse_sprite(xml)
    local filename = ""
    local default_animation = ""
    local rect_animations = {}
    local rect_animations_by_name = {}
    local valid = true

    local errors = {}

    if not xml.attr.filename then
        errors[#errors+1] = "Sprite is missing 'filename' field"
        valid = false
    else
        filename = xml.attr.filename
        if not ModImageDoesExist(filename) then
            errors[#errors+1] = "Image file '" .. filename .. "' is not found"
            valid = false
        end
    end

    if xml.attr.default_animation then
        default_animation = xml.attr.default_animation
    end

    for rect_xml in xml:each_of("RectAnimation") do
        local rect_anim, rect_errors = xml_viewer.parse_rect_animation(rect_xml)
        for _, rect_error in ipairs(rect_errors) do
            errors[#errors+1] = rect_error
        end

        if rect_anim then
            rect_animations[#rect_animations+1] = rect_anim
            if rect_animations_by_name[rect_anim.name] then
                errors[#errors+1] = "Multiple RectAnimation with name: " .. rect_anim.name
            end
            rect_animations_by_name[rect_anim.name] = rect_anim
        end
    end

    local has_animations = false
    for _, _ in pairs(rect_animations_by_name) do
        has_animations = true
        break
    end

    if not has_animations then
        errors[#errors+1] = "Sprite has no animations"
        valid = false
    elseif not rect_animations_by_name[default_animation] then
        errors[#errors+1] = "Sprite has no default animation: " .. default_animation
    end

    if not valid then
        return nil, errors
    end

    ---@type Sprite
    local sprite = {
        filename = filename,
        default_animation = default_animation,
        rect_animations = rect_animations,
        rect_animations_by_name = rect_animations_by_name,
    }

    return sprite, errors
end

local function read_int(xml, attr, errors)
    local value = tonumber(xml.attr[attr]) or 0
    local as_int = math.floor(value)
    if value ~= as_int then
        errors[#errors+1] = "Expected '" .. attr .. "' to be an integer but got a decimal number"
    end
    return as_int
end

local function read_bool(xml, attr, errors)
    local value = xml.attr[attr]
    if value ~= "0" and value ~= "1" then
        errors[#errors+1] = "Expected '" .. attr .. "' to be 0 or 1"
    end
    return value ~= "0"
end

---@param xml any
---@return RectAnimation?
---@return string[] errors
function xml_viewer.parse_rect_animation(xml)
    local name = "unknown"
    local frame_count = 0
    local frame_width = 0
    local frame_height = 0
    local frames_per_row = 9999
    local shrink_by_one_pixel = false
    local pos_x = 0
    local pos_y = 0
    local frame_wait = 0

    local valid = true
    local errors = {}

    if not xml.attr.name then
        errors[#errors+1] = "RectAnimation is missing 'name' field"
    else
        name = xml.attr.name
    end

    if not xml.attr.frame_count then
        errors[#errors+1] = "RectAnimation is missing 'frame_count' field"
        valid = false
    else
        frame_count = read_int(xml, "frame_count", errors)
        if frame_count <= 0 then
            errors[#errors+1] = "Bad 'frame_count' value"
            valid = false
        end
    end

    if not xml.attr.frame_width then
        errors[#errors+1] = "RectAnimation is missing 'frame_width' field"
        valid = false
    else
        frame_width = read_int(xml, "frame_width", errors)
        if frame_width < 0 then
            errors[#errors] = "Invalid 'frame_width' value: " .. xml.attr.frame_width
            valid = false
        end
    end

    if not xml.attr.frame_height then
        errors[#errors+1] = "RectAnimation is missing 'frame_height' field"
        valid = false
    else
        frame_height = read_int(xml, "frame_height", errors)
        if frame_height < 0 then
            errors[#errors] = "Invalid 'frame_height' value: " .. xml.attr.frame_height
            valid = false
        end
    end

    if xml.attr.frames_per_row then
        frames_per_row = read_int(xml, "frames_per_row", errors)
    end

    if xml.attr.shrink_by_one_pixel then
        shrink_by_one_pixel = read_bool(xml, "shrink_by_one_pixel", errors)
    end

    if xml.attr.pos_x then
        pos_x = read_int(xml, "pos_x", errors)
        if pos_x < 0 then
            errors[#errors] = "Invalid 'pos_x' value: " .. xml.attr.pos_x
            valid = false
        end
    end

    if xml.attr.pos_y then
        pos_y = read_int(xml, "pos_y", errors)
        if pos_y < 0 then
            errors[#errors] = "Invalid 'pos_y' value: " .. xml.attr.pos_y
            valid = false
        end
    end

    if not xml.attr.frame_wait then
        errors[#errors+1] = "RectAnimation is missing 'frame_wait' field"
        valid = false
    else
        frame_wait = tonumber(xml.attr.frame_wait) or 0
        if frame_wait <= 0 then
            errors[#errors+1] = "Invalid 'frame_wait' value: " .. xml.attr.frame_wait
            valid = false
        end
    end

    if not valid then
        return nil, errors
    end

    ---@type RectAnimation
    local rect_animation = {
        name = name,
        frame_count = frame_count,
        frame_width = frame_width,
        frame_height = frame_height,
        frames_per_row = frames_per_row,
        shrink_by_one_pixel = shrink_by_one_pixel,
        pos_x = pos_x,
        pos_y = pos_y,
        frame_wait = frame_wait,
    }

    return rect_animation, errors
end

return xml_viewer

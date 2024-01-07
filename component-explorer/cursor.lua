---@module 'component-explorer.help'
local help = dofile_once("mods/component-explorer/help.lua")

---@module 'component-explorer.utils.player_util'
local player_util = dofile_once("mods/component-explorer/utils/player_util.lua")

---@module 'component-explorer.utils.ce_settings'
local ce_settings = dofile_once("mods/component-explorer/utils/ce_settings.lua")

dofile_once("data/scripts/lib/utilities.lua")

local TEMPORARY_VISIBLE = 30

local cursor = {}

---@enum CURSOR_PARENT
cursor.CURSOR_PARENT = {
    camera = "camera",
    world = "world",
    player = "player",
}

---Get name of enum value
---@param parent CURSOR_PARENT
---@return string
function cursor.parent_name(parent)
    if parent == cursor.CURSOR_PARENT.world then return "World" end
    if parent == cursor.CURSOR_PARENT.camera then return "Camera" end
    if parent == cursor.CURSOR_PARENT.player then return "Player" end
    error("Bad enum value")
end

---@type CURSOR_PARENT[]
local cursor_options = {}
for _, v in pairs(cursor.CURSOR_PARENT) do
    table.insert(cursor_options, v)
end
table.sort(cursor_options,
    function(a, b) return cursor.parent_name(a) < cursor.parent_name(b) end)

cursor.current_parent = ce_settings.get("parent") --[[@as CURSOR_PARENT]]
cursor.rx, cursor.ry = 0, 0
cursor.keep_visible = ce_settings.get("keep_visible") --[[@as boolean]]
---@type integer
cursor.visible_frames = 0

---Get current position of the cursor.
---@return number X coordinate
---@return number Y coordinate
function cursor.pos()
    local px, py = cursor.parent_pos()
    return px + cursor.rx, py + cursor.ry
end

---Get coordinate of the thing the cursor is parented to.
---@return number X coordinate
---@return number Y coordinate
function cursor.parent_pos()
    if cursor.current_parent == cursor.CURSOR_PARENT.world then
        return 0, 0
    end

    if cursor.current_parent == cursor.CURSOR_PARENT.camera then
        local cx, cy, cw, ch = GameGetCameraBounds()
        return cx + cw * 0.5, cy + ch * 0.5
    end

    if cursor.current_parent == cursor.CURSOR_PARENT.player then
        local p = player_util.get_player()
        if p then
            local x, y = EntityGetTransform(p)
            return x, y
        end
    end

    return 0, 0
end

---Set absolute position of cursor
---@param x number
---@param y number
---@param make_visible boolean? Make visible for a short moment
function cursor.set_pos(x, y, make_visible)
    if make_visible then
        cursor.visible_frames = TEMPORARY_VISIBLE
    end
    local px, py = cursor.parent_pos()
    cursor.set_relative_pos(x - px, y - py)
end

---Set cursor position relative to parent
---@param rx number
---@param ry number
function cursor.set_relative_pos(rx, ry)
    cursor.rx = rx
    cursor.ry = ry
end

function cursor.set_parent(new_parent)
    local cx, cy = cursor.pos()
    cursor.current_parent = new_parent

    -- Update position to be the same as before

    -- Except if it's now camera relative we force it to be on screen
    if cursor.current_parent == cursor.CURSOR_PARENT.camera then
        local cam_x, cam_y, cam_w, cam_h = GameGetCameraBounds()
        if cx < cam_x or cx > cam_x + cam_w or cy < cam_y or cy > cam_y + cam_h then
            -- Would be off screen, recenter
            cursor.set_relative_pos(0, 0)
            return
        end
    end

    cursor.set_pos(cx, cy)
end

local gui = GuiCreate()

local function world2screen(x, y)
    local virt_x = MagicNumbersGetValue("VIRTUAL_RESOLUTION_X")
    local virt_y = MagicNumbersGetValue("VIRTUAL_RESOLUTION_Y")
    local cx, cy = GameGetCameraBounds()
    local screen_width, screen_height = GuiGetScreenDimensions(gui)

    -- Bunch of weird constants in here but it seems to improve the accuracy of
    -- the conversion.
    return
        (x - cx - 2.8) / (virt_x - 0) * screen_width,
        (y - cy - 0.5) / (virt_y * 0.99) * screen_height
end

function cursor.update()
    GuiStartFrame(gui)

    local show = false
    local alpha = 1

    if cursor.config_open or cursor.keep_visible then
        show = true
    elseif cursor.visible_frames > 0 then
        show = true
        alpha = cursor.visible_frames / TEMPORARY_VISIBLE
    end

    if show then
        if cursor.visible_frames > 0 then
            cursor.visible_frames = cursor.visible_frames - 1
        end

        local w, h = GuiGetImageDimensions(gui, "mods/component-explorer/ui/cursor.png")
        local x, y = world2screen(cursor.pos())
        GuiOptionsAddForNextWidget(gui, GUI_OPTION.NonInteractive)
        GuiImage(gui, 1, x - w * 0.5, y - h * 0.5, "mods/component-explorer/ui/cursor.png", alpha, 1, 1)
    end

end

local function config_content()
    local _
    _, cursor.keep_visible = imgui.Checkbox("Keep visible", cursor.keep_visible)

    imgui.SameLine()
    help.marker("Keep the cursor visible even after closing the config window.")

    if cursor.current_parent ~= cursor.CURSOR_PARENT.world then imgui.BeginDisabled() end

    local cx, cy = cursor.pos()
    local poschange
    poschange, cx, cy = imgui.InputFloat2("Position", cx, cy)
    if poschange then
        cursor.set_pos(cx, cy)
    end

    if cursor.current_parent ~= cursor.CURSOR_PARENT.world then imgui.EndDisabled() end

    if imgui.BeginCombo("Parent", cursor.parent_name(cursor.current_parent)) then
        for _, cp in ipairs(cursor_options) do
            if imgui.Selectable(cursor.parent_name(cp), cursor.current_parent == cp) then
                cursor.set_parent(cp)
            end
        end
        imgui.EndCombo()
    end

    if cursor.current_parent ~= cursor.CURSOR_PARENT.world then
        imgui.SetNextItemWidth(250)
        local relchange, rx, ry = imgui.InputFloat2("Offset", cursor.rx, cursor.ry)
        if relchange then
            cursor.set_relative_pos(rx, ry)
        end

        imgui.SameLine()
        if imgui.Button("Zero") then
            cursor.set_relative_pos(0, 0)
        end
    end
end

local function about_content()
    local example = "local x, y = cursor.pos()"
    imgui.TextWrapped(table.concat({
        "Component Explorer defines its own cursor that you can place in the world. ",
        "CE uses this in some places when it needs a location, for instance, when spawning in enemies/items.\n\n",
        "You can use the cursors yourself from the Lua console and user scripts.\n",
        "Do `" .. example .. "` to get the position of the cursor in the world and use it in the console! :)\n\n",
    }))

    imgui.BeginDisabled()
    imgui.InputText("##ex", example)
    imgui.EndDisabled()
    imgui.SameLine()
    if imgui.Button("Copy") then
        imgui.SetClipboardText(example)
    end

    imgui.Dummy(0, 20)
    imgui.TextWrapped(table.concat({
        "You can use this window to configure the cursor. ",
        "To change the default values, go into the mod settings.\n\n",
        "Use CTRL+SHIFT+Click to position the cursor, this works best when using ImGui version 1.15.1 or above."
    }))
end

cursor.config_open = false

function cursor.config_show()
    imgui.SetNextWindowSize(480, 200, imgui.Cond.FirstUseEver)
    local show
    show, cursor.config_open = imgui.Begin("Cursor Config", cursor.config_open)

    if not show then
        return
    end

    if imgui.BeginTabBar("##cursor_config") then
        if imgui.BeginTabItem("Config") then
            config_content()
            imgui.EndTabItem()
        end
        if imgui.BeginTabItem("About") then
            about_content()
            imgui.EndTabItem()
        end
        imgui.EndTabBar()
    end

    imgui.End()
end

return cursor

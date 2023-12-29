-- Loading imgui early so it's available when other files are loaded
imgui = load_imgui({version="1.7.0", mod="Component Explorer"})

---@module 'component-explorer.utils.ce_settings'
local ce_settings = dofile_once("mods/component-explorer/utils/ce_settings.lua")
dofile_once("mods/component-explorer/lua_console.lua")
---@module 'component-explorer.globals'
local globals = dofile_once("mods/component-explorer/globals.lua")

dofile_once("mods/component-explorer/components.lua")

---@module 'component-explorer.entity_list'
local entity_list = dofile_once("mods/component-explorer/entity_list.lua")

dofile_once("mods/component-explorer/entity.lua")
local version = dofile_once("mods/component-explorer/version.lua")

---@module 'component-explorer.entity_picker'
local entity_picker = dofile_once("mods/component-explorer/entity_picker.lua")

---@module 'component-explorer.wiki_wands'
local wiki_wands = dofile_once("mods/component-explorer/wiki_wands.lua")

---@module 'component-explorer.link_ui'
local link_ui = dofile_once("mods/component-explorer/link_ui.lua")

---@module 'component-explorer.user_scripts'
local us = dofile_once("mods/component-explorer/user_scripts.lua")

---@module 'component-explorer.file_viewer'
local file_viewer = dofile_once("mods/component-explorer/file_viewer.lua")

---@module 'component-explorer.mod_settings'
local mod_settings = dofile_once("mods/component-explorer/mod_settings.lua")

---@module 'component-explorer.help'
local help = dofile_once("mods/component-explorer/help.lua")

---@module 'component-explorer.translations'
local translations = dofile_once("mods/component-explorer/translations.lua")

---@module 'component-explorer.run_flags'
local run_flags = dofile_once("mods/component-explorer/run_flags.lua")

---@module 'component-explorer.herd_relation'
local herd_relation = dofile_once("mods/component-explorer/herd_relation.lua")

local last_frame_run = -1

local is_escape_paused = false
local is_inventory_paused = false

function OnPausedChanged(paused, inventory_pause)
    ce_settings.load()  -- Settings might've changed, reload

    is_escape_paused = paused and not inventory_pause
    is_inventory_paused = inventory_pause

    if not paused then update_ui(true, GameGetFrameNum()) end
end

function OnWorldPreUpdate()
    local current_frame_run = GameGetFrameNum()
    if last_frame_run >= current_frame_run then
        return
    end
    last_frame_run = current_frame_run

    update_ui(false, current_frame_run)
end

function OnPausePreUpdate()
    if is_escape_paused and not ce_settings.get("pause_escape") or
       is_inventory_paused and not ce_settings.get("pause_wands")
    then
        return
    end

    local current_frame_run = GameGetFrameNum()
    last_frame_run = current_frame_run
    update_ui(true, current_frame_run)
end

console = new_console()

local window_open_about = false
local windows_hidden_component = false
local windows_hidden_entity = false

function OnMagicNumbersAndWorldSeedInitialized()
    local function run_us_ifexists(script)
        if us.exists(script) then
            console_run_command(console, us.user_script_call_string(script))
        end
    end

    run_us_ifexists("init.lua")
    run_us_ifexists("_init.lua")
end

function sct(shortcut_text)
    return ce_settings.get("keyboard_shortcuts") and shortcut_text or ""
end

function show_view_menu_items()
    local _
    _, console.open = imgui.MenuItem("Lua Console", sct("CTRL+SHIFT+L"), console.open)
    _, entity_list.open   = imgui.MenuItem("Entity List", sct("CTRL+SHIFT+K"), entity_list.open)
    _, herd_relation.open   = imgui.MenuItem("Herd Relation", "", herd_relation.open)
    _, wiki_wands.open    = imgui.MenuItem("Wiki Wands", "", wiki_wands.open)
    _, file_viewer.open   = imgui.MenuItem("File Viewer", sct("CTRL+SHIFT+F"), file_viewer.open)
    _, translations.open  = imgui.MenuItem("Translations", "", translations.open)

    local clicked
    clicked, entity_picker.open = imgui.MenuItem("Entity Picker...", sct("CTRL+SHIFT+E"), entity_picker.open)
    if clicked then
        imgui.SetWindowFocus(nil)
    end

    if imgui.IsItemHovered() then
        help.tooltip(table.concat({
            "Allows you to move your mouse over an entity to open a window for it. ",
            "Press the entry number to select the entity. ESC to cancel the action.\n\n",
            "When keyboard shortcuts are enabled, you can hit CTRL+SHIFT+E to open or close the picker.",
        }))
    end

    _, globals.open  = imgui.MenuItem("Globals", "", globals.open)
    _, run_flags.open  = imgui.MenuItem("Run Flags", "", run_flags.open)
    _, mod_settings.open  = imgui.MenuItem("Mod Settings", "", mod_settings.open)

    imgui.Separator()
    _, windows_hidden_entity     = imgui.MenuItem("Hide entity windows", "", windows_hidden_entity)
    _, windows_hidden_component  = imgui.MenuItem("Hide component windows", "", windows_hidden_component)
end

-- Can't know the width before creating the window.. Just an initial value, it's updated
-- to the real value once we can call imgui.GetWindowWidth()
local main_window_width = 100

function main_window_position()
    local menubar_height = imgui.GetFontSize() + 2 * imgui.GetStyle().FramePadding_y

    -- Available space
    local aw, ah = imgui.GetMainViewportSize()
    aw = aw - main_window_width
    ah = ah - menubar_height + 3  -- Bit extra to get rid of the bottom deadzone of the window

    local rx, ry

    local side = ce_settings.get("main_window_side")

    if     side == "top"    then ry = 0
    elseif side == "bottom" then ry = 1
    elseif side == "left"   then rx = 0
    elseif side == "right"  then rx = 1 end

    local roffset = ce_settings.get("main_window_side_offset") / 100

    if     rx == nil then rx = roffset
    elseif ry == nil then ry = roffset end

    local vx, vy = imgui.GetMainViewportWorkPos()
    return vx + aw * rx, vy + ah * ry
end

function main_window()
    local window_flags = bit.bor(
        imgui.WindowFlags.MenuBar,
        imgui.WindowFlags.NoDocking,
        imgui.WindowFlags.NoSavedSettings,
        imgui.WindowFlags.NoFocusOnAppearing,
        imgui.WindowFlags.NoMove,
        imgui.WindowFlags.NoDecoration,
        imgui.WindowFlags.NoBackground
    )

    imgui.SetNextWindowViewport(imgui.GetMainViewportID())
    imgui.SetNextWindowPos(main_window_position())
    imgui.SetNextWindowSize(0, 0)

    if imgui.Begin("Main Menu", nil, window_flags) then
        -- Save actual window width for next positioning
        main_window_width = imgui.GetWindowWidth()

        if imgui.BeginMenuBar() then
            if imgui.BeginMenu("CE") then
                local _
                _, window_open_about = imgui.MenuItem("About", "", window_open_about)

                local docs_description = "Copies web link"
                if link_ui.open_link then
                    docs_description = "Opens noita.wiki.gg"
                end
                link_ui.menu_item("Docs", docs_description, version.wiki)

                imgui.EndMenu()
            end

            if imgui.BeginMenu("View") then
                show_view_menu_items()
                imgui.EndMenu()
            end

            imgui.EndMenuBar()
        end

        imgui.End()
    end
end

function show_about_window()
    local should_show
    should_show, window_open_about = imgui.Begin("About", window_open_about)
    if should_show then
        imgui.Text("Component explorer version " .. version.version)
        imgui.Text("Made by dextercd")
        link_ui.button("Homepage", version.homepage)

        local wx, wy = imgui.GetWindowSize()
        if imgui.LoadImage and wy > 300 then
            local img = imgui.LoadImage("mods/component-explorer/ui/james.png")
            if img then
                imgui.Image(img, img.width, img.height)
            end
        end

        imgui.End()
    end
end

local function keyboard_shortcuts()
    if not ce_settings.get("keyboard_shortcuts") then return end
    if not imgui.IsKeyDown(imgui.Key.LeftCtrl) then return end
    if not imgui.IsKeyDown(imgui.Key.LeftShift) then return end

    keyboard_shortcut_items()
end

function update_ui(paused, current_frame_run)
    keyboard_shortcuts()

    main_window()

    if window_open_about then
        show_about_window()
    end

    if globals.open then
        globals.show()
    end

    if not windows_hidden_entity then
        show_entity_windows()
    end

    if not windows_hidden_component then
        show_component_windows()
    end

    if entity_list.open then
        entity_list.show()
    end

    if console.open then
        console_draw(console)
    end

    if entity_picker.open then
        entity_picker.show()
    end

    if wiki_wands.open then
        wiki_wands.show()
    end

    if file_viewer.open then
        file_viewer.show()
    end

    if translations.open then
        translations.show()
    end

    if run_flags.open then
        run_flags.show()
    end

    if herd_relation.open then
        herd_relation.show()
    end

    if mod_settings.open then
        mod_settings.show()
    end
end

---Handles the keyboard shortcuts.
function keyboard_shortcut_items()
    if imgui.IsKeyPressed(imgui.Key.E) then
        entity_picker.open = not entity_picker.open
    end

    if imgui.IsKeyPressed(imgui.Key.F) then
        file_viewer.open = not file_viewer.open
    end

    if imgui.IsKeyPressed(imgui.Key.W) then
        local world_entity = GameGetWorldStateEntity()
        local world_component = EntityGetFirstComponent(world_entity, "WorldStateComponent")
        toggle_watch_component(world_entity, world_component)
    end

    if imgui.IsKeyPressed(imgui.Key.P) then
        local players = EntityGetWithTag("player_unit")
        for _, player in ipairs(players) do
            toggle_watch_entity(player)
        end
    end

    if imgui.IsKeyPressed(imgui.Key.K) then
        entity_list.open = not entity_list.open
    end

    if imgui.IsKeyPressed(imgui.Key.L) then
        console.open = not console.open
    end

    if imgui.IsKeyPressed(imgui.Key.U) then
        console.user_scripts_open = not console.user_scripts_open
    end
end

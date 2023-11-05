---@module 'component-explorer.utils.ce_settings'
local ce_settings = dofile_once("mods/component-explorer/utils/ce_settings.lua")

local original_OnPausedChanged = OnPausedChanged
local original_OnWorldPreUpdate = OnWorldPreUpdate
local original_OnPausePreUpdate = OnPausePreUpdate

local last_frame_run = -1

is_escape_paused = false
is_inventory_paused = false

function OnPausedChanged(paused, inventory_pause)
    if original_OnPausedChanged then
        original_OnPausedChanged(paused, inventory_pause)
    end

    ce_settings.load()  -- Settings might've changed, reload

    is_escape_paused = paused and not inventory_pause
    is_inventory_paused = inventory_pause

    if not paused then update_ui(true, GameGetFrameNum()) end
end

function OnWorldPreUpdate()
    if original_OnWorldPreUpdate then
        original_OnWorldPreUpdate()
    end

    local current_frame_run = GameGetFrameNum()
    if last_frame_run >= current_frame_run then
        return
    end
    last_frame_run = current_frame_run

    update_ui(false, current_frame_run)
end

function OnPausePreUpdate()
    if original_OnPausePreUpdate then
        original_OnPausePreUpdate()
    end

    if is_escape_paused and not ce_settings.get("pause_escape") or
       is_inventory_paused and not ce_settings.get("pause_wands")
    then
        return
    end

    local current_frame_run = GameGetFrameNum()
    last_frame_run = current_frame_run
    update_ui(true, current_frame_run)
end

dofile_once("mods/component-explorer/memory_type.lua")
local memory_display = dofile_once("mods/component-explorer/memory_display.lua")
local string_util = dofile_once("mods/component-explorer/utils/strings.lua")

window_open_debug = false

local debug_base = 0x00ff8c90
local petri_base = 0x00ff8640
local olli_base = 0x00ff86b4

local debug_categories = {
    {
        name = "Debug",
        items = {
            {
                name = "mDrawPathFindingGrid",
                type = CE_MemoryType.bool_,
                addr = debug_base + 4,
            },
            {
                name = "DEBUG_RAGDOLL_EXTRA_FORCE",
                type = CE_MemoryType.float_,
                addr = debug_base + 8,
            },
            {
                name = "mRenderPathFinding",
                type = CE_MemoryType.bool_,
                addr = debug_base + 0xc,
            },
            {
                name = "mPauseSimulation",
                type = CE_MemoryType.bool_,
                addr = debug_base + 0xd,
            },
            {
                name = "mPauseSomeSimulation",
                type = CE_MemoryType.bool_,
                addr = debug_base + 0xe,
            },
            {
                name = "mCameraFreeIsSmoothed",
                type = CE_MemoryType.bool_,
                addr = debug_base + 0xf,
            },
            {
                name = "mCameraIsLockedInGameplay",
                type = CE_MemoryType.bool_,
                addr = debug_base + 0x10,
            },
            {
                name = "camera_light",
                type = CE_MemoryType.bool_,
                addr = debug_base + 0x11,
            },
            {
                name = "mAllowCameraMoveWhenLocked",
                type = CE_MemoryType.bool_,
                addr = debug_base + 0x12,
            },
            {
                name = "mCameraDisableCameraShake",
                type = CE_MemoryType.bool_,
                addr = debug_base + 0x13,
            },
            {
                name = "mCameraTargetOffsetY",
                type = CE_MemoryType.float_,
                addr = debug_base + 0x14,
            },
            {
                name = "mCameraTargetOffsetX",
                type = CE_MemoryType.float_,
                addr = debug_base + 0x18,
            },
            {
                name = "mPostFxDisabled",
                type = CE_MemoryType.bool_,
                addr = debug_base + 0x1c,
            },
            {
                name = "mGuiDisabled",
                type = CE_MemoryType.bool_,
                addr = debug_base + 0x1d,
            },
            {
                name = "mGuiHalfSize",
                type = CE_MemoryType.bool_,
                addr = debug_base + 0x1e,
            },
            {
                name = "mFogOfWarOpenEverywhere",
                type = CE_MemoryType.bool_,
                addr = debug_base + 0x1f,
            },
            {
                name = "mTrailerMode",
                type = CE_MemoryType.bool_,
                addr = debug_base + 0x20,
            },
            {
                name = "mDayTimeRotationPaused",
                type = CE_MemoryType.bool_,
                addr = debug_base + 0x21,
            },
            {
                name = "mPlayerNeverDies",
                type = CE_MemoryType.bool_,
                addr = debug_base + 0x22,
            },
            {
                name = "mFreezeAI",
                type = CE_MemoryType.bool_,
                addr = debug_base + 0x23,
            },
            {
                name = "mGameAudioVisualization",
                type = CE_MemoryType.bool_,
                addr = debug_base + 0x24,
            },
            {
                name = "mGameMusicDebug",
                type = CE_MemoryType.bool_,
                addr = debug_base + 0x25,
            },
            {
                name = "mGameMusicDebugFades",
                type = CE_MemoryType.bool_,
                addr = debug_base + 0x26,
            },
            {
                name = "mAudioPerformanceDebug",
                type = CE_MemoryType.bool_,
                addr = debug_base + 0x27,
            },
            {
                name = "B2_Friction",
                type = CE_MemoryType.float_,
                addr = debug_base + 0x28,
            },
            {
                name = "mRecordingCameraStartX",
                type = CE_MemoryType.float_,
                addr = debug_base + 0x2c,
            },
            {
                name = "mRecordingCameraStartY",
                type = CE_MemoryType.float_,
                addr = debug_base + 0x30,
            },
            {
                name = "GLOBAL_WE_ARE_DOING_RESET",
                type = CE_MemoryType.bool_,
                addr = debug_base + 0x34,
            },
            {
                name = "mSettingWasChanged",
                type = CE_MemoryType.bool_,
                addr = debug_base + 0x35,
            },
        },
    },
    {
        name = "Petri",
        items = {
            {
                name = "LIMIT_VELOCITY",
                type = CE_MemoryType.bool_,
                addr = petri_base + 4,
            },
            {
                name = "REGEN_WANG_MAPS",
                type = CE_MemoryType.bool_,
                addr = petri_base + 5,
            },
            {
                name = "DISABLE_GRIDWORLD_RENDERING",
                type = CE_MemoryType.bool_,
                addr = petri_base + 6,
            },
            {
                name = "SWIMMING_FORCE",
                type = CE_MemoryType.float_,
                addr = petri_base + 8,
            },
            {
                name = "test",
                addr = petri_base + 0xc,
                type = CE_MemoryType.int8_t,
            },
            {
                name = "test2",
                type = CE_MemoryType.uint8_t,
                addr = petri_base + 0xd,
            },
            {
                name = "draw_game_stats",
                type = CE_MemoryType.bool_,
                addr = petri_base + 0xe,
            },
            {
                name = "DEBUG_LOAD_ALL_ENTITIES",
                type = CE_MemoryType.bool_,
                addr = petri_base + 0xf,
            },
            {
                name = "mDrawUpdateRects",
                type = CE_MemoryType.bool_,
                addr = petri_base + 0x10,
            },
            {
                name = "mDrawBox2D",
                type = CE_MemoryType.bool_,
                addr = petri_base + 0x11,
            },
            {
                name = "mDrawBox2DAABB",
                type = CE_MemoryType.bool_,
                addr = petri_base + 0x12,
            },
            {
                name = "mDrawBox2DVelocities",
                type = CE_MemoryType.bool_,
                addr = petri_base + 0x13,
            },
            {
                name = "mDrawBox2DForces",
                type = CE_MemoryType.bool_,
                addr = petri_base + 0x14,
            },
            {
                name = "mDrawBox2DMassDensity",
                type = CE_MemoryType.bool_,
                addr = petri_base + 0x15,
            },
            {
                name = "mDrawBox2DCollisionGroups",
                type = CE_MemoryType.bool_,
                addr = petri_base + 0x16,
            },
            {
                name = "mDrawJoints",
                type = CE_MemoryType.bool_,
                addr = petri_base + 0x17,
            },
            {
                name = "mBox2DMousePick",
                type = CE_MemoryType.bool_,
                addr = petri_base + 0x18,
            },
            {
                name = "mDebugEnabled",
                type = CE_MemoryType.bool_,
                addr = petri_base + 0x19,
            },
            {
                name = "mDebugKeysEnabled",
                type = CE_MemoryType.bool_,
                addr = petri_base + 0x1a,
            },
            {
                name = "mDrawEntities",
                type = CE_MemoryType.bool_,
                addr = petri_base + 0x1b,
            },
            {
                name = "mEntityScale",
                type = CE_MemoryType.float_,
                addr = petri_base + 0x1c,
            },
            {
                name = "mEntityDrawTags",
                type = CE_MemoryType.bool_,
                addr = petri_base + 0x20,
            },
            {
                name = "mEntityDrawFilename",
                type = CE_MemoryType.bool_,
                addr = petri_base + 0x21,
            },
            {
                name = "mDrawWorldChunks",
                type = CE_MemoryType.bool_,
                addr = petri_base + 0x22,
            },
            {
                name = "mDrawWorldChunksScale",
                type = CE_MemoryType.float_,
                addr = petri_base + 0x24,
            },
            {
                name = "mDrawWorldChunksPosX",
                type = CE_MemoryType.float_,
                addr = petri_base + 0x28,
            },
            {
                name = "mDrawWorldChunksPosY",
                type = CE_MemoryType.float_,
                addr = petri_base + 0x2c,
            },
            {
                name = "mDrawBiomeHeight",
                type = CE_MemoryType.bool_,
                addr = petri_base + 0x30,
            },
            {
                name = "mDraw64x64CellCounts",
                type = CE_MemoryType.bool_,
                addr = petri_base + 0x31,
            },
            {
                name = "mDrawWangMap",
                type = CE_MemoryType.bool_,
                addr = petri_base + 0x32,
            },
            {
                name = "draw_wang_colors",
                type = CE_MemoryType.bool_,
                addr = petri_base + 0x33,
            },
            {
                name = "mWangMapScale",
                type = CE_MemoryType.float_,
                addr = petri_base + 0x34,
            },
            {
                name = "mWangMapAlpha",
                type = CE_MemoryType.float_,
                addr = petri_base + 0x38,
            },
            {
                name = "mDebugSpamRandomEntities",
                type = CE_MemoryType.bool_,
                addr = petri_base + 0x3c,
            },
            -- {
            --     name = "mRandomEntities",
            --     addr = petri_base + 0x40,
            --     type = CE_MemoryType.vector_std_string,
            -- },
            {
                name = "do_edge",
                type = CE_MemoryType.bool_,
                addr = petri_base + 0x4c,
            },
            {
                name = "physics_impulse_limit",
                type = CE_MemoryType.float_,
                addr = petri_base + 0x50,
            },
            {
                name = "physics_multiplier",
                type = CE_MemoryType.float_,
                addr = petri_base + 0x54,
            },
            {
                name = "physics_pos_x",
                type = CE_MemoryType.float_,
                addr = petri_base + 0x58,
            },
            {
                name = "physics_pos_y",
                type = CE_MemoryType.float_,
                addr = petri_base + 0x5c,
            },
            {
                name = "physics_throw_str",
                type = CE_MemoryType.float_,
                addr = petri_base + 0x60,
            },
            {
                name = "physics_damage_frames",
                type = CE_MemoryType.int_,
                addr = petri_base + 100,
            },
            {
                name = "physics_damage_coeff",
                type = CE_MemoryType.float_,
                addr = petri_base + 0x68,
            },
            {
                name = "player_flying_frames",
                type = CE_MemoryType.int_,
                addr = petri_base + 0x6c,
            },
            -- This uhh, just constantly enters/exits the escape menu..
            -- Not useful and I couldn't disable if after enabling.
            -- {
            --     name = "memory_leak_im_gui",
            --     type = CE_MemoryType.bool_,
            --     addr = petri_base + 0x70,
            -- },
            {
                name = "display_cell_velocities",
                type = CE_MemoryType.bool_,
                addr = petri_base + 0x71,
            },
            {
                name = "mDoingVideoCapture",
                type = CE_MemoryType.bool_,
                addr = petri_base + 0x72,
            },
            {
                name = "DISABLE_ANIMAL_AI",
                type = CE_MemoryType.bool_,
                addr = petri_base + 0x73,
            },
        },
    },
    {
        name = "Olli",
        items = {
            {
                name = "airflow_lo_time",
                type = CE_MemoryType.float_,
                addr = olli_base + 4,
            },
            {
                name = "airflow_lo_scale",
                type = CE_MemoryType.float_,
                addr = olli_base + 8,
            },
            {
                name = "airflow_lo_force",
                type = CE_MemoryType.float_,
                addr = olli_base + 0xc,
            },
            {
                name = "airflow_hi_time",
                type = CE_MemoryType.float_,
                addr = olli_base + 0x10,
            },
            {
                name = "airflow_hi_scale",
                type = CE_MemoryType.float_,
                addr = olli_base + 0x14,
            },
            {
                name = "airflow_hi_force",
                type = CE_MemoryType.float_,
                addr = olli_base + 0x18,
            },
        },
    },
}

local function show_debug_items(category, search)
    for _, item in ipairs(category.items) do
        if string_util.ifind(item.name, search, 1, true) then
            memory_display.show_item(item)
        end
    end
end

local search = {}

function show_debug()
    local should_show
    should_show, window_open_debug = imgui.Begin("Debug", window_open_debug)
    if should_show then
        if imgui.BeginTabBar("##debugtabs") then
            for _, category in ipairs(debug_categories) do
                if imgui.BeginTabItem(category.name) then
                    local search_changed
                    search_changed, search[category] = imgui.InputText(
                        "Search", search[category] or ""
                    )
                    imgui.Separator()

                    show_debug_items(category, search[category])
                    imgui.EndTabItem()
                end
            end

            imgui.EndTabBar()
        end

        imgui.End()
    end
end

dofile_once("mods/component-explorer/unsafe/memory_type.lua")

local function table_extend(table1, table2)
    for _, value in ipairs(table2) do
        table.insert(table1, value)
    end
end

-- Putting everything in a big list causes a "function or expression too complex near ','"
-- error. Must split the table creation using table_extend.
developer_items = {}

table_extend(developer_items, {
    {
        name = "ANIMALAI_FLYING_OFFSET_Y",
        type = CE_MemoryType.float_,
        addr = 0xd53154,
    },
    {
        name = "DEBUG_SHOW_MOUSE_MATERIAL",
        type = CE_MemoryType.bool_,
        addr = 0xe04b8f,
    },
    {
        name = "PLAYER_KICK_FORCE",
        type = CE_MemoryType.float_,
        addr = 0xd53010,
    },
    {
        name = "PLAYER_KICK_VERLET_RADIUS",
        type = CE_MemoryType.float_,
        addr = 0xd52530,
    },
    {
        name = "PLAYER_KICK_VERLET_FORCE",
        type = CE_MemoryType.float_,
        addr = 0xd52540,
    },
    {
        name = "PLAYER_KICK_FRAMES_IGNORE_COLLISION",
        type = CE_MemoryType.int_,
        addr = 0xd531b8,
    },
    {
        name = "INVENTORY_GUI_ALWAYS_VISIBLE",
        type = CE_MemoryType.bool_,
        addr = 0xd52062,
    },
    {
        name = "CAMERA_IS_FREE",
        type = CE_MemoryType.bool_,
        addr = 0xe04ffb,
    },
    {
        name = "REPORT_DAMAGE_TYPE",
        type = CE_MemoryType.bool_,
        addr = 0xd53235,
    },
    {
        name = "REPORT_DAMAGE_FONT",
        type = CE_MemoryType.std_string,
        addr = 0xd54a08,
    },
    {
        name = "REPORT_DAMAGE_SCALE",
        type = CE_MemoryType.float_,
        addr = 0xd53218,
    },
    {
        name = "REPORT_DAMAGE_BLOCK_MESSAGE_INTERVAL_FRAMES",
        type = CE_MemoryType.int_,
        addr = 0xd531d4,
    },
    {
        name = "GAME_LOG_ENABLED",
        type = CE_MemoryType.bool_,
        addr = 0xd52676,
    },
    {
        name = "RANDOMIZE_LARGE_EXPLOSION_RAYS",
        type = CE_MemoryType.bool_,
        addr = 0xd5256a,
    },
    {
        name = "EXPLOSION_FACTORY_FALLING_DIRT_FX_PROBABILITY",
        type = CE_MemoryType.int_,
        addr = 0xe07028,
    },
    {
        name = "EXPLOSION_FACTORY_STAIN_PERCENTAGE",
        type = CE_MemoryType.float_,
        addr = 0xd532ac,
    },
    {
        name = "PHYSICS_JOINT_MAX_FORCE_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0xd52684,
    },
    {
        name = "PHYSICS_RAGDOLL_JOINT_MAX_FORCE_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0xd53260,
    },
    {
        name = "PHYSICS_RAGDOLL_JOINT_MIN_BREAK_FORCE",
        type = CE_MemoryType.float_,
        addr = 0xd531fc,
    },
    {
        name = "PHYSICS_RAGDOLL_JOINT_STIFFNESS",
        type = CE_MemoryType.float_,
        addr = 0xd5263c,
    },
    {
        name = "PHYSICS_RAGDOLL_VERY_STIFF_JOINT_STIFFNESS",
        type = CE_MemoryType.float_,
        addr = 0xd53030,
    },
    {
        name = "PHYSICS_FIX_SHELF_BUG",
        type = CE_MemoryType.bool_,
        addr = 0xe04ba7,
    },
    {
        name = "GUI_HP_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0xd531c8,
    },
    {
        name = "THROW_UI_TIMESTEP_COEFF",
        type = CE_MemoryType.float_,
        addr = 0xd53208,
    },
    {
        name = "VERLET_STAIN_DROP_CHANCE_DIV",
        type = CE_MemoryType.int_,
        addr = 0xd52780,
    },
    {
        name = "ITEM_SWITCH_ITEM_TWEEN_TIME_FRAMES",
        type = CE_MemoryType.float_,
        addr = 0xd52554,
    },
    {
        name = "APPARITION_MIN_BONES_REQUIRED",
        type = CE_MemoryType.int_,
        addr = 0xd5325c,
    },
    {
        name = "TELEPORT_ATTACK_COOLDOWN_FRAMES",
        type = CE_MemoryType.int_,
        addr = 0xd53254,
    },
    {
        name = "GAMEPLAY_LIVES_ENABLED",
        type = CE_MemoryType.bool_,
        addr = 0xd524c0,
    },
    {
        name = "GAMEEFFECT_MOVEMENT_SLOWER_SPEED_MULTIPLIER_MIN",
        type = CE_MemoryType.float_,
        addr = 0xd5247c,
    },
    {
        name = "GAMEEFFECT_MOVEMENT_SLOWER_SPEED_MULTIPLIER_MAX",
        type = CE_MemoryType.float_,
        addr = 0xd52778,
    },
    {
        name = "GAMEEFFECT_MOVEMENT_FASTER_SPEED_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0xd53014,
    },
    {
        name = "GAMEEFFECT_MOVEMENT_FASTER_2X_SPEED_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0xd524e0,
    },
    {
        name = "GAMEEFFECT_CRITICAL_HIT_BOOST_CRIT_EXTRA_CHANCE",
        type = CE_MemoryType.int_,
        addr = 0xd5277c,
    },
    {
        name = "GAMEEFFECT_STAINS_DROP_FASTER_DROP_CHANCE_MULTIPLIER",
        type = CE_MemoryType.int_,
        addr = 0xd53134,
    },
    {
        name = "GAMEEFFECT_DAMAGE_MULTIPLIER_COEFF",
        type = CE_MemoryType.float_,
        addr = 0xd525b4,
    },
    {
        name = "GAMEEFFECT_INVISIBILITY_SHOT_COOLDOWN_FRAMES",
        type = CE_MemoryType.int_,
        addr = 0xd53168,
    },
    {
        name = "GAMEEFFECT_TELEPORTITIS_COOLDOWN_FRAMES",
        type = CE_MemoryType.int_,
        addr = 0xd53020,
    },
    {
        name = "GAMEEFFECT_TELEPORTITIS_DAMAGE_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0xd53220,
    },
    {
        name = "GAMEEFFECT_ELECROCUTION_RESISTANCE_DURATION_FRAMES",
        type = CE_MemoryType.int_,
        addr = 0xd53268,
    },
    {
        name = "GAMEEFFECT_FIRE_MOVEMENT_SPEED_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0xd525c0,
    },
    {
        name = "GAMEEFFECT_MANA_REGENERATION_SPEED_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0xd526cc,
    },
    {
        name = "DAMAGE_CRITICAL_HIT_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0xd5269c,
    },
    {
        name = "GAMEEFFECT_GLOBAL_GORE_GORE_MULTIPLIER",
        type = CE_MemoryType.int_,
        addr = 0xd5267c,
    },
    {
        name = "GAMEEFFECT_EXTRA_MONEY_TRICK_KILL_MULTIPLIER",
        type = CE_MemoryType.int_,
        addr = 0xd5324c,
    },
    {
        name = "GAMEFFECT_WEAKNESS_DAMAGE_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0xd53160,
    },
    {
        name = "GAME_OVER_DAMAGE_FLASH_FADE_SPEED_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0xd52668,
    },
    {
        name = "INGESTION_AMOUNT_PER_CELL_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0xd52590,
    },
    {
        name = "INGESTION_SATIATION_PER_CELL",
        type = CE_MemoryType.uint32_t,
        addr = 0xd530ec,
    },
    {
        name = "INGESTION_OVERINGESTION_MSG_PERIOD",
        type = CE_MemoryType.uint32_t,
        addr = 0xd532a8,
    },
    {
        name = "INGESTION_LIMIT_SLOW_MOVEMENT",
        type = CE_MemoryType.float_,
        addr = 0xd524fc,
    },
    {
        name = "INGESTION_LIMIT_DAMAGE",
        type = CE_MemoryType.float_,
        addr = 0xd53170,
    },
    {
        name = "INGESTION_LIMIT_EXPLODING",
        type = CE_MemoryType.float_,
        addr = 0xd53150,
    },
    {
        name = "INGESTION_LIMIT_EXPLOSION",
        type = CE_MemoryType.float_,
        addr = 0xd526f4,
    },
    {
        name = "GAMEPLAY_CHARACTER_LIQUID_FORCES_ENABLED",
        type = CE_MemoryType.bool_,
        addr = 0xe07017,
    },
    {
        name = "PLAYER_FAST_MOVEMENT_PARTICLES_ALPHA",
        type = CE_MemoryType.float_,
        addr = 0xd52770,
    },
    {
        name = "PLAYER_FAST_MOVEMENT_PARTICLES_ALPHA_CHANGE_SPD",
        type = CE_MemoryType.float_,
        addr = 0xd5270c,
    },
    {
        name = "PLAYER_FAST_MOVEMENT_EXPLOSION_TIME_MOVED_FAST_MIN",
        type = CE_MemoryType.int_,
        addr = 0xd5329c,
    },
    {
        name = "PLAYER_FAST_MOVEMENT_EXPLOSION_TIME_MOVED_FAST_MAX",
        type = CE_MemoryType.int_,
        addr = 0xd52670,
    },
    {
        name = "PLAYER_FAST_MOVEMENT_EXPLOSION_COOLDOWN",
        type = CE_MemoryType.int_,
        addr = 0xd531d0,
    },
    {
        name = "PLAYER_FAST_MOVEMENT_EXPLOSION_GROUND_RAY_LENGTH",
        type = CE_MemoryType.float_,
        addr = 0xd5323c,
    },
    {
        name = "PLAYER_FAST_MOVEMENT_EXPLOSION_GROUND_PENETRATE_LENGTH",
        type = CE_MemoryType.float_,
        addr = 0xd524c8,
    },
    {
        name = "COOP_RESPAWN_TIMER_FRAMES",
        type = CE_MemoryType.int_,
        addr = 0xd524bc,
    },
    {
        name = "DROP_LEVEL_1",
        type = CE_MemoryType.float_,
        addr = 0xd524f4,
    },
    {
        name = "DROP_LEVEL_2",
        type = CE_MemoryType.float_,
        addr = 0xd524c4,
    },
    {
        name = "DROP_LEVEL_3",
        type = CE_MemoryType.float_,
        addr = 0xd52584,
    },
    {
        name = "DROP_LEVEL_4",
        type = CE_MemoryType.float_,
        addr = 0xd52534,
    },
    {
        name = "DROP_LEVEL_5",
        type = CE_MemoryType.float_,
        addr = 0xd524cc,
    },
    {
        name = "DROP_LEVEL_6",
        type = CE_MemoryType.float_,
        addr = 0xd531bc,
    },
    {
        name = "DROP_LEVEL_7",
        type = CE_MemoryType.float_,
        addr = 0xd531e4,
    },
    {
        name = "DROP_LEVEL_8",
        type = CE_MemoryType.float_,
        addr = 0xd524d0,
    },
    {
        name = "DROP_LEVEL_9",
        type = CE_MemoryType.float_,
        addr = 0xd53298,
    },
    {
        name = "BIOME_MAP",
        type = CE_MemoryType.std_string,
        addr = 0xd554b8,
    },
    {
        name = "BIOME_APPARITION_CHANCE",
        type = CE_MemoryType.int_,
        addr = 0xd52548,
    },
    {
        name = "BIOME_RANDOM_BLOCK_CHANCE",
        type = CE_MemoryType.float_,
        addr = 0xd530e8,
    },
    {
        name = "BIOME_USE_BIG_WANG",
        type = CE_MemoryType.bool_,
        addr = 0xd52677,
    },
    {
        name = "BIOME_PATH_FIND_HEIGHT_LIMIT",
        type = CE_MemoryType.int_,
        addr = 0xd52478,
    },
    {
        name = "BIOME_PATH_FIND_WORLD_POS_MIN_X",
        type = CE_MemoryType.int_,
        addr = 0xd525d4,
    },
    {
        name = "BIOME_PATH_FIND_WORLD_POS_MAX_X",
        type = CE_MemoryType.int_,
        addr = 0xd5303c,
    },
    {
        name = "WORLD_SEED",
        type = CE_MemoryType.uint32_t,
        addr = 0xe06fe8,
    },
    {
        name = "NUM_ORBS_TOTAL",
        type = CE_MemoryType.int_,
        addr = 0xd52544,
    },
    {
        name = "CAMERA_MOUSE_INTERPOLATION_SPEED",
        type = CE_MemoryType.float_,
        addr = 0xd525ac,
    },
    {
        name = "CAMERA_GAMEPAD_INTERPOLATION_SPEED",
        type = CE_MemoryType.float_,
        addr = 0xd52504,
    },
    {
        name = "CAMERA_GAMEPAD_MAX_DISTANCE",
        type = CE_MemoryType.float_,
        addr = 0xd5300c,
    },
    {
        name = "CAMERA_POSITION_INTERPOLATION_SPEED",
        type = CE_MemoryType.float_,
        addr = 0xd53158,
    },
    {
        name = "CAMERA_DISTANCE_INTERPOLATION_SPEED",
        type = CE_MemoryType.float_,
        addr = 0xd525f4,
    },
    {
        name = "CAMERA_NO_MOVE_BUFFER_NEAR_PLAYER",
        type = CE_MemoryType.float_,
        addr = 0xe04fec,
    },
    {
        name = "CAMERA_NO_MOVE_BUFFER_NEAR_VIEWPORT_EDGE",
        type = CE_MemoryType.float_,
        addr = 0xd525b8,
    },
    {
        name = "CAMERA_RECOIL_ATTACK_SPEED",
        type = CE_MemoryType.float_,
        addr = 0xd525b0,
    },
    {
        name = "CAMERA_RECOIL_RELEASE_SPEED",
        type = CE_MemoryType.float_,
        addr = 0xd53274,
    },
    {
        name = "CAMERA_RECOIL_AMOUNT",
        type = CE_MemoryType.float_,
        addr = 0xd52790,
    },
    {
        name = "CAMERA_ERROR_SMOOTHING_THRESHOLD_X",
        type = CE_MemoryType.float_,
        addr = 0xd53270,
    },
    {
        name = "CAMERA_ERROR_SMOOTHING_THRESHOLD_Y_MAX",
        type = CE_MemoryType.float_,
        addr = 0xd53300,
    },
    {
        name = "CAMERA_ERROR_SMOOTHING_THRESHOLD_Y_MIN",
        type = CE_MemoryType.float_,
        addr = 0xd5253c,
    },
    {
        name = "CAMERA_ERROR_CORRECTION_SPD_UP_X",
        type = CE_MemoryType.float_,
        addr = 0xd53284,
    },
    {
        name = "CAMERA_ERROR_CORRECTION_SPD_UP_Y",
        type = CE_MemoryType.float_,
        addr = 0xd531f8,
    },
    {
        name = "CAMERA_ERROR_CORRECTION_SPD_DOWN_X",
        type = CE_MemoryType.float_,
        addr = 0xd524d8,
    },
    {
        name = "CAMERA_ERROR_CORRECTION_SPD_DOWN_Y",
        type = CE_MemoryType.float_,
        addr = 0xd53210,
    },
    {
        name = "CAMERA_ERROR_CORRECTION_AMOUNT_X",
        type = CE_MemoryType.float_,
        addr = 0xd53130,
    },
    {
        name = "CAMERA_ERROR_CORRECTION_AMOUNT_Y",
        type = CE_MemoryType.float_,
        addr = 0xd5252c,
    },
    {
        name = "CAMERA_FAST_SWITCH_SPEED",
        type = CE_MemoryType.float_,
        addr = 0xd5302c,
    },
    {
        name = "MULTIPLAYER_CAMERA_SMOOTHING",
        type = CE_MemoryType.float_,
        addr = 0xd52520,
    },
    {
        name = "MULTIPLAYER_CAMERA_MAX_SMOOTH_DISTANCE",
        type = CE_MemoryType.float_,
        addr = 0xd53034,
    },
    {
        name = "CAMERA_IS_UI_OPEN",
        type = CE_MemoryType.bool_,
        addr = 0xe07015,
    },
    {
        name = "PLAYER_USE_NEW_JETPACK",
        type = CE_MemoryType.bool_,
        addr = 0xe04bd5,
    },
    {
        name = "DOUBLE_CLICK_MAX_SPAN_SECONDS",
        type = CE_MemoryType.float_,
        addr = 0xd524e4,
    },
    {
        name = "ESC_QUITS_GAME",
        type = CE_MemoryType.bool_,
        addr = 0xe05016,
    },
    {
        name = "GAMEPAD_AIMING_VECTOR_SMOOTHING_COEFF",
        type = CE_MemoryType.float_,
        addr = 0xd5328c,
    },
    {
        name = "CONTROLS_AIMING_VECTOR_FULL_LENGTH_PIXELS",
        type = CE_MemoryType.float_,
        addr = 0xd524ec,
    },
    {
        name = "GAMEPAD_SHOT_VIBRATION_FORCE_MIN",
        type = CE_MemoryType.float_,
        addr = 0xd5301c,
    },
    {
        name = "GAMEPAD_SHOT_VIBRATION_FORCE_COEFF",
        type = CE_MemoryType.float_,
        addr = 0xd532e8,
    },
    {
        name = "GAMEPAD_SHOT_VIBRATION_TIME_COEFF",
        type = CE_MemoryType.float_,
        addr = 0xd5268c,
    },
    {
        name = "GAMEPAD_ANALOG_FLYING_LOW",
        type = CE_MemoryType.float_,
        addr = 0xd52574,
    },
    {
        name = "GAMEPAD_ANALOG_FLYING_HIGH",
        type = CE_MemoryType.float_,
        addr = 0xd5259c,
    },
    {
        name = "RAGDOLL_FX_EXPLOSION_ROTATION",
        type = CE_MemoryType.float_,
        addr = 0xd53138,
    },
    {
        name = "RAGDOLL_BLOOD_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0xd52ff4,
    },
    {
        name = "RAGDOLL_FIRE_DEATH_IGNITE_EVERY_N_PIXEL",
        type = CE_MemoryType.int_,
        addr = 0xd52ff8,
    },
    {
        name = "RAGDOLL_IMPULSE_RANDOMNESS",
        type = CE_MemoryType.float_,
        addr = 0xd52550,
    },
    {
        name = "RAGDOLL_OWN_VELOCITY_IMPULSE_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0xd52fe8,
    },
    {
        name = "RAGDOLL_CRITICAL_HIT_FORCE_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0xd53178,
    },
    {
        name = "DAMAGE_BLOOD_AMOUNT_MIN",
        type = CE_MemoryType.int_,
        addr = 0xd52064,
    },
    {
        name = "DAMAGE_BLOOD_AMOUNT_MAX",
        type = CE_MemoryType.int_,
        addr = 0xd5254c,
    },
    {
        name = "DAMAGE_FIRE_DAMAGE_MAX_HP_MIN_BOUND",
        type = CE_MemoryType.float_,
        addr = 0xd52514,
    },
    {
        name = "DAMAGE_BLOOD_SPRAY_CHANCE",
        type = CE_MemoryType.int_,
        addr = 0xd53024,
    },
    {
        name = "EXPLOSION_FACTORY_GORE_FX_PROBABLITY",
        type = CE_MemoryType.int_,
        addr = 0xd52564,
    },
    {
        name = "EXPLOSION_FACTORY_GORE_FX_HOLE_PROBABILITY",
        type = CE_MemoryType.int_,
        addr = 0xd52500,
    },
    {
        name = "EXPLOSION_FACTORY_GORE_FX_BLOOD_STAIN_COLOR",
        type = CE_MemoryType.uint32_t,
        addr = 0xd525ec,
    },
    {
        name = "GRID_MAX_UPDATES_PER_FRAME",
        type = CE_MemoryType.int_,
        addr = 0xd52474,
    },
    {
        name = "GRID_FLEXIBLE_MAX_UPDATES",
        type = CE_MemoryType.bool_,
        addr = 0xe04fe1,
    },
    {
        name = "GRID_MIN_UPDATES_PER_FRAME",
        type = CE_MemoryType.int_,
        addr = 0xd525d0,
    },
    {
        name = "CELLFACTORY_CELLDATA_MAX_COUNT",
        type = CE_MemoryType.int_,
        addr = 0xd53004,
    },
    {
        name = "PARTICLE_EMITTER_MAX_PARTICLES",
        type = CE_MemoryType.int_,
        addr = 0xd53008,
    },
    {
        name = "VIRTUAL_RESOLUTION_X",
        type = CE_MemoryType.int_,
        addr = 0xd53128,
    },
    {
        name = "VIRTUAL_RESOLUTION_Y",
        type = CE_MemoryType.int_,
        addr = 0xd52558,
    },
    {
        name = "VIRTUAL_RESOLUTION_OFFSET_X",
        type = CE_MemoryType.float_,
        addr = 0xd52710,
    },
    {
        name = "VIRTUAL_RESOLUTION_OFFSET_Y",
        type = CE_MemoryType.float_,
        addr = 0xd52658,
    },
    {
        name = "GRID_RENDER_BORDER",
        type = CE_MemoryType.int_,
        addr = 0xd532fc,
    },
    {
        name = "GRID_RENDER_TILE_SIZE",
        type = CE_MemoryType.int_,
        addr = 0xd52664,
    },
    {
        name = "DRAW_PARALLAX_BACKGROUND",
        type = CE_MemoryType.bool_,
        addr = 0xd53165,
    },
    {
        name = "DRAW_PARALLAX_BACKGROUND_BEFORE_DEPTH",
        type = CE_MemoryType.float_,
        addr = 0xd5257c,
    },
    {
        name = "RENDER_PARALLAX_BACKGROUND_SHADER_GRADIENT",
        type = CE_MemoryType.bool_,
        addr = 0xe06fab,
    },
    {
        name = "RENDER_SKYLIGHT_MAX_REDUCTION_AMOUNT",
        type = CE_MemoryType.float_,
        addr = 0xd531e0,
    },
    {
        name = "RENDER_SKYLIGHT_ABOVE_WEIGHT",
        type = CE_MemoryType.float_,
        addr = 0xd525c4,
    },
    {
        name = "RENDER_SKYLIGHT_SIDES_WEIGHT",
        type = CE_MemoryType.float_,
        addr = 0xd52654,
    },
    {
        name = "RENDER_SKYLIGHT_TOTAL_WEIGHT",
        type = CE_MemoryType.float_,
        addr = 0xd5317c,
    },
    {
        name = "RENDER_FIRE_LO_TIME",
        type = CE_MemoryType.float_,
        addr = 0xd52678,
    },
    {
        name = "RENDER_FIRE_LO_SCALE",
        type = CE_MemoryType.float_,
        addr = 0xd525f0,
    },
    {
        name = "RENDER_FIRE_LO_FORCE",
        type = CE_MemoryType.float_,
        addr = 0xd5279c,
    },
    {
        name = "RENDER_FIRE_HI_TIME",
        type = CE_MemoryType.float_,
        addr = 0xd52538,
    },
    {
        name = "RENDER_FIRE_HI_SCALE",
        type = CE_MemoryType.float_,
        addr = 0xd5255c,
    },
    {
        name = "RENDER_FIRE_HI_FORCE",
        type = CE_MemoryType.float_,
        addr = 0xe04fe4,
    },
    {
        name = "RENDER_FIRE_GRAVITY",
        type = CE_MemoryType.float_,
        addr = 0xd526f8,
    },
    {
        name = "RENDER_FIRE_LIFETIME_MIN",
        type = CE_MemoryType.int_,
        addr = 0xd5205c,
    },
    {
        name = "RENDER_FIRE_LIFETIME_MAX",
        type = CE_MemoryType.int_,
        addr = 0xd5265c,
    },
    {
        name = "RENDER_FIRE_GLOW_ALPHA",
        type = CE_MemoryType.float_,
        addr = 0xd52598,
    },
    {
        name = "RENDER_FIRE_SHARP_ALPHA",
        type = CE_MemoryType.float_,
        addr = 0xd532f8,
    },
    {
        name = "RENDER_POTION_PARTICLE_MAX_COLOR_COMPONENT",
        type = CE_MemoryType.float_,
        addr = 0xd53250,
    },
    {
        name = "RENDER_color_grading_LERP_SPEED",
        type = CE_MemoryType.float_,
        addr = 0xd5314c,
    },
    {
        name = "TELEPORT_FLASH_COLOR_R",
        type = CE_MemoryType.float_,
        addr = 0xe059dc,
    },
    {
        name = "TELEPORT_FLASH_COLOR_G",
        type = CE_MemoryType.float_,
        addr = 0xe059e4,
    },
    {
        name = "TELEPORT_FLASH_COLOR_B",
        type = CE_MemoryType.float_,
        addr = 0xe0472c,
    },
    {
        name = "AUDIO_GAMEEFFECT_FIRE_WEIGHT",
        type = CE_MemoryType.float_,
        addr = 0xd52660,
    },
    {
        name = "AUDIO_FIRE_WEIGHT",
        type = CE_MemoryType.float_,
        addr = 0xd532a4,
    },
    {
        name = "AUDIO_MAGICAL_MATERIAL_WEIGHT",
        type = CE_MemoryType.float_,
        addr = 0xd52594,
    },
    {
        name = "AUDIO_GAME_START_FADE_FRAME",
        type = CE_MemoryType.float_,
        addr = 0xd52688,
    },
    {
        name = "AUDIO_GAME_START_FADE_SPEED",
        type = CE_MemoryType.float_,
        addr = 0xd52588,
    },
    {
        name = "AUDIO_MUSIC_VOLUME_DEFAULT",
        type = CE_MemoryType.float_,
        addr = 0xd52570,
    },
    {
        name = "AUDIO_MUSIC_QUIET_FADE_DOWN_SPEED",
        type = CE_MemoryType.float_,
        addr = 0xd526ac,
    },
    {
        name = "AUDIO_MUSIC_NORMAL_FADE_DOWN_SPEED",
        type = CE_MemoryType.float_,
        addr = 0xd53258,
    },
    {
        name = "AUDIO_MUSIC_NORMAL_FADE_UP_SPEED",
        type = CE_MemoryType.float_,
        addr = 0xd53204,
    },
    {
        name = "AUDIO_MUSIC_ACTION_FADE_DOWN_SPEED",
        type = CE_MemoryType.float_,
        addr = 0xd52694,
    },
    {
        name = "AUDIO_MUSIC_ACTION_FADE_UP_SPEED",
        type = CE_MemoryType.float_,
        addr = 0xd531c4,
    },
    {
        name = "AUDIO_MUSIC_LOW_ENERGY_TRIGGER_COOLDOWN_SECONDS",
        type = CE_MemoryType.double_,
        addr = 0xd52600,
    },
    {
        name = "AUDIO_MUSIC_FORCED_QUIETNESS_TRIGGERS_AFTER_SECONDS",
        type = CE_MemoryType.int_,
        addr = 0xd526f0,
    },
    {
        name = "AUDIO_MUSIC_FORCED_QUIETNESS_DURATION_SECONDS",
        type = CE_MemoryType.int_,
        addr = 0xd524f0,
    },
    {
        name = "AUDIO_COLLISION_SIZE_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0xd52638,
    },
    {
        name = "AUDIO_COLLISION_SPEED_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0xd52690,
    },
    {
        name = "AUDIO_COLLISION_KICK_SIZE",
        type = CE_MemoryType.float_,
        addr = 0xd53214,
    },
    {
        name = "AUDIO_COLLISION_COOLDOWN_SECONDS",
        type = CE_MemoryType.float_,
        addr = 0xd525f8,
    },
    {
        name = "AUDIO_COLLISION_STATIC_WALL_INTENSITY",
        type = CE_MemoryType.float_,
        addr = 0xd531dc,
    },
    {
        name = "AUDIO_COLLISION_STATIC_WALL_SPEED_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0xd5320c,
    },
    {
        name = "AUDIO_PHYSICS_BREAK_MASS_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0xd53144,
    },
    {
        name = "AUDIO_CHARACTER_LIQUID_SPLASH_INTENSITY_MIN",
        type = CE_MemoryType.float_,
        addr = 0xe06fc0,
    },
    {
        name = "AUDIO_CHARACTER_LIQUID_SPLASH_INTENSITY_MAX",
        type = CE_MemoryType.float_,
        addr = 0xd53264,
    },
    {
        name = "AUDIO_CHARACTER_LIQUID_SPLASH_INTENSITY_SPEED_DIV",
        type = CE_MemoryType.float_,
        addr = 0xd5315c,
    },
    {
        name = "AUDIO_EXPLOSION_NO_SOUND_BELOW_RADIUS",
        type = CE_MemoryType.float_,
        addr = 0xd52714,
    },
    {
        name = "AUDIO_EXPLOSION_SMALL_SOUND_MAX_RADIUS",
        type = CE_MemoryType.float_,
        addr = 0xd532f0,
    },
    {
        name = "AUDIO_PICK_GOLD_SAND_MIN_AMOUNT_FOR_SOUND",
        type = CE_MemoryType.int_,
        addr = 0xd525dc,
    },
    {
        name = "AUDIO_PICK_GOLD_SAND_AMOUNT_ACCUMULATION_FRAMES",
        type = CE_MemoryType.int_,
        addr = 0xd52fec,
    },
    {
        name = "AUDIO_AMBIENCE_ALTITUDE_SCALE",
        type = CE_MemoryType.float_,
        addr = 0xd527a4,
    },
    {
        name = "AUDIO_CREDITS_TRACK_NAME",
        type = CE_MemoryType.std_string,
        addr = 0xd54cf0,
    },
    {
        name = "AUDIO_PLAY_GAME_OVER_SOUND",
        type = CE_MemoryType.bool_,
        addr = 0xd52775,
    },
    {
        name = "AUDIO_FADE_MUSIC_ON_DEATH",
        type = CE_MemoryType.bool_,
        addr = 0xd52680,
    },
    {
        name = "PATHFINDING_DISTANCE_FIELD_ENABLED",
        type = CE_MemoryType.bool_,
        addr = 0xd52509,
    },
    {
        name = "STREAMING_ENABLED",
        type = CE_MemoryType.bool_,
        addr = 0xd524c1,
    },
    {
        name = "STREAMING_FREQUENCY",
        type = CE_MemoryType.double_,
        addr = 0xd52700,
    },
    {
        name = "STREAMING_CHUNK_TARGET",
        type = CE_MemoryType.int_,
        addr = 0xd53294,
    },
    {
        name = "STREAMING_PERSISTENT_WORLD",
        type = CE_MemoryType.bool_,
        addr = 0xd52681,
    },
    {
        name = "STREAMING_AUTOSAVE_PERIOD_SECONDS",
        type = CE_MemoryType.int_,
        addr = 0xd525e4,
    },
    {
        name = "INVENTORY_ICON_SIZE",
        type = CE_MemoryType.int_,
        addr = 0xd53278,
    },
})
table_extend(developer_items, {
    {
        name = "INVENTORY_STASH_X",
        type = CE_MemoryType.float_,
        addr = 0xd53230,
    },
    {
        name = "INVENTORY_STASH_Y",
        type = CE_MemoryType.float_,
        addr = 0xd5278c,
    },
    {
        name = "INVENTORY_DEBUG_X",
        type = CE_MemoryType.float_,
        addr = 0xd5327c,
    },
    {
        name = "INVENTORY_DEBUG_Y",
        type = CE_MemoryType.float_,
        addr = 0xd53248,
    },
    {
        name = "UI_SNAP_TO_NEAREST_INTEGER_SCALE",
        type = CE_MemoryType.bool_,
        addr = 0xd5250a,
    },
    {
        name = "UI_BARS_SCALE",
        type = CE_MemoryType.float_,
        addr = 0xd531d8,
    },
    {
        name = "UI_BARS_POS_X",
        type = CE_MemoryType.float_,
        addr = 0xd53028,
    },
    {
        name = "UI_BARS_POS_Y",
        type = CE_MemoryType.float_,
        addr = 0xd525cc,
    },
    {
        name = "UI_BARS2_OFFSET_X",
        type = CE_MemoryType.float_,
        addr = 0xd5326c,
    },
    {
        name = "UI_PLAYER_FULL_STATS_POS_X",
        type = CE_MemoryType.float_,
        addr = 0xd5275c,
    },
    {
        name = "UI_PLAYER_FULL_STATS_POS_Y",
        type = CE_MemoryType.float_,
        addr = 0xd53148,
    },
    {
        name = "UI_PLAYER_FULL_STATS_COLUMN2_OFFSET_X",
        type = CE_MemoryType.float_,
        addr = 0xd5251c,
    },
    {
        name = "UI_PLAYER_FULL_STATS_COLUMN3_OFFSET_X",
        type = CE_MemoryType.float_,
        addr = 0xd53290,
    },
    {
        name = "UI_STAT_BAR_EXTRA_SPACING",
        type = CE_MemoryType.float_,
        addr = 0xd524b8,
    },
    {
        name = "UI_STAT_BAR_ICON_OFFSET_Y",
        type = CE_MemoryType.float_,
        addr = 0xe05000,
    },
    {
        name = "UI_STAT_BAR_TEXT_OFFSET_X",
        type = CE_MemoryType.float_,
        addr = 0xd52510,
    },
    {
        name = "UI_STAT_BAR_TEXT_OFFSET_Y",
        type = CE_MemoryType.float_,
        addr = 0xe04b9c,
    },
    {
        name = "UI_QUICKBAR_OFFSET_X",
        type = CE_MemoryType.float_,
        addr = 0xe051cc,
    },
    {
        name = "UI_QUICKBAR_OFFSET_Y",
        type = CE_MemoryType.float_,
        addr = 0xe06fd0,
    },
    {
        name = "UI_INVENTORY_BACKGROUND_POSITION_X",
        type = CE_MemoryType.float_,
        addr = 0xe06fdc,
    },
    {
        name = "UI_INVENTORY_BACKGROUND_POSITION_Y",
        type = CE_MemoryType.float_,
        addr = 0xe04b3c,
    },
    {
        name = "UI_FULL_INVENTORY_OFFSET_X",
        type = CE_MemoryType.float_,
        addr = 0xd5258c,
    },
    {
        name = "UI_IMPORTANT_MESSAGE_POS_Y",
        type = CE_MemoryType.int_,
        addr = 0xd52794,
    },
    {
        name = "UI_IMPORTANT_MESSAGE_TITLE_SCALE",
        type = CE_MemoryType.float_,
        addr = 0xd53240,
    },
    {
        name = "UI_LOW_HP_THRESHOLD",
        type = CE_MemoryType.float_,
        addr = 0xd526a8,
    },
    {
        name = "UI_LOW_HP_WARNING_FLASH_FREQUENCY",
        type = CE_MemoryType.float_,
        addr = 0xd526a4,
    },
    {
        name = "UI_PIXEL_FONT_GAME_LOG",
        type = CE_MemoryType.bool_,
        addr = 0xd52508,
    },
    {
        name = "UI_PAUSE_MENU_LAYOUT_TOP_EDGE_PERCENTAGE",
        type = CE_MemoryType.int_,
        addr = 0xd531e8,
    },
    {
        name = "UI_GAME_OVER_MENU_LAYOUT_TOP_EDGE_PERCENTAGE",
        type = CE_MemoryType.int_,
        addr = 0xd525c8,
    },
    {
        name = "UI_WOBBLE_SPEED",
        type = CE_MemoryType.float_,
        addr = 0xd527dc,
    },
    {
        name = "UI_WOBBLE_AMOUNT_DEGREES",
        type = CE_MemoryType.float_,
        addr = 0xd52058,
    },
    {
        name = "UI_GAMEOVER_SCREEN_BOX_FROM_TOP_PERCENT",
        type = CE_MemoryType.float_,
        addr = 0xd527ac,
    },
    {
        name = "UI_GAMEOVER_SCREEN_BOX_FROM_SIDE_PERCENT",
        type = CE_MemoryType.float_,
        addr = 0xd525fc,
    },
    {
        name = "UI_GAMEOVER_SCREEN_BOX_FROM_BOTTOM_PERCENT",
        type = CE_MemoryType.float_,
        addr = 0xd52784,
    },
    {
        name = "UI_GAMEOVER_SCREEN_MUSIC_CUE_TIMER_FRAMES",
        type = CE_MemoryType.int_,
        addr = 0xd53200,
    },
    {
        name = "UI_COOP_QUICK_INVENTORY_HEIGHT",
        type = CE_MemoryType.float_,
        addr = 0xd52580,
    },
    {
        name = "UI_COOP_STAT_BARS_HEIGHT",
        type = CE_MemoryType.float_,
        addr = 0xd52718,
    },
    {
        name = "UI_SCALE_IN_SPEED",
        type = CE_MemoryType.float_,
        addr = 0xd5316c,
    },
    {
        name = "UI_DAMAGE_INDICATOR_RANDOM_OFFSET",
        type = CE_MemoryType.float_,
        addr = 0xd524dc,
    },
    {
        name = "UI_ITEM_STAND_OVER_INFO_BOX_OFFSET_X",
        type = CE_MemoryType.float_,
        addr = 0xd5276c,
    },
    {
        name = "UI_ITEM_STAND_OVER_INFO_BOX_OFFSET_Y",
        type = CE_MemoryType.float_,
        addr = 0xd525e0,
    },
    {
        name = "UI_MOUSE_WORLD_HOVER_TEXT_OFFSET_X",
        type = CE_MemoryType.float_,
        addr = 0xd52758,
    },
    {
        name = "UI_MOUSE_WORLD_HOVER_TEXT_OFFSET_Y",
        type = CE_MemoryType.float_,
        addr = 0xd53140,
    },
    {
        name = "UI_MAX_PERKS_VISIBLE",
        type = CE_MemoryType.int_,
        addr = 0xd5250c,
    },
    {
        name = "UI_LOCALIZE_RECORD_TEXT",
        type = CE_MemoryType.bool_,
        addr = 0xe059d8,
    },
    {
        name = "UI_DISPLAY_NUMBERS_WITH_KS_AND_MS",
        type = CE_MemoryType.bool_,
        addr = 0xd525e8,
    },
    {
        name = "UI_WAND_TAG_OVERWRITES_NAME",
        type = CE_MemoryType.bool_,
        addr = 0xd52060,
    },
    {
        name = "UI_DISPLAY_POTION_CONTENT_PERCENTS",
        type = CE_MemoryType.bool_,
        addr = 0xd525e9,
    },
    {
        name = "UI_POTION_CONTENTS_COMBINE_SAME_NAME_MATERIALS",
        type = CE_MemoryType.bool_,
        addr = 0xd524fa,
    },
    {
        name = "UI_HEALTHBAR_Y_SPACING",
        type = CE_MemoryType.float_,
        addr = 0xd527e4,
    },
    {
        name = "MAIN_MENU_BG_OFFSET_X",
        type = CE_MemoryType.float_,
        addr = 0xd525d8,
    },
    {
        name = "MAIN_MENU_BG_OFFSET_Y",
        type = CE_MemoryType.float_,
        addr = 0xd532a0,
    },
    {
        name = "MAIN_MENU_BG_OFFSET_Y_END",
        type = CE_MemoryType.float_,
        addr = 0xd53038,
    },
    {
        name = "MAIN_MENU_BG_TWEEN_SPEED",
        type = CE_MemoryType.float_,
        addr = 0xd5313c,
    },
    {
        name = "USE_CUSTOM_THREADPOOL",
        type = CE_MemoryType.bool_,
        addr = 0xd53177,
    },
    {
        name = "BOX2D_FREEZE_STUCK_BODIES",
        type = CE_MemoryType.bool_,
        addr = 0xd532f4,
    },
    {
        name = "BOX2D_THREAD_MAX_WAIT_IN_MS",
        type = CE_MemoryType.float_,
        addr = 0xd53288,
    },
    {
        name = "CREDITS_SCROLL_SPEED",
        type = CE_MemoryType.float_,
        addr = 0xd526ec,
    },
    {
        name = "CREDITS_SCROLL_END_OFFSET_EXTRA",
        type = CE_MemoryType.float_,
        addr = 0xd5266c,
    },
    {
        name = "CREDITS_SCROLL_SKIP_SPEED_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0xd527b0,
    },
    {
        name = "INTRO_WEATHER_FOG",
        type = CE_MemoryType.float_,
        addr = 0xd531c0,
    },
    {
        name = "INTRO_WEATHER_RAIN",
        type = CE_MemoryType.float_,
        addr = 0xd531f4,
    },
    {
        name = "SETTINGS_MIN_RESOLUTION_X",
        type = CE_MemoryType.int_,
        addr = 0xd524d4,
    },
    {
        name = "SETTINGS_MIN_RESOLUTION_Y",
        type = CE_MemoryType.int_,
        addr = 0xd527a8,
    },
    {
        name = "STEAM_CLOUD_SIZE_WARNING",
        type = CE_MemoryType.bool_,
        addr = 0xe07014,
    },
    {
        name = "DEBUG_KEYS_ENABLED",
        type = CE_MemoryType.bool_,
        addr = 0xd525a2,
    },
    {
        name = "DEBUG_EXTRA_SCREENSHOT_KEYS_ENABLED",
        type = CE_MemoryType.bool_,
        addr = 0xd524f8,
    },
    {
        name = "DEBUG_USE_PRELOAD",
        type = CE_MemoryType.bool_,
        addr = 0xd525ea,
    },
    {
        name = "DEBUG_USE_DEBUG_PRELOAD",
        type = CE_MemoryType.bool_,
        addr = 0xe0500e,
    },
    {
        name = "DEBUG_TREES",
        type = CE_MemoryType.bool_,
        addr = 0xe06fcf,
    },
    {
        name = "DEBUG_PIXEL_SCENES",
        type = CE_MemoryType.bool_,
        addr = 0xe051d6,
    },
    {
        name = "DEBUG_TELEPORT",
        type = CE_MemoryType.bool_,
        addr = 0xe04fe2,
    },
    {
        name = "DEBUG_SI_TYPE",
        type = CE_MemoryType.int_,
        addr = 0xe051d0,
    },
    {
        name = "DEBUG_AUDIO_DEV_MODE",
        type = CE_MemoryType.bool_,
        addr = 0xe04b8b,
    },
    {
        name = "DEBUG_AUDIO_MUTE",
        type = CE_MemoryType.bool_,
        addr = 0xe04b8e,
    },
    {
        name = "DEBUG_AUDIO_MUSIC_MUTE",
        type = CE_MemoryType.bool_,
        addr = 0xe04ba5,
    },
    {
        name = "DEBUG_AUDIO_VOLUME",
        type = CE_MemoryType.float_,
        addr = 0xd52ffc,
    },
    {
        name = "DEBUG_TEST_SYMBOL_CLASSIFIER",
        type = CE_MemoryType.bool_,
        addr = 0xe059e9,
    },
    {
        name = "DEBUG_STREAMING_DISABLE_SAVING",
        type = CE_MemoryType.bool_,
        addr = 0xe06fa9,
    },
    {
        name = "DEBUG_DRAW_ANIMAL_AI_STATE",
        type = CE_MemoryType.bool_,
        addr = 0xe0502a,
    },
    {
        name = "DEBUG_PRINT_COMPONENT_UPDATOR_ORDER",
        type = CE_MemoryType.bool_,
        addr = 0xe051d4,
    },
    {
        name = "DEBUG_SKYLIGHT_NO_SIMD",
        type = CE_MemoryType.bool_,
        addr = 0xe04bc5,
    },
    {
        name = "DEBUG_DISABLE_MOUSE_SCROLL_WHEEL",
        type = CE_MemoryType.bool_,
        addr = 0xe07016,
    },
    {
        name = "DEBUG_NO_SAVEGAME_CLEAR_ON_GAME_OVER",
        type = CE_MemoryType.bool_,
        addr = 0xe07042,
    },
    {
        name = "DEBUG_CAMERA_SHAKE_OFFSET",
        type = CE_MemoryType.float_,
        addr = 0xe051c8,
    },
    {
        name = "DEBUG_FREE_CAMERA_SPEED",
        type = CE_MemoryType.float_,
        addr = 0xd526a0,
    },
    {
        name = "DEBUG_DISABLE_POSTFX_DITHERING",
        type = CE_MemoryType.bool_,
        addr = 0xe0702e,
    },
    {
        name = "DEBUG_SCREENSHOTS_VIDEO_PATH_PREFIX",
        type = CE_MemoryType.std_string,
        addr = 0xd54e48,
    },
    {
        name = "DEBUG_GIF_WIDTH",
        type = CE_MemoryType.int_,
        addr = 0xd52578,
    },
    {
        name = "DEBUG_GIF_HEIGHT",
        type = CE_MemoryType.int_,
        addr = 0xd52524,
    },
    {
        name = "DEBUG_GIF_RECORD_60FPS",
        type = CE_MemoryType.bool_,
        addr = 0xe04b38,
    },
    {
        name = "DEBUG_SPRITE_UV_GEN_REPORT_MISSING_FILES",
        type = CE_MemoryType.bool_,
        addr = 0xe04bc6,
    },
    {
        name = "DEBUG_NO_PAUSE_ON_WINDOW_FOCUS_LOST",
        type = CE_MemoryType.bool_,
        addr = 0xe06fce,
    },
    {
        name = "DEBUG_DEMO_MODE",
        type = CE_MemoryType.bool_,
        addr = 0xe04b8c,
    },
    {
        name = "DEBUG_DEMO_MODE_RESET_TIMEOUT_FRAMES",
        type = CE_MemoryType.int_,
        addr = 0xd53238,
    },
    {
        name = "DEBUG_DEMO_MODE_RESET_WARNING_TIME_FRAMES",
        type = CE_MemoryType.int_,
        addr = 0xd5271c,
    },
    {
        name = "DEBUG_DISABLE_PHYSICSBODY_OUT_OF_BOUNDS_WARNING",
        type = CE_MemoryType.bool_,
        addr = 0xe051b9,
    },
    {
        name = "DEBUG_ENABLE_AUTOSAVE",
        type = CE_MemoryType.bool_,
        addr = 0xd532f5,
    },
    {
        name = "DEBUG_AUDIO_WRITE_TO_FILE",
        type = CE_MemoryType.bool_,
        addr = 0xe05017,
    },
    {
        name = "DEBUG_NO_LOGO_SPLASHES",
        type = CE_MemoryType.bool_,
        addr = 0xe04ba9,
    },
    {
        name = "DEBUG_TEST_SAVE_SPAWN_X",
        type = CE_MemoryType.float_,
        addr = 0xd531cc,
    },
    {
        name = "DEBUG_INTRO_PLAY_ALWAYS",
        type = CE_MemoryType.bool_,
        addr = 0xe06ff8,
    },
    {
        name = "DEBUG_REPLAY_RECORDER_FPS",
        type = CE_MemoryType.int_,
        addr = 0xd5256c,
    },
    {
        name = "DEBUG_F12_OPEN_FOG_OF_WAR",
        type = CE_MemoryType.bool_,
        addr = 0xd52774,
    },
    {
        name = "DEBUG_ALWAYS_COMPLETE_THE_GAME",
        type = CE_MemoryType.bool_,
        addr = 0xe04bb8,
    },
    {
        name = "DEBUG_SKIP_RELEASE_NOTES",
        type = CE_MemoryType.bool_,
        addr = 0xe04b3b,
    },
    {
        name = "DEBUG_SKIP_MAIN_MENU",
        type = CE_MemoryType.bool_,
        addr = 0xe0470b,
    },
    {
        name = "DEBUG_SKIP_ALL_START_MENUS",
        type = CE_MemoryType.bool_,
        addr = 0xe04bc8,
    },
    {
        name = "DEBUG_PLAYER_NEVER_DIES",
        type = CE_MemoryType.bool_,
        addr = 0xe04bba,
    },
    {
        name = "DEBUG_ALWAYS_GET_UNLOCKS",
        type = CE_MemoryType.bool_,
        addr = 0xe07034,
    },
    {
        name = "DEBUG_PROFILE_ALLOCATOR",
        type = CE_MemoryType.bool_,
        addr = 0xe04bb9,
    },
    {
        name = "DEBUG_STREAMING_INTEGRATION_DEV_MODE",
        type = CE_MemoryType.bool_,
        addr = 0xe04728,
    },
    {
        name = "DEBUG_UI_ALL_THE_CARDS_WIDTH",
        type = CE_MemoryType.int_,
        addr = 0xd52698,
    },
    {
        name = "DEBUG_UI_ALL_THE_CARDS_HEIGHT",
        type = CE_MemoryType.int_,
        addr = 0xd5321c,
    },
    {
        name = "DEBUG_UI_ALL_THE_CARDS_DISPLAY_EXTRA_INFO",
        type = CE_MemoryType.bool_,
        addr = 0xd5301a,
    },
    {
        name = "DEBUG_PERSISTENT_FLAGS_DISABLED",
        type = CE_MemoryType.bool_,
        addr = 0xe04bbb,
    },
    {
        name = "DEBUG_LOG_LEVEL",
        type = CE_MemoryType.int_,
        addr = 0xd52518,
    },
    {
        name = "DEBUG_LOG_STD_COUT",
        type = CE_MemoryType.bool_,
        addr = 0xd52061,
    },
    {
        name = "DEBUG_LOG_SOLID_BACKGROUND",
        type = CE_MemoryType.int_,
        addr = 0xd53000,
    },
    {
        name = "DEBUG_LOG_TODO_ERRORS",
        type = CE_MemoryType.bool_,
        addr = 0xd52674,
    },
    {
        name = "DEBUG_LOG_INSTANT_FLUSH",
        type = CE_MemoryType.bool_,
        addr = 0xe04fe0,
    },
    {
        name = "DEBUG_LOG_NEVER_VISIBLE",
        type = CE_MemoryType.bool_,
        addr = 0xe06fcc,
    },
    {
        name = "DEBUG_ALWAYS_RANDOM_SEED",
        type = CE_MemoryType.bool_,
        addr = 0xe04b3a,
    },
    {
        name = "DEBUG_ALWAYS_RANDOM_START_POS",
        type = CE_MemoryType.bool_,
        addr = 0xe06fc6,
    },
    {
        name = "DEBUG_LUA",
        type = CE_MemoryType.bool_,
        addr = 0xe051d7,
    },
    {
        name = "DEBUG_LUA_REPORT_SLOW_SCRIPTS",
        type = CE_MemoryType.bool_,
        addr = 0xe059eb,
    },
    {
        name = "DEBUG_LUA_REPORT_PRINT_FILES",
        type = CE_MemoryType.bool_,
        addr = 0xe0470a,
    },
    {
        name = "DEBUG_LUA_LOG_BIOME_SPAWN_SCRIPTS",
        type = CE_MemoryType.bool_,
        addr = 0xe0702f,
    },
    {
        name = "DEBUG_LUA_REPORT_BIOME_SPAWN_ERRORS",
        type = CE_MemoryType.bool_,
        addr = 0xd524c2,
    },
    {
        name = "DEBUG_LUA_DONT_REPEAT_ERRORS",
        type = CE_MemoryType.bool_,
        addr = 0xd52682,
    },
    {
        name = "DEBUG_GAME_LOG_SHOW_DRAWN_ACTIONS",
        type = CE_MemoryType.bool_,
        addr = 0xe04bc7,
    },
    {
        name = "DEBUG_LOG_STREAMING_STATS",
        type = CE_MemoryType.bool_,
        addr = 0xd53019,
    },
    {
        name = "DEBUG_LOG_LIFETIME_COMPONENT_DANGLING_PARENTS",
        type = CE_MemoryType.bool_,
        addr = 0xe051b8,
    },
    {
        name = "DEBUG_OLLI_CONFIG",
        type = CE_MemoryType.bool_,
        addr = 0xe04b39,
    },
    {
        name = "DEBUG_GENERATE_BIG_WANG_MAP",
        type = CE_MemoryType.bool_,
        addr = 0xe04b89,
    },
    {
        name = "DEBUG_CRASH_IF_OLD_VERSION",
        type = CE_MemoryType.bool_,
        addr = 0xd524fb,
    },
    {
        name = "DEBUG_RESTART_GAME_IF_OLD_VERSION",
        type = CE_MemoryType.bool_,
        addr = 0xe0702d,
    },
    {
        name = "DEBUG_CAMERABOUND_DISPLAY_ENTITIES",
        type = CE_MemoryType.bool_,
        addr = 0xe04bc4,
    },
    {
        name = "DEBUG_PROFILER_CAPTURE_OLLI_STYLE",
        type = CE_MemoryType.bool_,
        addr = 0xd52568,
    },
    {
        name = "DEBUG_PROFILER_CAPTURE_PETRI_STYLE",
        type = CE_MemoryType.bool_,
        addr = 0xe07011,
    },
    {
        name = "DEBUG_PAUSE_BOX2D",
        type = CE_MemoryType.bool_,
        addr = 0xe07035,
    },
    {
        name = "DEBUG_PAUSE_GRID_UPDATE",
        type = CE_MemoryType.bool_,
        addr = 0xe0472a,
    },
    {
        name = "DEBUG_PAUSE_SIMULATION",
        type = CE_MemoryType.bool_,
        addr = 0xe04bcb,
    },
    {
        name = "DEBUG_SCREENSHOTTER_ENABLED",
        type = CE_MemoryType.bool_,
        addr = 0xd5301b,
    },
    {
        name = "DEBUG_SCREENSHOTTER_SAVE_PPNG",
        type = CE_MemoryType.bool_,
        addr = 0xd524f9,
    },
    {
        name = "DEBUG_SCREENSHOTTER_FFMPEG_PATH",
        type = CE_MemoryType.std_string,
        addr = 0xd533e8,
    },
    {
        name = "DEBUG_PETRI_TAKE_RANDOM_SHADERSHOT",
        type = CE_MemoryType.bool_,
        addr = 0xe04ba8,
    },
    {
        name = "DEBUG_THREADED_WORLD_CREATION",
        type = CE_MemoryType.bool_,
        addr = 0xd525eb,
    },
    {
        name = "DEBUG_PETRI_START",
        type = CE_MemoryType.bool_,
        addr = 0xe04bd6,
    },
    {
        name = "DEBUG_ATTRACT_MODE",
        type = CE_MemoryType.bool_,
        addr = 0xe07013,
    },
    {
        name = "DEBUG_PREV_OPENED_ENTITY",
        type = CE_MemoryType.std_string,
        addr = 0xd54a68,
    },
    {
        name = "DEBUG_CTRL_O_USES_PREV_ENTITY_ALWAYS",
        type = CE_MemoryType.bool_,
        addr = 0xe051d5,
    },
    {
        name = "DEBUG_WANG",
        type = CE_MemoryType.bool_,
        addr = 0xe06fe4,
    },
    {
        name = "DEBUG_WANG_PATH",
        type = CE_MemoryType.bool_,
        addr = 0xe059ea,
    },
    {
        name = "DEBUG_FULL_WANG_MAPS",
        type = CE_MemoryType.bool_,
        addr = 0xe07010,
    },
    {
        name = "DEBUG_MATERIAL_AREA_CHECKER",
        type = CE_MemoryType.bool_,
        addr = 0xe06fcd,
    },
    {
        name = "DEBUG_COLLISION_TRIGGERS",
        type = CE_MemoryType.bool_,
        addr = 0xe04709,
    },
    {
        name = "DEBUG_SINGLE_THREADED_LOADING",
        type = CE_MemoryType.bool_,
        addr = 0xe05029,
    },
    {
        name = "DEBUG_TEXT_ENABLE_WORK_MODE",
        type = CE_MemoryType.bool_,
        addr = 0xe04baa,
    },
    {
        name = "DEBUG_TEXT_WRITE_MISSING_TRANSLATIONS",
        type = CE_MemoryType.bool_,
        addr = 0xe059da,
    },
    {
        name = "DEBUG_HOTLOAD_MATERIAL_EDGES",
        type = CE_MemoryType.bool_,
        addr = 0xe06fc5,
    },
    {
        name = "DEBUG_IMGUI_HOT_LOAD_ENABLED",
        type = CE_MemoryType.bool_,
        addr = 0xd53164,
    },
    {
        name = "DEBUG_DISPLAY_INTERNAL_ID_IN_PROGRESS_MENU",
        type = CE_MemoryType.bool_,
        addr = 0xd5250b,
    },
    {
        name = "_DEBUG_DONT_LOAD_OTHER_MAGIC_NUMBERS",
        type = CE_MemoryType.bool_,
        addr = 0xe07037,
    },
    {
        name = "_DEBUG_DONT_SAVE_MAGIC_NUMBERS",
        type = CE_MemoryType.bool_,
        addr = 0xe07036,
    },
    {
        name = "DESIGN_DAILY_RANDOM_STARTING_ITEMS",
        type = CE_MemoryType.bool_,
        addr = 0xd53167,
    },
    {
        name = "DESIGN_NEW_GAME_PLUS_HP_SCALE_MIN",
        type = CE_MemoryType.float_,
        addr = 0xd525a4,
    },
    {
        name = "DESIGN_NEW_GAME_PLUS_HP_SCALE_MAX",
        type = CE_MemoryType.float_,
        addr = 0xd526fc,
    },
    {
        name = "DESIGN_NEW_GAME_PLUS_ATTACK_SPEED",
        type = CE_MemoryType.float_,
        addr = 0xd52788,
    },
    {
        name = "DESIGN_PLAYER_START_RAYCAST_COARSE_TO_GROUND",
        type = CE_MemoryType.bool_,
        addr = 0xe06fe5,
    },
    {
        name = "DESIGN_PLAYER_START_TELEPORT_TO_GROUND",
        type = CE_MemoryType.bool_,
        addr = 0xd53234,
    },
    {
        name = "DESIGN_PLAYER_ALWAYS_TELEPORT_TO_GROUND",
        type = CE_MemoryType.bool_,
        addr = 0xe04bca,
    },
    {
        name = "DESIGN_PLAYER_START_POS_X",
        type = CE_MemoryType.float_,
        addr = 0xd52708,
    },
    {
        name = "DESIGN_PLAYER_START_POS_Y",
        type = CE_MemoryType.float_,
        addr = 0xd532ec,
    },
    {
        name = "DESIGN_RANDOM_STARTING_ITEMS",
        type = CE_MemoryType.bool_,
        addr = 0xe04bd4,
    },
    {
        name = "DESIGN_POLYMORPH_PLAYER_POLYMORPH_ENABLED",
        type = CE_MemoryType.bool_,
        addr = 0xd53166,
    },
    {
        name = "DESIGN_POLYMORPH_CONTROLS_ENABLED",
        type = CE_MemoryType.bool_,
        addr = 0xd53174,
    },
    {
        name = "DESIGN_PLAYER_PICKUP_ENABLED",
        type = CE_MemoryType.bool_,
        addr = 0xe07012,
    },
    {
        name = "DESIGN_CARDS_MUST_BE_IDENTIFIED",
        type = CE_MemoryType.bool_,
        addr = 0xd53175,
    },
    {
        name = "DESIGN_WAND_SLOTS_ARE_CONSUMED",
        type = CE_MemoryType.bool_,
        addr = 0xd53237,
    },
    {
        name = "DESIGN_ITEMS_CAN_BE_EATEN",
        type = CE_MemoryType.bool_,
        addr = 0xd52683,
    },
    {
        name = "DESIGN_ITEMCHEST_DROPS_ACTIONS",
        type = CE_MemoryType.bool_,
        addr = 0xd525a1,
    },
    {
        name = "DESIGN_ENEMY_HEALTH_DROPS",
        type = CE_MemoryType.bool_,
        addr = 0xd53236,
    },
    {
        name = "DESIGN_ENEMY_2X_MONEY_DROPS",
        type = CE_MemoryType.bool_,
        addr = 0xd525a3,
    },
    {
        name = "DESIGN_FIRE_DAMAGE_BASED_ON_MAX_HP",
        type = CE_MemoryType.bool_,
        addr = 0xd5256b,
    },
    {
        name = "DESIGN_AGGRO_INDICATOR",
        type = CE_MemoryType.bool_,
        addr = 0xd52675,
    },
    {
        name = "DESIGN_CARD_SYMBOL_UNLOCKS",
        type = CE_MemoryType.bool_,
        addr = 0xd53176,
    },
    {
        name = "DESIGN_BLOOD_RESTORES_HP",
        type = CE_MemoryType.bool_,
        addr = 0xe07040,
    },
    {
        name = "DESIGN_MATERIAL_INGESTION_STATUS_FX",
        type = CE_MemoryType.bool_,
        addr = 0xe06fe7,
    },
    {
        name = "DESIGN_RANDOMIZE_TEMPLE_CONTENTS",
        type = CE_MemoryType.bool_,
        addr = 0xe04b88,
    },
    {
        name = "DESIGN_TEMPLE_CHECK_FOR_LEAKS",
        type = CE_MemoryType.bool_,
        addr = 0xd524c3,
    },
    {
        name = "DESIGN_PLAYER_PHYSICS_KILLS_DONT_TRICK_KILL",
        type = CE_MemoryType.bool_,
        addr = 0xe04708,
    },
    {
        name = "DESIGN_DAY_CYCLE_SPEED",
        type = CE_MemoryType.float_,
        addr = 0xd52560,
    },
    {
        name = "DESIGN_SPELL_VISUALIZER",
        type = CE_MemoryType.bool_,
        addr = 0xe059d9,
    },
    {
        name = "DESIGN_RELOAD_ALL_THE_TIME",
        type = CE_MemoryType.bool_,
        addr = 0xd53018,
    },
    {
        name = "DESIGN_TELEKINESIS_GLITCH_FOR_TABLETS",
        type = CE_MemoryType.bool_,
        addr = 0xd52569,
    },
    {
        name = "DESIGN_TELEKINESIS_GLITCH_FOR_ITEM_PHYSICS",
        type = CE_MemoryType.bool_,
        addr = 0xe059db,
    },
    {
        name = "DESIGN_ALLOW_FULL_INVENTORY_SPELLS_DRAG",
        type = CE_MemoryType.bool_,
        addr = 0xd52777,
    },
    {
        name = "DESIGN_ALLOW_INVENTORY_CLOSING_AND_DRAGGING_GLITCH",
        type = CE_MemoryType.bool_,
        addr = 0xe059e8,
    },
    {
        name = "GLITCH_ALLOW_5TH_WAND_CARRY",
        type = CE_MemoryType.bool_,
        addr = 0xe04b8a,
    },
})
table_extend(developer_items, {
    {
        name = "GLITCH_ALLOW_ALT_TAB_SILLINESS",
        type = CE_MemoryType.bool_,
        addr = 0xe04bd7,
    },
    {
        name = "GLITCH_ALLOW_STAIN_DUPLICATION_GLITCH",
        type = CE_MemoryType.bool_,
        addr = 0xe04fe3,
    },
    {
        name = "GLITCH_ALLOW_VOMIT_BASED_STATUS_EFFECT_GLITCH",
        type = CE_MemoryType.bool_,
        addr = 0xe0500f,
    },
    {
        name = "BUGFIX_NEVER_DEFAULT_SERIALIZE_PLAYER",
        type = CE_MemoryType.bool_,
        addr = 0xd52063,
    },
})

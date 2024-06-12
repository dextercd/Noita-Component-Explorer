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
        addr = 0x0115114c,
    },
    {
        name = "DEBUG_SHOW_MOUSE_MATERIAL",
        type = CE_MemoryType.bool_,
        addr = 0x01202b0e,
    },
    {
        name = "PLAYER_KICK_FORCE",
        type = CE_MemoryType.float_,
        addr = 0x01151008,
    },
    {
        name = "PLAYER_KICK_VERLET_RADIUS",
        type = CE_MemoryType.float_,
        addr = 0x01150528,
    },
    {
        name = "PLAYER_KICK_VERLET_FORCE",
        type = CE_MemoryType.float_,
        addr = 0x01150538,
    },
    {
        name = "PLAYER_KICK_FRAMES_IGNORE_COLLISION",
        type = CE_MemoryType.int_,
        addr = 0x01151174,
    },
    {
        name = "INVENTORY_GUI_ALWAYS_VISIBLE",
        type = CE_MemoryType.bool_,
        addr = 0x01150059,
    },
    {
        name = "CAMERA_IS_FREE",
        type = CE_MemoryType.bool_,
        addr = 0x01202f6f,
    },
    {
        name = "REPORT_DAMAGE_TYPE",
        type = CE_MemoryType.bool_,
        addr = 0x01151268,
    },
    {
        name = "REPORT_DAMAGE_SCALE",
        type = CE_MemoryType.float_,
        addr = 0x0115120c,
    },
    {
        name = "REPORT_DAMAGE_BLOCK_MESSAGE_INTERVAL_FRAMES",
        type = CE_MemoryType.int_,
        addr = 0x011511c8,
    },
    {
        name = "GAME_LOG_ENABLED",
        type = CE_MemoryType.bool_,
        addr = 0x0115066d,
    },
    {
        name = "RANDOMIZE_LARGE_EXPLOSION_RAYS",
        type = CE_MemoryType.bool_,
        addr = 0x01150561,
    },
    {
        name = "EXPLOSION_FACTORY_FALLING_DIRT_FX_PROBABILITY",
        type = CE_MemoryType.int_,
        addr = 0x01204fa8,
    },
    {
        name = "EXPLOSION_FACTORY_STAIN_PERCENTAGE",
        type = CE_MemoryType.float_,
        addr = 0x011512dc,
    },
    {
        name = "PHYSICS_JOINT_MAX_FORCE_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0x01150678,
    },
    {
        name = "PHYSICS_RAGDOLL_JOINT_MAX_FORCE_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0x01151254,
    },
    {
        name = "PHYSICS_RAGDOLL_JOINT_MIN_BREAK_FORCE",
        type = CE_MemoryType.float_,
        addr = 0x011511f4,
    },
    {
        name = "PHYSICS_RAGDOLL_JOINT_STIFFNESS",
        type = CE_MemoryType.float_,
        addr = 0x01150634,
    },
    {
        name = "PHYSICS_RAGDOLL_VERY_STIFF_JOINT_STIFFNESS",
        type = CE_MemoryType.float_,
        addr = 0x01151028,
    },
    {
        name = "PHYSICS_FIX_SHELF_BUG",
        type = CE_MemoryType.bool_,
        addr = 0x01202b26,
    },
    {
        name = "GUI_HP_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0x011511bc,
    },
    {
        name = "THROW_UI_TIMESTEP_COEFF",
        type = CE_MemoryType.float_,
        addr = 0x01151200,
    },
    {
        name = "VERLET_STAIN_DROP_CHANCE_DIV",
        type = CE_MemoryType.int_,
        addr = 0x01150774,
    },
    {
        name = "ITEM_SWITCH_ITEM_TWEEN_TIME_FRAMES",
        type = CE_MemoryType.float_,
        addr = 0x0115054c,
    },
    {
        name = "APPARITION_MIN_BONES_REQUIRED",
        type = CE_MemoryType.int_,
        addr = 0x01151250,
    },
    {
        name = "TELEPORT_ATTACK_COOLDOWN_FRAMES",
        type = CE_MemoryType.int_,
        addr = 0x01151248,
    },
    {
        name = "GAMEPLAY_LIVES_ENABLED",
        type = CE_MemoryType.bool_,
        addr = 0x0115005b,
    },
    {
        name = "GAMEEFFECT_MOVEMENT_SLOWER_SPEED_MULTIPLIER_MIN",
        type = CE_MemoryType.float_,
        addr = 0x01150474,
    },
    {
        name = "GAMEEFFECT_MOVEMENT_SLOWER_SPEED_MULTIPLIER_MAX",
        type = CE_MemoryType.float_,
        addr = 0x0115076c,
    },
    {
        name = "GAMEEFFECT_MOVEMENT_FASTER_SPEED_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0x0115100c,
    },
    {
        name = "GAMEEFFECT_MOVEMENT_FASTER_2X_SPEED_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0x011504d4,
    },
    {
        name = "GAMEEFFECT_CRITICAL_HIT_BOOST_CRIT_EXTRA_CHANCE",
        type = CE_MemoryType.int_,
        addr = 0x01150770,
    },
    {
        name = "GAMEEFFECT_STAINS_DROP_FASTER_DROP_CHANCE_MULTIPLIER",
        type = CE_MemoryType.int_,
        addr = 0x0115112c,
    },
    {
        name = "GAMEEFFECT_DAMAGE_MULTIPLIER_COEFF",
        type = CE_MemoryType.float_,
        addr = 0x011505ac,
    },
    {
        name = "GAMEEFFECT_INVISIBILITY_SHOT_COOLDOWN_FRAMES",
        type = CE_MemoryType.int_,
        addr = 0x01151160,
    },
    {
        name = "GAMEEFFECT_TELEPORTITIS_COOLDOWN_FRAMES",
        type = CE_MemoryType.int_,
        addr = 0x01151014,
    },
    {
        name = "GAMEEFFECT_TELEPORTITIS_DAMAGE_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0x01151218,
    },
    {
        name = "GAMEEFFECT_ELECROCUTION_RESISTANCE_DURATION_FRAMES",
        type = CE_MemoryType.int_,
        addr = 0x0115125c,
    },
    {
        name = "GAMEEFFECT_FIRE_MOVEMENT_SPEED_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0x011505b8,
    },
    {
        name = "GAMEEFFECT_MANA_REGENERATION_SPEED_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0x011506dc,
    },
    {
        name = "DAMAGE_CRITICAL_HIT_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0x01150690,
    },
    {
        name = "GAMEEFFECT_GLOBAL_GORE_GORE_MULTIPLIER",
        type = CE_MemoryType.int_,
        addr = 0x01150674,
    },
    {
        name = "GAMEEFFECT_EXTRA_MONEY_TRICK_KILL_MULTIPLIER",
        type = CE_MemoryType.int_,
        addr = 0x01151240,
    },
    {
        name = "GAMEFFECT_WEAKNESS_DAMAGE_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0x01151158,
    },
    {
        name = "GAME_OVER_DAMAGE_FLASH_FADE_SPEED_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0x01150660,
    },
    {
        name = "INGESTION_AMOUNT_PER_CELL_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0x01150588,
    },
    {
        name = "INGESTION_SATIATION_PER_CELL",
        type = CE_MemoryType.uint32_t,
        addr = 0x011510e4,
    },
    {
        name = "INGESTION_OVERINGESTION_MSG_PERIOD",
        type = CE_MemoryType.uint32_t,
        addr = 0x011512d8,
    },
    {
        name = "INGESTION_LIMIT_SLOW_MOVEMENT",
        type = CE_MemoryType.float_,
        addr = 0x011504f4,
    },
    {
        name = "INGESTION_LIMIT_DAMAGE",
        type = CE_MemoryType.float_,
        addr = 0x01151168,
    },
    {
        name = "INGESTION_LIMIT_EXPLODING",
        type = CE_MemoryType.float_,
        addr = 0x01151148,
    },
    {
        name = "INGESTION_LIMIT_EXPLOSION",
        type = CE_MemoryType.float_,
        addr = 0x011506e8,
    },
    {
        name = "GAMEPLAY_CHARACTER_LIQUID_FORCES_ENABLED",
        type = CE_MemoryType.bool_,
        addr = 0x01204f96,
    },
    {
        name = "PLAYER_FAST_MOVEMENT_PARTICLES_ALPHA",
        type = CE_MemoryType.float_,
        addr = 0x01150768,
    },
    {
        name = "PLAYER_FAST_MOVEMENT_PARTICLES_ALPHA_CHANGE_SPD",
        type = CE_MemoryType.float_,
        addr = 0x01150704,
    },
    {
        name = "PLAYER_FAST_MOVEMENT_EXPLOSION_TIME_MOVED_FAST_MIN",
        type = CE_MemoryType.int_,
        addr = 0x01151294,
    },
    {
        name = "PLAYER_FAST_MOVEMENT_EXPLOSION_TIME_MOVED_FAST_MAX",
        type = CE_MemoryType.int_,
        addr = 0x01150668,
    },
    {
        name = "PLAYER_FAST_MOVEMENT_EXPLOSION_COOLDOWN",
        type = CE_MemoryType.int_,
        addr = 0x011511c4,
    },
    {
        name = "PLAYER_FAST_MOVEMENT_EXPLOSION_GROUND_RAY_LENGTH",
        type = CE_MemoryType.float_,
        addr = 0x01151230,
    },
    {
        name = "PLAYER_FAST_MOVEMENT_EXPLOSION_GROUND_PENETRATE_LENGTH",
        type = CE_MemoryType.float_,
        addr = 0x011504bc,
    },
    {
        name = "COOP_RESPAWN_TIMER_FRAMES",
        type = CE_MemoryType.int_,
        addr = 0x0115047c,
    },
    {
        name = "DROP_LEVEL_1",
        type = CE_MemoryType.float_,
        addr = 0x011504ec,
    },
    {
        name = "DROP_LEVEL_2",
        type = CE_MemoryType.float_,
        addr = 0x011504b8,
    },
    {
        name = "DROP_LEVEL_3",
        type = CE_MemoryType.float_,
        addr = 0x0115057c,
    },
    {
        name = "DROP_LEVEL_4",
        type = CE_MemoryType.float_,
        addr = 0x0115052c,
    },
    {
        name = "DROP_LEVEL_5",
        type = CE_MemoryType.float_,
        addr = 0x011504c0,
    },
    {
        name = "DROP_LEVEL_6",
        type = CE_MemoryType.float_,
        addr = 0x01151178,
    },
    {
        name = "DROP_LEVEL_7",
        type = CE_MemoryType.float_,
        addr = 0x011511dc,
    },
    {
        name = "DROP_LEVEL_8",
        type = CE_MemoryType.float_,
        addr = 0x011504c4,
    },
    {
        name = "DROP_LEVEL_9",
        type = CE_MemoryType.float_,
        addr = 0x01151290,
    },
    {
        name = "BIOME_APPARITION_CHANCE",
        type = CE_MemoryType.int_,
        addr = 0x01150540,
    },
    {
        name = "BIOME_RANDOM_BLOCK_CHANCE",
        type = CE_MemoryType.float_,
        addr = 0x011510e0,
    },
    {
        name = "BIOME_USE_BIG_WANG",
        type = CE_MemoryType.bool_,
        addr = 0x0115066e,
    },
    {
        name = "BIOME_PATH_FIND_HEIGHT_LIMIT",
        type = CE_MemoryType.int_,
        addr = 0x01150470,
    },
    {
        name = "BIOME_PATH_FIND_WORLD_POS_MIN_X",
        type = CE_MemoryType.int_,
        addr = 0x011505d0,
    },
    {
        name = "BIOME_PATH_FIND_WORLD_POS_MAX_X",
        type = CE_MemoryType.int_,
        addr = 0x011510dc,
    },
    {
        name = "WORLD_SEED",
        type = CE_MemoryType.uint32_t,
        addr = 0x01204f64,
    },
    {
        name = "NUM_ORBS_TOTAL",
        type = CE_MemoryType.int_,
        addr = 0x0115053c,
    },
    {
        name = "CAMERA_MOUSE_INTERPOLATION_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x011505a4,
    },
    {
        name = "CAMERA_GAMEPAD_INTERPOLATION_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x011504fc,
    },
    {
        name = "CAMERA_GAMEPAD_MAX_DISTANCE",
        type = CE_MemoryType.float_,
        addr = 0x01151004,
    },
    {
        name = "CAMERA_POSITION_INTERPOLATION_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x01151150,
    },
    {
        name = "CAMERA_DISTANCE_INTERPOLATION_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x011505e8,
    },
    {
        name = "CAMERA_NO_MOVE_BUFFER_NEAR_PLAYER",
        type = CE_MemoryType.float_,
        addr = 0x01202f68,
    },
    {
        name = "CAMERA_NO_MOVE_BUFFER_NEAR_VIEWPORT_EDGE",
        type = CE_MemoryType.float_,
        addr = 0x011505b0,
    },
    {
        name = "CAMERA_RECOIL_ATTACK_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x011505a8,
    },
    {
        name = "CAMERA_RECOIL_RELEASE_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x0115126c,
    },
    {
        name = "CAMERA_RECOIL_AMOUNT",
        type = CE_MemoryType.float_,
        addr = 0x01150780,
    },
    {
        name = "CAMERA_ERROR_SMOOTHING_THRESHOLD_X",
        type = CE_MemoryType.float_,
        addr = 0x01151264,
    },
    {
        name = "CAMERA_ERROR_SMOOTHING_THRESHOLD_Y_MAX",
        type = CE_MemoryType.float_,
        addr = 0x011512f8,
    },
    {
        name = "CAMERA_ERROR_SMOOTHING_THRESHOLD_Y_MIN",
        type = CE_MemoryType.float_,
        addr = 0x01150530,
    },
    {
        name = "CAMERA_ERROR_CORRECTION_SPD_UP_X",
        type = CE_MemoryType.float_,
        addr = 0x0115127c,
    },
    {
        name = "CAMERA_ERROR_CORRECTION_SPD_UP_Y",
        type = CE_MemoryType.float_,
        addr = 0x011511f0,
    },
    {
        name = "CAMERA_ERROR_CORRECTION_SPD_DOWN_X",
        type = CE_MemoryType.float_,
        addr = 0x011504d0,
    },
    {
        name = "CAMERA_ERROR_CORRECTION_SPD_DOWN_Y",
        type = CE_MemoryType.float_,
        addr = 0x01151208,
    },
    {
        name = "CAMERA_ERROR_CORRECTION_AMOUNT_X",
        type = CE_MemoryType.float_,
        addr = 0x01151128,
    },
    {
        name = "CAMERA_ERROR_CORRECTION_AMOUNT_Y",
        type = CE_MemoryType.float_,
        addr = 0x01150524,
    },
    {
        name = "CAMERA_FAST_SWITCH_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x01151024,
    },
    {
        name = "MULTIPLAYER_CAMERA_SMOOTHING",
        type = CE_MemoryType.float_,
        addr = 0x01150518,
    },
    {
        name = "MULTIPLAYER_CAMERA_MAX_SMOOTH_DISTANCE",
        type = CE_MemoryType.float_,
        addr = 0x0115102c,
    },
    {
        name = "CAMERA_IS_UI_OPEN",
        type = CE_MemoryType.bool_,
        addr = 0x01204f94,
    },
    {
        name = "PLAYER_USE_NEW_JETPACK",
        type = CE_MemoryType.bool_,
        addr = 0x01202b58,
    },
    {
        name = "DOUBLE_CLICK_MAX_SPAN_SECONDS",
        type = CE_MemoryType.float_,
        addr = 0x011504dc,
    },
    {
        name = "ESC_QUITS_GAME",
        type = CE_MemoryType.bool_,
        addr = 0x01202f99,
    },
    {
        name = "GAMEPAD_AIMING_VECTOR_SMOOTHING_COEFF",
        type = CE_MemoryType.float_,
        addr = 0x01151284,
    },
    {
        name = "CONTROLS_AIMING_VECTOR_FULL_LENGTH_PIXELS",
        type = CE_MemoryType.float_,
        addr = 0x011504e4,
    },
    {
        name = "GAMEPAD_SHOT_VIBRATION_FORCE_MIN",
        type = CE_MemoryType.float_,
        addr = 0x01151010,
    },
    {
        name = "GAMEPAD_SHOT_VIBRATION_FORCE_COEFF",
        type = CE_MemoryType.float_,
        addr = 0x011512e0,
    },
    {
        name = "GAMEPAD_SHOT_VIBRATION_TIME_COEFF",
        type = CE_MemoryType.float_,
        addr = 0x01150680,
    },
    {
        name = "GAMEPAD_ANALOG_FLYING_LOW",
        type = CE_MemoryType.float_,
        addr = 0x0115056c,
    },
    {
        name = "GAMEPAD_ANALOG_FLYING_HIGH",
        type = CE_MemoryType.float_,
        addr = 0x01150594,
    },
    {
        name = "RAGDOLL_FX_EXPLOSION_ROTATION",
        type = CE_MemoryType.float_,
        addr = 0x01151130,
    },
    {
        name = "RAGDOLL_BLOOD_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0x01150fec,
    },
    {
        name = "RAGDOLL_FIRE_DEATH_IGNITE_EVERY_N_PIXEL",
        type = CE_MemoryType.int_,
        addr = 0x01150ff4,
    },
    {
        name = "RAGDOLL_IMPULSE_RANDOMNESS",
        type = CE_MemoryType.float_,
        addr = 0x01150548,
    },
    {
        name = "RAGDOLL_OWN_VELOCITY_IMPULSE_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0x01150fdc,
    },
    {
        name = "RAGDOLL_CRITICAL_HIT_FORCE_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0x0115116c,
    },
    {
        name = "DAMAGE_BLOOD_AMOUNT_MIN",
        type = CE_MemoryType.int_,
        addr = 0x0115005c,
    },
    {
        name = "DAMAGE_BLOOD_AMOUNT_MAX",
        type = CE_MemoryType.int_,
        addr = 0x01150544,
    },
    {
        name = "DAMAGE_FIRE_DAMAGE_MAX_HP_MIN_BOUND",
        type = CE_MemoryType.float_,
        addr = 0x01150508,
    },
    {
        name = "DAMAGE_BLOOD_SPRAY_CHANCE",
        type = CE_MemoryType.int_,
        addr = 0x0115101c,
    },
    {
        name = "EXPLOSION_FACTORY_GORE_FX_PROBABLITY",
        type = CE_MemoryType.int_,
        addr = 0x0115055c,
    },
    {
        name = "EXPLOSION_FACTORY_GORE_FX_HOLE_PROBABILITY",
        type = CE_MemoryType.int_,
        addr = 0x011504f8,
    },
    {
        name = "EXPLOSION_FACTORY_GORE_FX_BLOOD_STAIN_COLOR",
        type = CE_MemoryType.uint32_t,
        addr = 0x011505e0,
    },
    {
        name = "GRID_MAX_UPDATES_PER_FRAME",
        type = CE_MemoryType.int_,
        addr = 0x0115006c,
    },
    {
        name = "GRID_FLEXIBLE_MAX_UPDATES",
        type = CE_MemoryType.bool_,
        addr = 0x01202f6c,
    },
    {
        name = "GRID_MIN_UPDATES_PER_FRAME",
        type = CE_MemoryType.int_,
        addr = 0x011505c8,
    },
    {
        name = "CELLFACTORY_CELLDATA_MAX_COUNT",
        type = CE_MemoryType.int_,
        addr = 0x01150ffc,
    },
    {
        name = "PARTICLE_EMITTER_MAX_PARTICLES",
        type = CE_MemoryType.int_,
        addr = 0x01151000,
    },
    {
        name = "VIRTUAL_RESOLUTION_X",
        type = CE_MemoryType.int_,
        addr = 0x011510e8,
    },
    {
        name = "VIRTUAL_RESOLUTION_Y",
        type = CE_MemoryType.int_,
        addr = 0x01150550,
    },
    {
        name = "VIRTUAL_RESOLUTION_OFFSET_X",
        type = CE_MemoryType.float_,
        addr = 0x01150708,
    },
    {
        name = "VIRTUAL_RESOLUTION_OFFSET_Y",
        type = CE_MemoryType.float_,
        addr = 0x0115063c,
    },
    {
        name = "GRID_RENDER_BORDER",
        type = CE_MemoryType.int_,
        addr = 0x011512f0,
    },
    {
        name = "GRID_RENDER_TILE_SIZE",
        type = CE_MemoryType.int_,
        addr = 0x0115065c,
    },
    {
        name = "DRAW_PARALLAX_BACKGROUND",
        type = CE_MemoryType.bool_,
        addr = 0x0115115c,
    },
    {
        name = "DRAW_PARALLAX_BACKGROUND_BEFORE_DEPTH",
        type = CE_MemoryType.float_,
        addr = 0x01150574,
    },
    {
        name = "RENDER_PARALLAX_BACKGROUND_SHADER_GRADIENT",
        type = CE_MemoryType.bool_,
        addr = 0x01204f2a,
    },
    {
        name = "RENDER_SKYLIGHT_MAX_REDUCTION_AMOUNT",
        type = CE_MemoryType.float_,
        addr = 0x011511d8,
    },
    {
        name = "RENDER_SKYLIGHT_ABOVE_WEIGHT",
        type = CE_MemoryType.float_,
        addr = 0x011505bc,
    },
    {
        name = "RENDER_SKYLIGHT_SIDES_WEIGHT",
        type = CE_MemoryType.float_,
        addr = 0x01150638,
    },
    {
        name = "RENDER_SKYLIGHT_TOTAL_WEIGHT",
        type = CE_MemoryType.float_,
        addr = 0x01151170,
    },
    {
        name = "RENDER_FIRE_LO_TIME",
        type = CE_MemoryType.float_,
        addr = 0x01150670,
    },
    {
        name = "RENDER_FIRE_LO_SCALE",
        type = CE_MemoryType.float_,
        addr = 0x011505e4,
    },
    {
        name = "RENDER_FIRE_LO_FORCE",
        type = CE_MemoryType.float_,
        addr = 0x01150790,
    },
    {
        name = "RENDER_FIRE_HI_TIME",
        type = CE_MemoryType.float_,
        addr = 0x01150534,
    },
    {
        name = "RENDER_FIRE_HI_SCALE",
        type = CE_MemoryType.float_,
        addr = 0x01150554,
    },
    {
        name = "RENDER_FIRE_HI_FORCE",
        type = CE_MemoryType.float_,
        addr = 0x01202f60,
    },
    {
        name = "RENDER_FIRE_GRAVITY",
        type = CE_MemoryType.float_,
        addr = 0x011506ec,
    },
    {
        name = "RENDER_FIRE_LIFETIME_MIN",
        type = CE_MemoryType.int_,
        addr = 0x01151300,
    },
    {
        name = "RENDER_FIRE_LIFETIME_MAX",
        type = CE_MemoryType.int_,
        addr = 0x01150654,
    },
    {
        name = "RENDER_FIRE_GLOW_ALPHA",
        type = CE_MemoryType.float_,
        addr = 0x01150590,
    },
    {
        name = "RENDER_FIRE_SHARP_ALPHA",
        type = CE_MemoryType.float_,
        addr = 0x011512f4,
    },
    {
        name = "RENDER_POTION_PARTICLE_MAX_COLOR_COMPONENT",
        type = CE_MemoryType.float_,
        addr = 0x01151244,
    },
    {
        name = "RENDER_color_grading_LERP_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x01151144,
    },
    {
        name = "TELEPORT_FLASH_COLOR_R",
        type = CE_MemoryType.float_,
        addr = 0x01203958,
    },
    {
        name = "TELEPORT_FLASH_COLOR_G",
        type = CE_MemoryType.float_,
        addr = 0x01203964,
    },
    {
        name = "TELEPORT_FLASH_COLOR_B",
        type = CE_MemoryType.float_,
        addr = 0x012026ac,
    },
    {
        name = "AUDIO_GAMEEFFECT_FIRE_WEIGHT",
        type = CE_MemoryType.float_,
        addr = 0x01150658,
    },
    {
        name = "AUDIO_FIRE_WEIGHT",
        type = CE_MemoryType.float_,
        addr = 0x0115129c,
    },
    {
        name = "AUDIO_MAGICAL_MATERIAL_WEIGHT",
        type = CE_MemoryType.float_,
        addr = 0x0115058c,
    },
    {
        name = "AUDIO_GAME_START_FADE_FRAME",
        type = CE_MemoryType.float_,
        addr = 0x0115067c,
    },
    {
        name = "AUDIO_GAME_START_FADE_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x01150580,
    },
    {
        name = "AUDIO_MUSIC_VOLUME_DEFAULT",
        type = CE_MemoryType.float_,
        addr = 0x01150568,
    },
    {
        name = "AUDIO_MUSIC_QUIET_FADE_DOWN_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x011506bc,
    },
    {
        name = "AUDIO_MUSIC_NORMAL_FADE_DOWN_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x0115124c,
    },
    {
        name = "AUDIO_MUSIC_NORMAL_FADE_UP_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x011511fc,
    },
    {
        name = "AUDIO_MUSIC_ACTION_FADE_DOWN_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x01150688,
    },
    {
        name = "AUDIO_MUSIC_ACTION_FADE_UP_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x011511b8,
    },
    {
        name = "AUDIO_MUSIC_LOW_ENERGY_TRIGGER_COOLDOWN_SECONDS",
        type = CE_MemoryType.double_,
        addr = 0x011505f0,
    },
    {
        name = "AUDIO_MUSIC_FORCED_QUIETNESS_TRIGGERS_AFTER_SECONDS",
        type = CE_MemoryType.int_,
        addr = 0x011506e4,
    },
    {
        name = "AUDIO_MUSIC_FORCED_QUIETNESS_DURATION_SECONDS",
        type = CE_MemoryType.int_,
        addr = 0x011504e8,
    },
    {
        name = "AUDIO_COLLISION_SIZE_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0x0115062c,
    },
    {
        name = "AUDIO_COLLISION_SPEED_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0x01150684,
    },
    {
        name = "AUDIO_COLLISION_KICK_SIZE",
        type = CE_MemoryType.float_,
        addr = 0x01151210,
    },
    {
        name = "AUDIO_COLLISION_COOLDOWN_SECONDS",
        type = CE_MemoryType.float_,
        addr = 0x011505ec,
    },
    {
        name = "AUDIO_COLLISION_STATIC_WALL_INTENSITY",
        type = CE_MemoryType.float_,
        addr = 0x011511d4,
    },
    {
        name = "AUDIO_COLLISION_STATIC_WALL_SPEED_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0x01151204,
    },
    {
        name = "AUDIO_PHYSICS_BREAK_MASS_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0x0115113c,
    },
    {
        name = "AUDIO_CHARACTER_LIQUID_SPLASH_INTENSITY_MIN",
        type = CE_MemoryType.float_,
        addr = 0x01204f2c,
    },
    {
        name = "AUDIO_CHARACTER_LIQUID_SPLASH_INTENSITY_MAX",
        type = CE_MemoryType.float_,
        addr = 0x01151258,
    },
    {
        name = "AUDIO_CHARACTER_LIQUID_SPLASH_INTENSITY_SPEED_DIV",
        type = CE_MemoryType.float_,
        addr = 0x01151154,
    },
    {
        name = "AUDIO_EXPLOSION_NO_SOUND_BELOW_RADIUS",
        type = CE_MemoryType.float_,
        addr = 0x0115070c,
    },
    {
        name = "AUDIO_EXPLOSION_SMALL_SOUND_MAX_RADIUS",
        type = CE_MemoryType.float_,
        addr = 0x011512e8,
    },
    {
        name = "AUDIO_PICK_GOLD_SAND_MIN_AMOUNT_FOR_SOUND",
        type = CE_MemoryType.int_,
        addr = 0x011505d4,
    },
    {
        name = "AUDIO_PICK_GOLD_SAND_AMOUNT_ACCUMULATION_FRAMES",
        type = CE_MemoryType.int_,
        addr = 0x01150fe0,
    },
    {
        name = "AUDIO_AMBIENCE_ALTITUDE_SCALE",
        type = CE_MemoryType.float_,
        addr = 0x01150798,
    },
    {
        name = "AUDIO_PLAY_GAME_OVER_SOUND",
        type = CE_MemoryType.bool_,
        addr = 0x01150fe4,
    },
    {
        name = "AUDIO_FADE_MUSIC_ON_DEATH",
        type = CE_MemoryType.bool_,
        addr = 0x0115066f,
    },
    {
        name = "PATHFINDING_DISTANCE_FIELD_ENABLED",
        type = CE_MemoryType.bool_,
        addr = 0x01150514,
    },
    {
        name = "STREAMING_ENABLED",
        type = CE_MemoryType.bool_,
        addr = 0x011504cc,
    },
    {
        name = "STREAMING_FREQUENCY",
        type = CE_MemoryType.double_,
        addr = 0x011506f8,
    },
    {
        name = "STREAMING_CHUNK_TARGET",
        type = CE_MemoryType.int_,
        addr = 0x0115128c,
    },
    {
        name = "STREAMING_PERSISTENT_WORLD",
        type = CE_MemoryType.bool_,
        addr = 0x011506f4,
    },
    {
        name = "STREAMING_AUTOSAVE_PERIOD_SECONDS",
        type = CE_MemoryType.int_,
        addr = 0x011505dc,
    },
    {
        name = "INVENTORY_ICON_SIZE",
        type = CE_MemoryType.int_,
        addr = 0x01151270,
    },
    {
        name = "INVENTORY_STASH_X",
        type = CE_MemoryType.float_,
        addr = 0x01151228,
    },
    {
        name = "INVENTORY_STASH_Y",
        type = CE_MemoryType.float_,
        addr = 0x01150784,
    },
    {
        name = "INVENTORY_DEBUG_X",
        type = CE_MemoryType.float_,
        addr = 0x01151274,
    },
})

table_extend(developer_items, {
    {
        name = "INVENTORY_DEBUG_Y",
        type = CE_MemoryType.float_,
        addr = 0x0115123c,
    },
    {
        name = "UI_SNAP_TO_NEAREST_INTEGER_SCALE",
        type = CE_MemoryType.bool_,
        addr = 0x01150515,
    },
    {
        name = "UI_BARS_SCALE",
        type = CE_MemoryType.float_,
        addr = 0x011511cc,
    },
    {
        name = "UI_BARS_POS_X",
        type = CE_MemoryType.float_,
        addr = 0x01151020,
    },
    {
        name = "UI_BARS_POS_Y",
        type = CE_MemoryType.float_,
        addr = 0x011505c4,
    },
    {
        name = "UI_BARS2_OFFSET_X",
        type = CE_MemoryType.float_,
        addr = 0x01151260,
    },
    {
        name = "UI_PLAYER_FULL_STATS_POS_X",
        type = CE_MemoryType.float_,
        addr = 0x01150754,
    },
    {
        name = "UI_PLAYER_FULL_STATS_POS_Y",
        type = CE_MemoryType.float_,
        addr = 0x01151140,
    },
    {
        name = "UI_PLAYER_FULL_STATS_COLUMN2_OFFSET_X",
        type = CE_MemoryType.float_,
        addr = 0x01150510,
    },
    {
        name = "UI_PLAYER_FULL_STATS_COLUMN3_OFFSET_X",
        type = CE_MemoryType.float_,
        addr = 0x01151288,
    },
    {
        name = "UI_STAT_BAR_EXTRA_SPACING",
        type = CE_MemoryType.float_,
        addr = 0x01150478,
    },
    {
        name = "UI_STAT_BAR_ICON_OFFSET_Y",
        type = CE_MemoryType.float_,
        addr = 0x01202f80,
    },
    {
        name = "UI_STAT_BAR_TEXT_OFFSET_X",
        type = CE_MemoryType.float_,
        addr = 0x01150504,
    },
    {
        name = "UI_STAT_BAR_TEXT_OFFSET_Y",
        type = CE_MemoryType.float_,
        addr = 0x01202b1c,
    },
    {
        name = "UI_QUICKBAR_OFFSET_X",
        type = CE_MemoryType.float_,
        addr = 0x0120314c,
    },
    {
        name = "UI_QUICKBAR_OFFSET_Y",
        type = CE_MemoryType.float_,
        addr = 0x01204f48,
    },
    {
        name = "UI_INVENTORY_BACKGROUND_POSITION_X",
        type = CE_MemoryType.float_,
        addr = 0x01204f58,
    },
    {
        name = "UI_INVENTORY_BACKGROUND_POSITION_Y",
        type = CE_MemoryType.float_,
        addr = 0x01202abc,
    },
    {
        name = "UI_FULL_INVENTORY_OFFSET_X",
        type = CE_MemoryType.float_,
        addr = 0x01150584,
    },
    {
        name = "UI_IMPORTANT_MESSAGE_POS_Y",
        type = CE_MemoryType.int_,
        addr = 0x01150788,
    },
    {
        name = "UI_IMPORTANT_MESSAGE_TITLE_SCALE",
        type = CE_MemoryType.float_,
        addr = 0x01151234,
    },
    {
        name = "UI_LOW_HP_THRESHOLD",
        type = CE_MemoryType.float_,
        addr = 0x01150698,
    },
    {
        name = "UI_LOW_HP_WARNING_FLASH_FREQUENCY",
        type = CE_MemoryType.float_,
        addr = 0x0115069c,
    },
    {
        name = "UI_PIXEL_FONT_GAME_LOG",
        type = CE_MemoryType.bool_,
        addr = 0x011504f2,
    },
    {
        name = "UI_PAUSE_MENU_LAYOUT_TOP_EDGE_PERCENTAGE",
        type = CE_MemoryType.int_,
        addr = 0x011511e0,
    },
    {
        name = "UI_GAME_OVER_MENU_LAYOUT_TOP_EDGE_PERCENTAGE",
        type = CE_MemoryType.int_,
        addr = 0x011505c0,
    },
    {
        name = "UI_WOBBLE_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x011507d0,
    },
    {
        name = "UI_WOBBLE_AMOUNT_DEGREES",
        type = CE_MemoryType.float_,
        addr = 0x011512fc,
    },
    {
        name = "UI_GAMEOVER_SCREEN_BOX_FROM_TOP_PERCENT",
        type = CE_MemoryType.float_,
        addr = 0x011507a4,
    },
    {
        name = "UI_GAMEOVER_SCREEN_BOX_FROM_SIDE_PERCENT",
        type = CE_MemoryType.float_,
        addr = 0x01150628,
    },
    {
        name = "UI_GAMEOVER_SCREEN_BOX_FROM_BOTTOM_PERCENT",
        type = CE_MemoryType.float_,
        addr = 0x01150778,
    },
    {
        name = "UI_GAMEOVER_SCREEN_MUSIC_CUE_TIMER_FRAMES",
        type = CE_MemoryType.int_,
        addr = 0x011511f8,
    },
    {
        name = "UI_COOP_QUICK_INVENTORY_HEIGHT",
        type = CE_MemoryType.float_,
        addr = 0x01150578,
    },
    {
        name = "UI_COOP_STAT_BARS_HEIGHT",
        type = CE_MemoryType.float_,
        addr = 0x01150748,
    },
    {
        name = "UI_SCALE_IN_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x01151164,
    },
    {
        name = "UI_DAMAGE_INDICATOR_RANDOM_OFFSET",
        type = CE_MemoryType.float_,
        addr = 0x011504d8,
    },
    {
        name = "UI_ITEM_STAND_OVER_INFO_BOX_OFFSET_X",
        type = CE_MemoryType.float_,
        addr = 0x01150764,
    },
    {
        name = "UI_ITEM_STAND_OVER_INFO_BOX_OFFSET_Y",
        type = CE_MemoryType.float_,
        addr = 0x011505d8,
    },
    {
        name = "UI_MOUSE_WORLD_HOVER_TEXT_OFFSET_X",
        type = CE_MemoryType.float_,
        addr = 0x01150750,
    },
    {
        name = "UI_MOUSE_WORLD_HOVER_TEXT_OFFSET_Y",
        type = CE_MemoryType.float_,
        addr = 0x01151138,
    },
    {
        name = "UI_MAX_PERKS_VISIBLE",
        type = CE_MemoryType.int_,
        addr = 0x01150500,
    },
    {
        name = "UI_LOCALIZE_RECORD_TEXT",
        type = CE_MemoryType.bool_,
        addr = 0x01203157,
    },
    {
        name = "UI_DISPLAY_NUMBERS_WITH_KS_AND_MS",
        type = CE_MemoryType.bool_,
        addr = 0x0115059b,
    },
    {
        name = "UI_WAND_TAG_OVERWRITES_NAME",
        type = CE_MemoryType.bool_,
        addr = 0x011512ed,
    },
    {
        name = "UI_DISPLAY_POTION_CONTENT_PERCENTS",
        type = CE_MemoryType.bool_,
        addr = 0x01150630,
    },
    {
        name = "UI_POTION_CONTENTS_COMBINE_SAME_NAME_MATERIALS",
        type = CE_MemoryType.bool_,
        addr = 0x011504f1,
    },
    {
        name = "UI_HEALTHBAR_Y_SPACING",
        type = CE_MemoryType.float_,
        addr = 0x01150fd8,
    },
    {
        name = "MAIN_MENU_BG_OFFSET_X",
        type = CE_MemoryType.float_,
        addr = 0x011505cc,
    },
    {
        name = "MAIN_MENU_BG_OFFSET_Y",
        type = CE_MemoryType.float_,
        addr = 0x01151298,
    },
    {
        name = "MAIN_MENU_BG_OFFSET_Y_END",
        type = CE_MemoryType.float_,
        addr = 0x011510d8,
    },
    {
        name = "MAIN_MENU_BG_TWEEN_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x01151134,
    },
    {
        name = "USE_CUSTOM_THREADPOOL",
        type = CE_MemoryType.bool_,
        addr = 0x011511d2,
    },
    {
        name = "BOX2D_FREEZE_STUCK_BODIES",
        type = CE_MemoryType.bool_,
        addr = 0x0115126b,
    },
    {
        name = "BOX2D_THREAD_MAX_WAIT_IN_MS",
        type = CE_MemoryType.float_,
        addr = 0x01151280,
    },
    {
        name = "CREDITS_SCROLL_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x011506e0,
    },
    {
        name = "CREDITS_SCROLL_END_OFFSET_EXTRA",
        type = CE_MemoryType.float_,
        addr = 0x01150664,
    },
    {
        name = "CREDITS_SCROLL_SKIP_SPEED_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0x011507a0,
    },
    {
        name = "INTRO_WEATHER_FOG",
        type = CE_MemoryType.float_,
        addr = 0x0115117c,
    },
    {
        name = "INTRO_WEATHER_RAIN",
        type = CE_MemoryType.float_,
        addr = 0x011511ec,
    },
    {
        name = "SETTINGS_MIN_RESOLUTION_X",
        type = CE_MemoryType.int_,
        addr = 0x011504c8,
    },
    {
        name = "SETTINGS_MIN_RESOLUTION_Y",
        type = CE_MemoryType.int_,
        addr = 0x0115079c,
    },
    {
        name = "STEAM_CLOUD_SIZE_WARNING",
        type = CE_MemoryType.bool_,
        addr = 0x01204f93,
    },
    {
        name = "DEBUG_KEYS_ENABLED",
        type = CE_MemoryType.bool_,
        addr = 0x01150599,
    },
    {
        name = "DEBUG_EXTRA_SCREENSHOT_KEYS_ENABLED",
        type = CE_MemoryType.bool_,
        addr = 0x011504cf,
    },
    {
        name = "DEBUG_USE_PRELOAD",
        type = CE_MemoryType.bool_,
        addr = 0x01150631,
    },
    {
        name = "DEBUG_USE_DEBUG_PRELOAD",
        type = CE_MemoryType.bool_,
        addr = 0x01202f7b,
    },
    {
        name = "DEBUG_TREES",
        type = CE_MemoryType.bool_,
        addr = 0x01204f56,
    },
    {
        name = "DEBUG_PIXEL_SCENES",
        type = CE_MemoryType.bool_,
        addr = 0x01203155,
    },
    {
        name = "DEBUG_TELEPORT",
        type = CE_MemoryType.bool_,
        addr = 0x01202f6d,
    },
    {
        name = "DEBUG_SI_TYPE",
        type = CE_MemoryType.int_,
        addr = 0x01203150,
    },
    {
        name = "DEBUG_AUDIO_DEV_MODE",
        type = CE_MemoryType.bool_,
        addr = 0x01202b0a,
    },
    {
        name = "DEBUG_AUDIO_MUTE",
        type = CE_MemoryType.bool_,
        addr = 0x01202b0d,
    },
    {
        name = "DEBUG_AUDIO_MUSIC_MUTE",
        type = CE_MemoryType.bool_,
        addr = 0x01202b24,
    },
    {
        name = "DEBUG_AUDIO_VOLUME",
        type = CE_MemoryType.float_,
        addr = 0x01150ff0,
    },
    {
        name = "DEBUG_TEST_SYMBOL_CLASSIFIER",
        type = CE_MemoryType.bool_,
        addr = 0x01203968,
    },
    {
        name = "DEBUG_STREAMING_DISABLE_SAVING",
        type = CE_MemoryType.bool_,
        addr = 0x01204f28,
    },
    {
        name = "DEBUG_DRAW_ANIMAL_AI_STATE",
        type = CE_MemoryType.bool_,
        addr = 0x01202fa9,
    },
    {
        name = "DEBUG_PRINT_COMPONENT_UPDATOR_ORDER",
        type = CE_MemoryType.bool_,
        addr = 0x01203147,
    },
    {
        name = "DEBUG_SKYLIGHT_NO_SIMD",
        type = CE_MemoryType.bool_,
        addr = 0x01202b44,
    },
    {
        name = "DEBUG_DISABLE_MOUSE_SCROLL_WHEEL",
        type = CE_MemoryType.bool_,
        addr = 0x01204f95,
    },
    {
        name = "DEBUG_NO_SAVEGAME_CLEAR_ON_GAME_OVER",
        type = CE_MemoryType.bool_,
        addr = 0x01204fc1,
    },
    {
        name = "DEBUG_CAMERA_SHAKE_OFFSET",
        type = CE_MemoryType.float_,
        addr = 0x01203148,
    },
    {
        name = "DEBUG_FREE_CAMERA_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x01150694,
    },
    {
        name = "DEBUG_DISABLE_POSTFX_DITHERING",
        type = CE_MemoryType.bool_,
        addr = 0x01204fb1,
    },
    {
        name = "DEBUG_GIF_WIDTH",
        type = CE_MemoryType.int_,
        addr = 0x01150570,
    },
    {
        name = "DEBUG_GIF_HEIGHT",
        type = CE_MemoryType.int_,
        addr = 0x0115051c,
    },
    {
        name = "DEBUG_GIF_RECORD_60FPS",
        type = CE_MemoryType.bool_,
        addr = 0x01202ab3,
    },
    {
        name = "DEBUG_SPRITE_UV_GEN_REPORT_MISSING_FILES",
        type = CE_MemoryType.bool_,
        addr = 0x01202b45,
    },
    {
        name = "DEBUG_NO_PAUSE_ON_WINDOW_FOCUS_LOST",
        type = CE_MemoryType.bool_,
        addr = 0x01204f55,
    },
    {
        name = "DEBUG_DEMO_MODE",
        type = CE_MemoryType.bool_,
        addr = 0x01202b0b,
    },
    {
        name = "DEBUG_DEMO_MODE_RESET_TIMEOUT_FRAMES",
        type = CE_MemoryType.int_,
        addr = 0x0115122c,
    },
    {
        name = "DEBUG_DEMO_MODE_RESET_WARNING_TIME_FRAMES",
        type = CE_MemoryType.int_,
        addr = 0x0115074c,
    },
    {
        name = "DEBUG_DISABLE_PHYSICSBODY_OUT_OF_BOUNDS_WARNING",
        type = CE_MemoryType.bool_,
        addr = 0x01203144,
    },
    {
        name = "DEBUG_ENABLE_AUTOSAVE",
        type = CE_MemoryType.bool_,
        addr = 0x011512ec,
    },
    {
        name = "DEBUG_AUDIO_WRITE_TO_FILE",
        type = CE_MemoryType.bool_,
        addr = 0x01202f9a,
    },
    {
        name = "DEBUG_NO_LOGO_SPLASHES",
        type = CE_MemoryType.bool_,
        addr = 0x01202b2c,
    },
    {
        name = "DEBUG_TEST_SAVE_SPAWN_X",
        type = CE_MemoryType.float_,
        addr = 0x011511c0,
    },
    {
        name = "DEBUG_INTRO_PLAY_ALWAYS",
        type = CE_MemoryType.bool_,
        addr = 0x01204f6f,
    },
    {
        name = "DEBUG_REPLAY_RECORDER_FPS",
        type = CE_MemoryType.int_,
        addr = 0x01150564,
    },
    {
        name = "DEBUG_F12_OPEN_FOG_OF_WAR",
        type = CE_MemoryType.bool_,
        addr = 0x011506f7,
    },
    {
        name = "DEBUG_ALWAYS_COMPLETE_THE_GAME",
        type = CE_MemoryType.bool_,
        addr = 0x01202b2f,
    },
    {
        name = "DEBUG_SKIP_RELEASE_NOTES",
        type = CE_MemoryType.bool_,
        addr = 0x01202aba,
    },
    {
        name = "DEBUG_SKIP_MAIN_MENU",
        type = CE_MemoryType.bool_,
        addr = 0x0120268a,
    },
    {
        name = "DEBUG_SKIP_ALL_START_MENUS",
        type = CE_MemoryType.bool_,
        addr = 0x01202b47,
    },
    {
        name = "DEBUG_PLAYER_NEVER_DIES",
        type = CE_MemoryType.bool_,
        addr = 0x01202b41,
    },
    {
        name = "DEBUG_ALWAYS_GET_UNLOCKS",
        type = CE_MemoryType.bool_,
        addr = 0x01204fb3,
    },
    {
        name = "DEBUG_PROFILE_ALLOCATOR",
        type = CE_MemoryType.bool_,
        addr = 0x01202b40,
    },
    {
        name = "DEBUG_STREAMING_INTEGRATION_DEV_MODE",
        type = CE_MemoryType.bool_,
        addr = 0x01202ab1,
    },
    {
        name = "DEBUG_UI_ALL_THE_CARDS_WIDTH",
        type = CE_MemoryType.int_,
        addr = 0x0115068c,
    },
    {
        name = "DEBUG_UI_ALL_THE_CARDS_HEIGHT",
        type = CE_MemoryType.int_,
        addr = 0x01151214,
    },
    {
        name = "DEBUG_UI_ALL_THE_CARDS_DISPLAY_EXTRA_INFO",
        type = CE_MemoryType.bool_,
        addr = 0x01151019,
    },
    {
        name = "DEBUG_PERSISTENT_FLAGS_DISABLED",
        type = CE_MemoryType.bool_,
        addr = 0x01202b42,
    },
    {
        name = "DEBUG_LOG_LEVEL",
        type = CE_MemoryType.int_,
        addr = 0x0115050c,
    },
    {
        name = "DEBUG_LOG_STD_COUT",
        type = CE_MemoryType.bool_,
        addr = 0x01150058,
    },
    {
        name = "DEBUG_LOG_SOLID_BACKGROUND",
        type = CE_MemoryType.int_,
        addr = 0x01150ff8,
    },
    {
        name = "DEBUG_LOG_TODO_ERRORS",
        type = CE_MemoryType.bool_,
        addr = 0x01150633,
    },
    {
        name = "DEBUG_LOG_INSTANT_FLUSH",
        type = CE_MemoryType.bool_,
        addr = 0x01202b5b,
    },
    {
        name = "DEBUG_LOG_NEVER_VISIBLE",
        type = CE_MemoryType.bool_,
        addr = 0x01204f43,
    },
    {
        name = "DEBUG_ALWAYS_RANDOM_SEED",
        type = CE_MemoryType.bool_,
        addr = 0x01202ab9,
    },
    {
        name = "DEBUG_ALWAYS_RANDOM_START_POS",
        type = CE_MemoryType.bool_,
        addr = 0x01204f40,
    },
    {
        name = "DEBUG_LUA",
        type = CE_MemoryType.bool_,
        addr = 0x01203156,
    },
    {
        name = "DEBUG_LUA_REPORT_SLOW_SCRIPTS",
        type = CE_MemoryType.bool_,
        addr = 0x0120396a,
    },
    {
        name = "DEBUG_LUA_REPORT_PRINT_FILES",
        type = CE_MemoryType.bool_,
        addr = 0x01202689,
    },
    {
        name = "DEBUG_LUA_LOG_BIOME_SPAWN_SCRIPTS",
        type = CE_MemoryType.bool_,
        addr = 0x01204fb2,
    },
    {
        name = "DEBUG_LUA_REPORT_BIOME_SPAWN_ERRORS",
        type = CE_MemoryType.bool_,
        addr = 0x011504cd,
    },
    {
        name = "DEBUG_LUA_DONT_REPEAT_ERRORS",
        type = CE_MemoryType.bool_,
        addr = 0x011506f5,
    },
    {
        name = "DEBUG_GAME_LOG_SHOW_DRAWN_ACTIONS",
        type = CE_MemoryType.bool_,
        addr = 0x01202b46,
    },
    {
        name = "DEBUG_LOG_STREAMING_STATS",
        type = CE_MemoryType.bool_,
        addr = 0x01151018,
    },
    {
        name = "DEBUG_LOG_LIFETIME_COMPONENT_DANGLING_PARENTS",
        type = CE_MemoryType.bool_,
        addr = 0x01202fab,
    },
    {
        name = "DEBUG_OLLI_CONFIG",
        type = CE_MemoryType.bool_,
        addr = 0x01202ab8,
    },
    {
        name = "DEBUG_GENERATE_BIG_WANG_MAP",
        type = CE_MemoryType.bool_,
        addr = 0x01202b08,
    },
    {
        name = "DEBUG_CRASH_IF_OLD_VERSION",
        type = CE_MemoryType.bool_,
        addr = 0x011504f3,
    },
    {
        name = "DEBUG_RESTART_GAME_IF_OLD_VERSION",
        type = CE_MemoryType.bool_,
        addr = 0x01204fb0,
    },
    {
        name = "DEBUG_CAMERABOUND_DISPLAY_ENTITIES",
        type = CE_MemoryType.bool_,
        addr = 0x01202b43,
    },
    {
        name = "DEBUG_PROFILER_CAPTURE_OLLI_STYLE",
        type = CE_MemoryType.bool_,
        addr = 0x01150517,
    },
    {
        name = "DEBUG_PROFILER_CAPTURE_PETRI_STYLE",
        type = CE_MemoryType.bool_,
        addr = 0x01204f90,
    },
    {
        name = "DEBUG_PAUSE_BOX2D",
        type = CE_MemoryType.bool_,
        addr = 0x01204fb4,
    },
    {
        name = "DEBUG_PAUSE_GRID_UPDATE",
        type = CE_MemoryType.bool_,
        addr = 0x01202ab0,
    },
    {
        name = "DEBUG_PAUSE_SIMULATION",
        type = CE_MemoryType.bool_,
        addr = 0x01202b4a,
    },
    {
        name = "DEBUG_SCREENSHOTTER_ENABLED",
        type = CE_MemoryType.bool_,
        addr = 0x0115101a,
    },
    {
        name = "DEBUG_SCREENSHOTTER_SAVE_PPNG",
        type = CE_MemoryType.bool_,
        addr = 0x011504f0,
    },
    {
        name = "DEBUG_PETRI_TAKE_RANDOM_SHADERSHOT",
        type = CE_MemoryType.bool_,
        addr = 0x01202b27,
    },
    {
        name = "DEBUG_THREADED_WORLD_CREATION",
        type = CE_MemoryType.bool_,
        addr = 0x01150632,
    },
    {
        name = "DEBUG_PETRI_START",
        type = CE_MemoryType.bool_,
        addr = 0x01202b59,
    },
    {
        name = "DEBUG_ATTRACT_MODE",
        type = CE_MemoryType.bool_,
        addr = 0x01204f92,
    },
    {
        name = "DEBUG_CTRL_O_USES_PREV_ENTITY_ALWAYS",
        type = CE_MemoryType.bool_,
        addr = 0x01203154,
    },
    {
        name = "DEBUG_WANG",
        type = CE_MemoryType.bool_,
        addr = 0x01204f57,
    },
    {
        name = "DEBUG_WANG_PATH",
        type = CE_MemoryType.bool_,
        addr = 0x01203969,
    },
    {
        name = "DEBUG_FULL_WANG_MAPS",
        type = CE_MemoryType.bool_,
        addr = 0x01204f7b,
    },
    {
        name = "DEBUG_MATERIAL_AREA_CHECKER",
        type = CE_MemoryType.bool_,
        addr = 0x01204f54,
    },
    {
        name = "DEBUG_COLLISION_TRIGGERS",
        type = CE_MemoryType.bool_,
        addr = 0x01202688,
    },
    {
        name = "DEBUG_SINGLE_THREADED_LOADING",
        type = CE_MemoryType.bool_,
        addr = 0x01202fa8,
    },
    {
        name = "DEBUG_TEXT_ENABLE_WORK_MODE",
        type = CE_MemoryType.bool_,
        addr = 0x01202b2d,
    },
    {
        name = "DEBUG_TEXT_WRITE_MISSING_TRANSLATIONS",
        type = CE_MemoryType.bool_,
        addr = 0x0120395d,
    },
    {
        name = "DEBUG_HOTLOAD_MATERIAL_EDGES",
        type = CE_MemoryType.bool_,
        addr = 0x01204f41,
    },
    {
        name = "DEBUG_IMGUI_HOT_LOAD_ENABLED",
        type = CE_MemoryType.bool_,
        addr = 0x0115101b,
    },
    {
        name = "DEBUG_DISPLAY_INTERNAL_ID_IN_PROGRESS_MENU",
        type = CE_MemoryType.bool_,
        addr = 0x01150516,
    },
    {
        name = "_DEBUG_DONT_LOAD_OTHER_MAGIC_NUMBERS",
        type = CE_MemoryType.bool_,
        addr = 0x01204fb6,
    },
    {
        name = "_DEBUG_DONT_SAVE_MAGIC_NUMBERS",
        type = CE_MemoryType.bool_,
        addr = 0x01204fb5,
    },
    {
        name = "DESIGN_DAILY_RANDOM_STARTING_ITEMS",
        type = CE_MemoryType.bool_,
        addr = 0x0115115e,
    },
    {
        name = "DESIGN_NEW_GAME_PLUS_HP_SCALE_MIN",
        type = CE_MemoryType.float_,
        addr = 0x0115059c,
    },
    {
        name = "DESIGN_NEW_GAME_PLUS_HP_SCALE_MAX",
        type = CE_MemoryType.float_,
        addr = 0x011506f0,
    },
    {
        name = "DESIGN_NEW_GAME_PLUS_ATTACK_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x0115077c,
    },
    {
        name = "DESIGN_PLAYER_START_RAYCAST_COARSE_TO_GROUND",
        type = CE_MemoryType.bool_,
        addr = 0x01204f6c,
    },
    {
        name = "DESIGN_PLAYER_START_TELEPORT_TO_GROUND",
        type = CE_MemoryType.bool_,
        addr = 0x011511d3,
    },
    {
        name = "DESIGN_PLAYER_ALWAYS_TELEPORT_TO_GROUND",
        type = CE_MemoryType.bool_,
        addr = 0x01202b49,
    },
    {
        name = "DESIGN_PLAYER_START_POS_X",
        type = CE_MemoryType.float_,
        addr = 0x01150700,
    },
    {
        name = "DESIGN_PLAYER_START_POS_Y",
        type = CE_MemoryType.float_,
        addr = 0x011512e4,
    },
    {
        name = "DESIGN_RANDOM_STARTING_ITEMS",
        type = CE_MemoryType.bool_,
        addr = 0x01202b4b,
    },
    {
        name = "DESIGN_POLYMORPH_PLAYER_POLYMORPH_ENABLED",
        type = CE_MemoryType.bool_,
        addr = 0x0115115d,
    },
    {
        name = "DESIGN_POLYMORPH_CONTROLS_ENABLED",
        type = CE_MemoryType.bool_,
        addr = 0x0115115f,
    },
    {
        name = "DESIGN_PLAYER_PICKUP_ENABLED",
        type = CE_MemoryType.bool_,
        addr = 0x01204f91,
    },
    {
        name = "DESIGN_CARDS_MUST_BE_IDENTIFIED",
        type = CE_MemoryType.bool_,
        addr = 0x011511d0,
    },
    {
        name = "DESIGN_WAND_SLOTS_ARE_CONSUMED",
        type = CE_MemoryType.bool_,
        addr = 0x0115126a,
    },
    {
        name = "DESIGN_ITEMS_CAN_BE_EATEN",
        type = CE_MemoryType.bool_,
        addr = 0x011506f6,
    },
    {
        name = "DESIGN_ITEMCHEST_DROPS_ACTIONS",
        type = CE_MemoryType.bool_,
        addr = 0x01150598,
    },
    {
        name = "DESIGN_ENEMY_HEALTH_DROPS",
        type = CE_MemoryType.bool_,
        addr = 0x01151269,
    },
    {
        name = "DESIGN_ENEMY_2X_MONEY_DROPS",
        type = CE_MemoryType.bool_,
        addr = 0x0115059a,
    },
    {
        name = "DESIGN_FIRE_DAMAGE_BASED_ON_MAX_HP",
        type = CE_MemoryType.bool_,
        addr = 0x01150562,
    },
    {
        name = "DESIGN_AGGRO_INDICATOR",
        type = CE_MemoryType.bool_,
        addr = 0x0115066c,
    },
    {
        name = "DESIGN_CARD_SYMBOL_UNLOCKS",
        type = CE_MemoryType.bool_,
        addr = 0x011511d1,
    },
    {
        name = "DESIGN_BLOOD_RESTORES_HP",
        type = CE_MemoryType.bool_,
        addr = 0x01204fc0,
    },
    {
        name = "DESIGN_MATERIAL_INGESTION_STATUS_FX",
        type = CE_MemoryType.bool_,
        addr = 0x01204f6e,
    },
    {
        name = "DESIGN_RANDOMIZE_TEMPLE_CONTENTS",
        type = CE_MemoryType.bool_,
        addr = 0x01202abb,
    },
    {
        name = "DESIGN_TEMPLE_CHECK_FOR_LEAKS",
        type = CE_MemoryType.bool_,
        addr = 0x011504ce,
    },
    {
        name = "DESIGN_PLAYER_PHYSICS_KILLS_DONT_TRICK_KILL",
        type = CE_MemoryType.bool_,
        addr = 0x01204fc2,
    },
    {
        name = "DESIGN_DAY_CYCLE_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x01150558,
    },
    {
        name = "DESIGN_SPELL_VISUALIZER",
        type = CE_MemoryType.bool_,
        addr = 0x0120395c,
    },
    {
        name = "DESIGN_RELOAD_ALL_THE_TIME",
        type = CE_MemoryType.bool_,
        addr = 0x01150fe7,
    },
    {
        name = "DESIGN_TELEKINESIS_GLITCH_FOR_TABLETS",
        type = CE_MemoryType.bool_,
        addr = 0x01150560,
    },
    {
        name = "DESIGN_TELEKINESIS_GLITCH_FOR_ITEM_PHYSICS",
        type = CE_MemoryType.bool_,
        addr = 0x0120395e,
    },
    {
        name = "DESIGN_ALLOW_FULL_INVENTORY_SPELLS_DRAG",
        type = CE_MemoryType.bool_,
        addr = 0x01150fe6,
    },
    {
        name = "DESIGN_ALLOW_INVENTORY_CLOSING_AND_DRAGGING_GLITCH",
        type = CE_MemoryType.bool_,
        addr = 0x0120395f,
    },
    {
        name = "GLITCH_ALLOW_5TH_WAND_CARRY",
        type = CE_MemoryType.bool_,
        addr = 0x01202b09,
    },
    {
        name = "GLITCH_ALLOW_ALT_TAB_SILLINESS",
        type = CE_MemoryType.bool_,
        addr = 0x01202b5a,
    },
    {
        name = "GLITCH_ALLOW_STAIN_DUPLICATION_GLITCH",
        type = CE_MemoryType.bool_,
        addr = 0x01202f6e,
    },
    {
        name = "GLITCH_ALLOW_VOMIT_BASED_STATUS_EFFECT_GLITCH",
        type = CE_MemoryType.bool_,
        addr = 0x01202f8e,
    },
    {
        name = "BUGFIX_NEVER_DEFAULT_SERIALIZE_PLAYER",
        type = CE_MemoryType.bool_,
        addr = 0x0115005a,
    },
})

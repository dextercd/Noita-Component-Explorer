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
        addr = 0x00f42ca8,
    },
    {
        name = "DEBUG_SHOW_MOUSE_MATERIAL",
        type = CE_MemoryType.bool_,
        addr = 0x00ff660c,
    },
    {
        name = "PLAYER_KICK_FORCE",
        type = CE_MemoryType.float_,
        addr = 0x00f42b6c,
    },
    {
        name = "PLAYER_KICK_VERLET_RADIUS",
        type = CE_MemoryType.float_,
        addr = 0x00f420b4,
    },
    {
        name = "PLAYER_KICK_VERLET_FORCE",
        type = CE_MemoryType.float_,
        addr = 0x00f420c4,
    },
    {
        name = "PLAYER_KICK_FRAMES_IGNORE_COLLISION",
        type = CE_MemoryType.int_,
        addr = 0x00f42ccc,
    },
    {
        name = "INVENTORY_GUI_ALWAYS_VISIBLE",
        type = CE_MemoryType.bool_,
        addr = 0x00f42e2a,
    },
    {
        name = "CAMERA_IS_FREE",
        type = CE_MemoryType.bool_,
        addr = 0x00ff6657,
    },
    {
        name = "REPORT_DAMAGE_TYPE",
        type = CE_MemoryType.bool_,
        addr = 0x00f42db0,
    },
    {
        name = "REPORT_DAMAGE_SCALE",
        type = CE_MemoryType.float_,
        addr = 0x00f42d5c,
    },
    {
        name = "REPORT_DAMAGE_BLOCK_MESSAGE_INTERVAL_FRAMES",
        type = CE_MemoryType.int_,
        addr = 0x00f42d1c,
    },
    {
        name = "GAME_LOG_ENABLED",
        type = CE_MemoryType.bool_,
        addr = 0x00f421f1,
    },
    {
        name = "RANDOMIZE_LARGE_EXPLOSION_RAYS",
        type = CE_MemoryType.bool_,
        addr = 0x00f420c2,
    },
    {
        name = "EXPLOSION_FACTORY_FALLING_DIRT_FX_PROBABILITY",
        type = CE_MemoryType.int_,
        addr = 0x00ff8a88,
    },
    {
        name = "EXPLOSION_FACTORY_STAIN_PERCENTAGE",
        type = CE_MemoryType.float_,
        addr = 0x00f42e18,
    },
    {
        name = "PHYSICS_JOINT_MAX_FORCE_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0x00f421fc,
    },
    {
        name = "PHYSICS_RAGDOLL_JOINT_MAX_FORCE_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0x00f42d98,
    },
    {
        name = "PHYSICS_RAGDOLL_JOINT_MIN_BREAK_FORCE",
        type = CE_MemoryType.float_,
        addr = 0x00f42d44,
    },
    {
        name = "PHYSICS_RAGDOLL_JOINT_STIFFNESS",
        type = CE_MemoryType.float_,
        addr = 0x00f421bc,
    },
    {
        name = "PHYSICS_RAGDOLL_VERY_STIFF_JOINT_STIFFNESS",
        type = CE_MemoryType.float_,
        addr = 0x00f42b88,
    },
    {
        name = "PHYSICS_FIX_SHELF_BUG",
        type = CE_MemoryType.bool_,
        addr = 0x00ff661c,
    },
    {
        name = "GUI_HP_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0x00f42d14,
    },
    {
        name = "THROW_UI_TIMESTEP_COEFF",
        type = CE_MemoryType.float_,
        addr = 0x00f42d50,
    },
    {
        name = "VERLET_STAIN_DROP_CHANCE_DIV",
        type = CE_MemoryType.int_,
        addr = 0x00f422e0,
    },
    {
        name = "ITEM_SWITCH_ITEM_TWEEN_TIME_FRAMES",
        type = CE_MemoryType.float_,
        addr = 0x00f420d8,
    },
    {
        name = "APPARITION_MIN_BONES_REQUIRED",
        type = CE_MemoryType.int_,
        addr = 0x00f42d9c,
    },
    {
        name = "TELEPORT_ATTACK_COOLDOWN_FRAMES",
        type = CE_MemoryType.int_,
        addr = 0x00f42d90,
    },
    {
        name = "GAMEPLAY_LIVES_ENABLED",
        type = CE_MemoryType.bool_,
        addr = 0x00f42e2b,
    },
    {
        name = "GAMEEFFECT_MOVEMENT_SLOWER_SPEED_MULTIPLIER_MIN",
        type = CE_MemoryType.float_,
        addr = 0x00f43260,
    },
    {
        name = "GAMEEFFECT_MOVEMENT_SLOWER_SPEED_MULTIPLIER_MAX",
        type = CE_MemoryType.float_,
        addr = 0x00f422d8,
    },
    {
        name = "GAMEEFFECT_MOVEMENT_FASTER_SPEED_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0x00f42b70,
    },
    {
        name = "GAMEEFFECT_MOVEMENT_FASTER_2X_SPEED_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0x00f4206c,
    },
    {
        name = "GAMEEFFECT_CRITICAL_HIT_BOOST_CRIT_EXTRA_CHANCE",
        type = CE_MemoryType.int_,
        addr = 0x00f422dc,
    },
    {
        name = "GAMEEFFECT_STAINS_DROP_FASTER_DROP_CHANCE_MULTIPLIER",
        type = CE_MemoryType.int_,
        addr = 0x00f42c88,
    },
    {
        name = "GAMEEFFECT_DAMAGE_MULTIPLIER_COEFF",
        type = CE_MemoryType.float_,
        addr = 0x00f42130,
    },
    {
        name = "GAMEEFFECT_INVISIBILITY_SHOT_COOLDOWN_FRAMES",
        type = CE_MemoryType.int_,
        addr = 0x00f42cb8,
    },
    {
        name = "GAMEEFFECT_TELEPORTITIS_COOLDOWN_FRAMES",
        type = CE_MemoryType.int_,
        addr = 0x00f42b7c,
    },
    {
        name = "GAMEEFFECT_TELEPORTITIS_DAMAGE_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0x00f42d64,
    },
    {
        name = "GAMEEFFECT_ELECROCUTION_RESISTANCE_DURATION_FRAMES",
        type = CE_MemoryType.int_,
        addr = 0x00f42da4,
    },
    {
        name = "GAMEEFFECT_FIRE_MOVEMENT_SPEED_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0x00f42138,
    },
    {
        name = "GAMEEFFECT_MANA_REGENERATION_SPEED_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0x00f4225c,
    },
    {
        name = "DAMAGE_CRITICAL_HIT_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0x00f42214,
    },
    {
        name = "GAMEEFFECT_GLOBAL_GORE_GORE_MULTIPLIER",
        type = CE_MemoryType.int_,
        addr = 0x00f421f8,
    },
    {
        name = "GAMEEFFECT_EXTRA_MONEY_TRICK_KILL_MULTIPLIER",
        type = CE_MemoryType.int_,
        addr = 0x00f42d88,
    },
    {
        name = "GAME_OVER_DAMAGE_FLASH_FADE_SPEED_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0x00f421e8,
    },
    {
        name = "INGESTION_AMOUNT_PER_CELL_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0x00f42110,
    },
    {
        name = "INGESTION_SATIATION_PER_CELL",
        type = CE_MemoryType.uint32_t,
        addr = 0x00f42c44,
    },
    {
        name = "INGESTION_OVERINGESTION_MSG_PERIOD",
        type = CE_MemoryType.uint32_t,
        addr = 0x00f42ddc,
    },
    {
        name = "INGESTION_LIMIT_SLOW_MOVEMENT",
        type = CE_MemoryType.float_,
        addr = 0x00f42088,
    },
    {
        name = "INGESTION_LIMIT_DAMAGE",
        type = CE_MemoryType.float_,
        addr = 0x00f42cc0,
    },
    {
        name = "INGESTION_LIMIT_EXPLODING",
        type = CE_MemoryType.float_,
        addr = 0x00f42ca4,
    },
    {
        name = "INGESTION_LIMIT_EXPLOSION",
        type = CE_MemoryType.float_,
        addr = 0x00f42268,
    },
    {
        name = "GAMEPLAY_CHARACTER_LIQUID_FORCES_ENABLED",
        type = CE_MemoryType.bool_,
        addr = 0x00ff8a77,
    },
    {
        name = "COOP_RESPAWN_TIMER_FRAMES",
        type = CE_MemoryType.int_,
        addr = 0x00f43268,
    },
    {
        name = "DROP_LEVEL_1",
        type = CE_MemoryType.float_,
        addr = 0x00f42080,
    },
    {
        name = "DROP_LEVEL_2",
        type = CE_MemoryType.float_,
        addr = 0x00f4326c,
    },
    {
        name = "DROP_LEVEL_3",
        type = CE_MemoryType.float_,
        addr = 0x00f42104,
    },
    {
        name = "DROP_LEVEL_4",
        type = CE_MemoryType.float_,
        addr = 0x00f420b8,
    },
    {
        name = "DROP_LEVEL_5",
        type = CE_MemoryType.float_,
        addr = 0x00f42058,
    },
    {
        name = "DROP_LEVEL_6",
        type = CE_MemoryType.float_,
        addr = 0x00f42d08,
    },
    {
        name = "DROP_LEVEL_7",
        type = CE_MemoryType.float_,
        addr = 0x00f42d30,
    },
    {
        name = "DROP_LEVEL_8",
        type = CE_MemoryType.float_,
        addr = 0x00f4205c,
    },
    {
        name = "DROP_LEVEL_9",
        type = CE_MemoryType.float_,
        addr = 0x00f42dd0,
    },
    {
        name = "BIOME_APPARITION_CHANCE",
        type = CE_MemoryType.int_,
        addr = 0x00f420cc,
    },
    {
        name = "BIOME_RANDOM_BLOCK_CHANCE",
        type = CE_MemoryType.float_,
        addr = 0x00f42c40,
    },
    {
        name = "BIOME_USE_BIG_WANG",
        type = CE_MemoryType.bool_,
        addr = 0x00f421f2,
    },
    {
        name = "BIOME_PATH_FIND_HEIGHT_LIMIT",
        type = CE_MemoryType.int_,
        addr = 0x00f4325c,
    },
    {
        name = "BIOME_PATH_FIND_WORLD_POS_MIN_X",
        type = CE_MemoryType.int_,
        addr = 0x00f42154,
    },
    {
        name = "BIOME_PATH_FIND_WORLD_POS_MAX_X",
        type = CE_MemoryType.int_,
        addr = 0x00f42c3c,
    },
    {
        name = "WORLD_SEED",
        type = CE_MemoryType.uint32_t,
        addr = 0x00ff8a44,
    },
    {
        name = "NUM_ORBS_TOTAL",
        type = CE_MemoryType.int_,
        addr = 0x00f420c8,
    },
    {
        name = "CAMERA_MOUSE_INTERPOLATION_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x00f42134,
    },
    {
        name = "CAMERA_GAMEPAD_INTERPOLATION_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x00f42090,
    },
    {
        name = "CAMERA_GAMEPAD_MAX_DISTANCE",
        type = CE_MemoryType.float_,
        addr = 0x00f42b68,
    },
    {
        name = "CAMERA_POSITION_INTERPOLATION_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x00f42cac,
    },
    {
        name = "CAMERA_DISTANCE_INTERPOLATION_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x00f42170,
    },
    {
        name = "CAMERA_NO_MOVE_BUFFER_NEAR_PLAYER",
        type = CE_MemoryType.float_,
        addr = 0x00ff6a60,
    },
    {
        name = "CAMERA_NO_MOVE_BUFFER_NEAR_VIEWPORT_EDGE",
        type = CE_MemoryType.float_,
        addr = 0x00f4213c,
    },
    {
        name = "CAMERA_RECOIL_ATTACK_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x00f4212c,
    },
    {
        name = "CAMERA_RECOIL_RELEASE_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x00f42dac,
    },
    {
        name = "CAMERA_RECOIL_AMOUNT",
        type = CE_MemoryType.float_,
        addr = 0x00f422f0,
    },
    {
        name = "MULTIPLAYER_CAMERA_SMOOTHING",
        type = CE_MemoryType.float_,
        addr = 0x00f420a8,
    },
    {
        name = "MULTIPLAYER_CAMERA_MAX_SMOOTH_DISTANCE",
        type = CE_MemoryType.float_,
        addr = 0x00f42b8c,
    },
    {
        name = "CAMERA_IS_UI_OPEN",
        type = CE_MemoryType.bool_,
        addr = 0x00ff8a75,
    },
    {
        name = "PLAYER_USE_NEW_JETPACK",
        type = CE_MemoryType.bool_,
        addr = 0x00ff6646,
    },
    {
        name = "DOUBLE_CLICK_MAX_SPAN_SECONDS",
        type = CE_MemoryType.float_,
        addr = 0x00f42070,
    },
    {
        name = "ESC_QUITS_GAME",
        type = CE_MemoryType.bool_,
        addr = 0x00ff6a8c,
    },
    {
        name = "GAMEPAD_AIMING_VECTOR_SMOOTHING_COEFF",
        type = CE_MemoryType.float_,
        addr = 0x00f42dc4,
    },
    {
        name = "CONTROLS_AIMING_VECTOR_FULL_LENGTH_PIXELS",
        type = CE_MemoryType.float_,
        addr = 0x00f42078,
    },
    {
        name = "GAMEPAD_SHOT_VIBRATION_FORCE_MIN",
        type = CE_MemoryType.float_,
        addr = 0x00f42b74,
    },
    {
        name = "GAMEPAD_SHOT_VIBRATION_FORCE_COEFF",
        type = CE_MemoryType.float_,
        addr = 0x00f42e1c,
    },
    {
        name = "GAMEPAD_SHOT_VIBRATION_TIME_COEFF",
        type = CE_MemoryType.float_,
        addr = 0x00f42204,
    },
    {
        name = "GAMEPAD_ANALOG_FLYING_LOW",
        type = CE_MemoryType.float_,
        addr = 0x00f420f4,
    },
    {
        name = "GAMEPAD_ANALOG_FLYING_HIGH",
        type = CE_MemoryType.float_,
        addr = 0x00f4211c,
    },
    {
        name = "RAGDOLL_FX_EXPLOSION_ROTATION",
        type = CE_MemoryType.float_,
        addr = 0x00f42c8c,
    },
    {
        name = "RAGDOLL_BLOOD_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0x00f42b50,
    },
    {
        name = "RAGDOLL_FIRE_DEATH_IGNITE_EVERY_N_PIXEL",
        type = CE_MemoryType.int_,
        addr = 0x00f42b58,
    },
    {
        name = "RAGDOLL_IMPULSE_RANDOMNESS",
        type = CE_MemoryType.float_,
        addr = 0x00f420d4,
    },
    {
        name = "RAGDOLL_OWN_VELOCITY_IMPULSE_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0x00f42344,
    },
    {
        name = "RAGDOLL_CRITICAL_HIT_FORCE_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0x00f42cc4,
    },
    {
        name = "DAMAGE_BLOOD_AMOUNT_MIN",
        type = CE_MemoryType.int_,
        addr = 0x00f42e3c,
    },
    {
        name = "DAMAGE_BLOOD_AMOUNT_MAX",
        type = CE_MemoryType.int_,
        addr = 0x00f420d0,
    },
    {
        name = "DAMAGE_FIRE_DAMAGE_MAX_HP_MIN_BOUND",
        type = CE_MemoryType.float_,
        addr = 0x00f4209c,
    },
    {
        name = "DAMAGE_BLOOD_SPRAY_CHANCE",
        type = CE_MemoryType.int_,
        addr = 0x00f42b80,
    },
    {
        name = "EXPLOSION_FACTORY_GORE_FX_PROBABLITY",
        type = CE_MemoryType.int_,
        addr = 0x00f420e8,
    },
    {
        name = "EXPLOSION_FACTORY_GORE_FX_HOLE_PROBABILITY",
        type = CE_MemoryType.int_,
        addr = 0x00f4208c,
    },
    {
        name = "EXPLOSION_FACTORY_GORE_FX_BLOOD_STAIN_COLOR",
        type = CE_MemoryType.uint32_t,
        addr = 0x00f42174,
    },
    {
        name = "GRID_MAX_UPDATES_PER_FRAME",
        type = CE_MemoryType.int_,
        addr = 0x00f43258,
    },
    {
        name = "GRID_FLEXIBLE_MAX_UPDATES",
        type = CE_MemoryType.bool_,
        addr = 0x00ff6655,
    },
    {
        name = "GRID_MIN_UPDATES_PER_FRAME",
        type = CE_MemoryType.int_,
        addr = 0x00f42150,
    },
    {
        name = "CELLFACTORY_CELLDATA_MAX_COUNT",
        type = CE_MemoryType.int_,
        addr = 0x00f42b60,
    },
    {
        name = "PARTICLE_EMITTER_MAX_PARTICLES",
        type = CE_MemoryType.int_,
        addr = 0x00f42b64,
    },
    {
        name = "VIRTUAL_RESOLUTION_X",
        type = CE_MemoryType.int_,
        addr = 0x00f42c48,
    },
    {
        name = "VIRTUAL_RESOLUTION_Y",
        type = CE_MemoryType.int_,
        addr = 0x00f420dc,
    },
    {
        name = "VIRTUAL_RESOLUTION_OFFSET_X",
        type = CE_MemoryType.float_,
        addr = 0x00f42284,
    },
    {
        name = "VIRTUAL_RESOLUTION_OFFSET_Y",
        type = CE_MemoryType.float_,
        addr = 0x00f421d8,
    },
    {
        name = "GRID_RENDER_BORDER",
        type = CE_MemoryType.int_,
        addr = 0x00f42e30,
    },
    {
        name = "GRID_RENDER_TILE_SIZE",
        type = CE_MemoryType.int_,
        addr = 0x00f421e4,
    },
    {
        name = "DRAW_PARALLAX_BACKGROUND",
        type = CE_MemoryType.bool_,
        addr = 0x00f42cb4,
    },
    {
        name = "DRAW_PARALLAX_BACKGROUND_BEFORE_DEPTH",
        type = CE_MemoryType.float_,
        addr = 0x00f420fc,
    },
    {
        name = "RENDER_PARALLAX_BACKGROUND_SHADER_GRADIENT",
        type = CE_MemoryType.bool_,
        addr = 0x00ff8a0b,
    },
    {
        name = "RENDER_SKYLIGHT_MAX_REDUCTION_AMOUNT",
        type = CE_MemoryType.float_,
        addr = 0x00f42d2c,
    },
    {
        name = "RENDER_SKYLIGHT_ABOVE_WEIGHT",
        type = CE_MemoryType.float_,
        addr = 0x00f42144,
    },
    {
        name = "RENDER_SKYLIGHT_SIDES_WEIGHT",
        type = CE_MemoryType.float_,
        addr = 0x00f421dc,
    },
    {
        name = "RENDER_SKYLIGHT_TOTAL_WEIGHT",
        type = CE_MemoryType.float_,
        addr = 0x00f42cc8,
    },
    {
        name = "RENDER_FIRE_LO_TIME",
        type = CE_MemoryType.float_,
        addr = 0x00f421f4,
    },
    {
        name = "RENDER_FIRE_LO_SCALE",
        type = CE_MemoryType.float_,
        addr = 0x00f4216c,
    },
    {
        name = "RENDER_FIRE_LO_FORCE",
        type = CE_MemoryType.float_,
        addr = 0x00f422fc,
    },
    {
        name = "RENDER_FIRE_HI_TIME",
        type = CE_MemoryType.float_,
        addr = 0x00f420bc,
    },
    {
        name = "RENDER_FIRE_HI_SCALE",
        type = CE_MemoryType.float_,
        addr = 0x00f420e0,
    },
    {
        name = "RENDER_FIRE_HI_FORCE",
        type = CE_MemoryType.float_,
        addr = 0x00ff6658,
    },
    {
        name = "RENDER_FIRE_GRAVITY",
        type = CE_MemoryType.float_,
        addr = 0x00f4226c,
    },
    {
        name = "RENDER_FIRE_LIFETIME_MIN",
        type = CE_MemoryType.int_,
        addr = 0x00f42e38,
    },
    {
        name = "RENDER_FIRE_LIFETIME_MAX",
        type = CE_MemoryType.int_,
        addr = 0x00f421d4,
    },
    {
        name = "RENDER_FIRE_GLOW_ALPHA",
        type = CE_MemoryType.float_,
        addr = 0x00f42118,
    },
    {
        name = "RENDER_FIRE_SHARP_ALPHA",
        type = CE_MemoryType.float_,
        addr = 0x00f42e2c,
    },
    {
        name = "RENDER_POTION_PARTICLE_MAX_COLOR_COMPONENT",
        type = CE_MemoryType.float_,
        addr = 0x00f42d8c,
    },
    {
        name = "RENDER_color_grading_LERP_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x00f42ca0,
    },
    {
        name = "TELEPORT_FLASH_COLOR_R",
        type = CE_MemoryType.float_,
        addr = 0x00ff743c,
    },
    {
        name = "TELEPORT_FLASH_COLOR_G",
        type = CE_MemoryType.float_,
        addr = 0x00ff7448,
    },
    {
        name = "TELEPORT_FLASH_COLOR_B",
        type = CE_MemoryType.float_,
        addr = 0x00ff8ac8,
    },
    {
        name = "AUDIO_GAMEEFFECT_FIRE_WEIGHT",
        type = CE_MemoryType.float_,
        addr = 0x00f421e0,
    },
    {
        name = "AUDIO_FIRE_WEIGHT",
        type = CE_MemoryType.float_,
        addr = 0x00f42dd8,
    },
    {
        name = "AUDIO_MAGICAL_MATERIAL_WEIGHT",
        type = CE_MemoryType.float_,
        addr = 0x00f42114,
    },
    {
        name = "AUDIO_GAME_START_FADE_FRAME",
        type = CE_MemoryType.float_,
        addr = 0x00f42200,
    },
    {
        name = "AUDIO_GAME_START_FADE_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x00f42108,
    },
    {
        name = "AUDIO_MUSIC_VOLUME_DEFAULT",
        type = CE_MemoryType.float_,
        addr = 0x00f420f0,
    },
    {
        name = "AUDIO_MUSIC_QUIET_FADE_DOWN_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x00f4223c,
    },
    {
        name = "AUDIO_MUSIC_NORMAL_FADE_DOWN_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x00f42d94,
    },
    {
        name = "AUDIO_MUSIC_NORMAL_FADE_UP_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x00f42d4c,
    },
    {
        name = "AUDIO_MUSIC_ACTION_FADE_DOWN_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x00f4220c,
    },
    {
        name = "AUDIO_MUSIC_ACTION_FADE_UP_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x00f42d10,
    },
    {
        name = "AUDIO_MUSIC_LOW_ENERGY_TRIGGER_COOLDOWN_SECONDS",
        type = CE_MemoryType.double_,
        addr = 0x00f42178,
    },
    {
        name = "AUDIO_MUSIC_FORCED_QUIETNESS_TRIGGERS_AFTER_SECONDS",
        type = CE_MemoryType.int_,
        addr = 0x00f42264,
    },
    {
        name = "AUDIO_MUSIC_FORCED_QUIETNESS_DURATION_SECONDS",
        type = CE_MemoryType.int_,
        addr = 0x00f4207c,
    },
    {
        name = "AUDIO_COLLISION_SIZE_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0x00f421b8,
    },
    {
        name = "AUDIO_COLLISION_SPEED_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0x00f42208,
    },
    {
        name = "AUDIO_COLLISION_KICK_SIZE",
        type = CE_MemoryType.float_,
        addr = 0x00f42d58,
    },
    {
        name = "AUDIO_COLLISION_COOLDOWN_SECONDS",
        type = CE_MemoryType.float_,
        addr = 0x00f42180,
    },
    {
        name = "AUDIO_COLLISION_STATIC_WALL_INTENSITY",
        type = CE_MemoryType.float_,
        addr = 0x00f42d28,
    },
    {
        name = "AUDIO_COLLISION_STATIC_WALL_SPEED_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0x00f42d54,
    },
    {
        name = "AUDIO_PHYSICS_BREAK_MASS_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0x00f42c98,
    },
    {
        name = "AUDIO_CHARACTER_LIQUID_SPLASH_INTENSITY_MIN",
        type = CE_MemoryType.float_,
        addr = 0x00ff8a0c,
    },
    {
        name = "AUDIO_CHARACTER_LIQUID_SPLASH_INTENSITY_MAX",
        type = CE_MemoryType.float_,
        addr = 0x00f42da0,
    },
    {
        name = "AUDIO_CHARACTER_LIQUID_SPLASH_INTENSITY_SPEED_DIV",
        type = CE_MemoryType.float_,
        addr = 0x00f42cb0,
    },
    {
        name = "AUDIO_EXPLOSION_NO_SOUND_BELOW_RADIUS",
        type = CE_MemoryType.float_,
        addr = 0x00f42288,
    },
    {
        name = "AUDIO_EXPLOSION_SMALL_SOUND_MAX_RADIUS",
        type = CE_MemoryType.float_,
        addr = 0x00f42e24,
    },
    {
        name = "AUDIO_PICK_GOLD_SAND_MIN_AMOUNT_FOR_SOUND",
        type = CE_MemoryType.int_,
        addr = 0x00f4215c,
    },
    {
        name = "AUDIO_PICK_GOLD_SAND_AMOUNT_ACCUMULATION_FRAMES",
        type = CE_MemoryType.int_,
        addr = 0x00f42b48,
    },
    {
        name = "AUDIO_AMBIENCE_ALTITUDE_SCALE",
        type = CE_MemoryType.float_,
        addr = 0x00f42304,
    },
    {
        name = "PATHFINDING_DISTANCE_FIELD_ENABLED",
        type = CE_MemoryType.bool_,
        addr = 0x00f42087,
    },
    {
        name = "STREAMING_ENABLED",
        type = CE_MemoryType.bool_,
        addr = 0x00f42064,
    },
    {
        name = "STREAMING_FREQUENCY",
        type = CE_MemoryType.double_,
        addr = 0x00f42278,
    },
    {
        name = "STREAMING_CHUNK_TARGET",
        type = CE_MemoryType.int_,
        addr = 0x00f42dcc,
    },
    {
        name = "STREAMING_PERSISTENT_WORLD",
        type = CE_MemoryType.bool_,
        addr = 0x00f421f3,
    },
    {
        name = "STREAMING_AUTOSAVE_PERIOD_SECONDS",
        type = CE_MemoryType.int_,
        addr = 0x00f42164,
    },
    {
        name = "INVENTORY_ICON_SIZE",
        type = CE_MemoryType.int_,
        addr = 0x00f42db4,
    },
    {
        name = "INVENTORY_STASH_X",
        type = CE_MemoryType.float_,
        addr = 0x00f42d74,
    },
    {
        name = "INVENTORY_STASH_Y",
        type = CE_MemoryType.float_,
        addr = 0x00f422ec,
    },
    {
        name = "INVENTORY_DEBUG_X",
        type = CE_MemoryType.float_,
        addr = 0x00f42db8,
    },
    {
        name = "INVENTORY_DEBUG_Y",
        type = CE_MemoryType.float_,
        addr = 0x00f42d84,
    },
    {
        name = "UI_SNAP_TO_NEAREST_INTEGER_SCALE",
        type = CE_MemoryType.bool_,
        addr = 0x00f420c0,
    },
    {
        name = "UI_BARS_SCALE",
        type = CE_MemoryType.float_,
        addr = 0x00f42d20,
    },
    {
        name = "UI_BARS_POS_X",
        type = CE_MemoryType.float_,
        addr = 0x00f42b84,
    },
    {
        name = "UI_BARS_POS_Y",
        type = CE_MemoryType.float_,
        addr = 0x00f4214c,
    },
    {
        name = "UI_BARS2_OFFSET_X",
        type = CE_MemoryType.float_,
        addr = 0x00f42da8,
    },
    {
        name = "UI_PLAYER_FULL_STATS_POS_X",
        type = CE_MemoryType.float_,
        addr = 0x00f422cc,
    },
    {
        name = "UI_PLAYER_FULL_STATS_POS_Y",
        type = CE_MemoryType.float_,
        addr = 0x00f42c9c,
    },
    {
        name = "UI_PLAYER_FULL_STATS_COLUMN2_OFFSET_X",
        type = CE_MemoryType.float_,
        addr = 0x00f420a4,
    },
    {
        name = "UI_PLAYER_FULL_STATS_COLUMN3_OFFSET_X",
        type = CE_MemoryType.float_,
        addr = 0x00f42dc8,
    },
    {
        name = "UI_STAT_BAR_EXTRA_SPACING",
        type = CE_MemoryType.float_,
        addr = 0x00f43264,
    },
    {
        name = "UI_STAT_BAR_ICON_OFFSET_Y",
        type = CE_MemoryType.float_,
        addr = 0x00ff6a74,
    },
    {
        name = "UI_STAT_BAR_TEXT_OFFSET_X",
        type = CE_MemoryType.float_,
        addr = 0x00f42098,
    },
    {
        name = "UI_STAT_BAR_TEXT_OFFSET_Y",
        type = CE_MemoryType.float_,
        addr = 0x00ff6614,
    },
    {
        name = "UI_QUICKBAR_OFFSET_X",
        type = CE_MemoryType.float_,
        addr = 0x00ff6c30,
    },
    {
        name = "UI_QUICKBAR_OFFSET_Y",
        type = CE_MemoryType.float_,
        addr = 0x00ff8a2c,
    },
    {
        name = "UI_INVENTORY_BACKGROUND_POSITION_X",
        type = CE_MemoryType.float_,
        addr = 0x00ff8a38,
    },
    {
        name = "UI_INVENTORY_BACKGROUND_POSITION_Y",
        type = CE_MemoryType.float_,
        addr = 0x00ff65f8,
    },
    {
        name = "UI_FULL_INVENTORY_OFFSET_X",
        type = CE_MemoryType.float_,
        addr = 0x00f4210c,
    },
    {
        name = "UI_IMPORTANT_MESSAGE_POS_Y",
        type = CE_MemoryType.int_,
        addr = 0x00f422f4,
    },
})
table_extend(developer_items, {
    {
        name = "UI_IMPORTANT_MESSAGE_TITLE_SCALE",
        type = CE_MemoryType.float_,
        addr = 0x00f42d7c,
    },
    {
        name = "UI_LOW_HP_THRESHOLD",
        type = CE_MemoryType.float_,
        addr = 0x00f4221c,
    },
    {
        name = "UI_LOW_HP_WARNING_FLASH_FREQUENCY",
        type = CE_MemoryType.float_,
        addr = 0x00f42238,
    },
    {
        name = "UI_PIXEL_FONT_GAME_LOG",
        type = CE_MemoryType.bool_,
        addr = 0x00f42085,
    },
    {
        name = "UI_PAUSE_MENU_LAYOUT_TOP_EDGE_PERCENTAGE",
        type = CE_MemoryType.int_,
        addr = 0x00f42d34,
    },
    {
        name = "UI_GAME_OVER_MENU_LAYOUT_TOP_EDGE_PERCENTAGE",
        type = CE_MemoryType.int_,
        addr = 0x00f42148,
    },
    {
        name = "UI_WOBBLE_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x00f4233c,
    },
    {
        name = "UI_WOBBLE_AMOUNT_DEGREES",
        type = CE_MemoryType.float_,
        addr = 0x00f42e34,
    },
    {
        name = "UI_GAMEOVER_SCREEN_BOX_FROM_TOP_PERCENT",
        type = CE_MemoryType.float_,
        addr = 0x00f42310,
    },
    {
        name = "UI_GAMEOVER_SCREEN_BOX_FROM_SIDE_PERCENT",
        type = CE_MemoryType.float_,
        addr = 0x00f421b4,
    },
    {
        name = "UI_GAMEOVER_SCREEN_BOX_FROM_BOTTOM_PERCENT",
        type = CE_MemoryType.float_,
        addr = 0x00f422e4,
    },
    {
        name = "UI_GAMEOVER_SCREEN_MUSIC_CUE_TIMER_FRAMES",
        type = CE_MemoryType.int_,
        addr = 0x00f42d48,
    },
    {
        name = "UI_COOP_QUICK_INVENTORY_HEIGHT",
        type = CE_MemoryType.float_,
        addr = 0x00f42100,
    },
    {
        name = "UI_COOP_STAT_BARS_HEIGHT",
        type = CE_MemoryType.float_,
        addr = 0x00f4228c,
    },
    {
        name = "UI_SCALE_IN_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x00f42cbc,
    },
    {
        name = "UI_DAMAGE_INDICATOR_RANDOM_OFFSET",
        type = CE_MemoryType.float_,
        addr = 0x00f42068,
    },
    {
        name = "UI_ITEM_STAND_OVER_INFO_BOX_OFFSET_X",
        type = CE_MemoryType.float_,
        addr = 0x00f422d4,
    },
    {
        name = "UI_ITEM_STAND_OVER_INFO_BOX_OFFSET_Y",
        type = CE_MemoryType.float_,
        addr = 0x00f42160,
    },
    {
        name = "UI_MOUSE_WORLD_HOVER_TEXT_OFFSET_X",
        type = CE_MemoryType.float_,
        addr = 0x00f422d0,
    },
    {
        name = "UI_MOUSE_WORLD_HOVER_TEXT_OFFSET_Y",
        type = CE_MemoryType.float_,
        addr = 0x00f42c94,
    },
    {
        name = "UI_MAX_PERKS_VISIBLE",
        type = CE_MemoryType.int_,
        addr = 0x00f42094,
    },
    {
        name = "UI_LOCALIZE_RECORD_TEXT",
        type = CE_MemoryType.bool_,
        addr = 0x00ff743a,
    },
    {
        name = "UI_DISPLAY_NUMBERS_WITH_KS_AND_MS",
        type = CE_MemoryType.bool_,
        addr = 0x00f42168,
    },
    {
        name = "MAIN_MENU_BG_OFFSET_X",
        type = CE_MemoryType.float_,
        addr = 0x00f42158,
    },
    {
        name = "MAIN_MENU_BG_OFFSET_Y",
        type = CE_MemoryType.float_,
        addr = 0x00f42dd4,
    },
    {
        name = "MAIN_MENU_BG_OFFSET_Y_END",
        type = CE_MemoryType.float_,
        addr = 0x00f42c38,
    },
    {
        name = "MAIN_MENU_BG_TWEEN_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x00f42c90,
    },
    {
        name = "USE_CUSTOM_THREADPOOL",
        type = CE_MemoryType.bool_,
        addr = 0x00f42d26,
    },
    {
        name = "BOX2D_FREEZE_STUCK_BODIES",
        type = CE_MemoryType.bool_,
        addr = 0x00f42db3,
    },
    {
        name = "BOX2D_THREAD_MAX_WAIT_IN_MS",
        type = CE_MemoryType.float_,
        addr = 0x00f42dc0,
    },
    {
        name = "CREDITS_SCROLL_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x00f42260,
    },
    {
        name = "CREDITS_SCROLL_END_OFFSET_EXTRA",
        type = CE_MemoryType.float_,
        addr = 0x00f421ec,
    },
    {
        name = "CREDITS_SCROLL_SKIP_SPEED_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0x00f4230c,
    },
    {
        name = "INTRO_WEATHER_FOG",
        type = CE_MemoryType.float_,
        addr = 0x00f42d0c,
    },
    {
        name = "INTRO_WEATHER_RAIN",
        type = CE_MemoryType.float_,
        addr = 0x00f42d40,
    },
    {
        name = "SETTINGS_MIN_RESOLUTION_X",
        type = CE_MemoryType.int_,
        addr = 0x00f42060,
    },
    {
        name = "SETTINGS_MIN_RESOLUTION_Y",
        type = CE_MemoryType.int_,
        addr = 0x00f42308,
    },
    {
        name = "STEAM_CLOUD_SIZE_WARNING",
        type = CE_MemoryType.bool_,
        addr = 0x00ff8a74,
    },
    {
        name = "DEBUG_KEYS_ENABLED",
        type = CE_MemoryType.bool_,
        addr = 0x00f42122,
    },
    {
        name = "DEBUG_EXTRA_SCREENSHOT_KEYS_ENABLED",
        type = CE_MemoryType.bool_,
        addr = 0x00f42067,
    },
    {
        name = "DEBUG_USE_PRELOAD",
        type = CE_MemoryType.bool_,
        addr = 0x00f42169,
    },
    {
        name = "DEBUG_USE_DEBUG_PRELOAD",
        type = CE_MemoryType.bool_,
        addr = 0x00ff6a6f,
    },
    {
        name = "DEBUG_TREES",
        type = CE_MemoryType.bool_,
        addr = 0x00ff8a2b,
    },
    {
        name = "DEBUG_PIXEL_SCENES",
        type = CE_MemoryType.bool_,
        addr = 0x00ff6c2b,
    },
    {
        name = "DEBUG_TELEPORT",
        type = CE_MemoryType.bool_,
        addr = 0x00ff6656,
    },
    {
        name = "DEBUG_SI_TYPE",
        type = CE_MemoryType.int_,
        addr = 0x00ff6c34,
    },
    {
        name = "DEBUG_AUDIO_DEV_MODE",
        type = CE_MemoryType.bool_,
        addr = 0x00ff6601,
    },
    {
        name = "DEBUG_AUDIO_MUTE",
        type = CE_MemoryType.bool_,
        addr = 0x00ff6603,
    },
    {
        name = "DEBUG_AUDIO_MUSIC_MUTE",
        type = CE_MemoryType.bool_,
        addr = 0x00ff660e,
    },
    {
        name = "DEBUG_AUDIO_VOLUME",
        type = CE_MemoryType.float_,
        addr = 0x00f42b54,
    },
    {
        name = "DEBUG_TEST_SYMBOL_CLASSIFIER",
        type = CE_MemoryType.bool_,
        addr = 0x00ff7445,
    },
    {
        name = "DEBUG_STREAMING_DISABLE_SAVING",
        type = CE_MemoryType.bool_,
        addr = 0x00ff8a09,
    },
    {
        name = "DEBUG_DRAW_ANIMAL_AI_STATE",
        type = CE_MemoryType.bool_,
        addr = 0x00ff6aa4,
    },
    {
        name = "DEBUG_PRINT_COMPONENT_UPDATOR_ORDER",
        type = CE_MemoryType.bool_,
        addr = 0x00ff6c2a,
    },
    {
        name = "DEBUG_SKYLIGHT_NO_SIMD",
        type = CE_MemoryType.bool_,
        addr = 0x00ff663a,
    },
    {
        name = "DEBUG_DISABLE_MOUSE_SCROLL_WHEEL",
        type = CE_MemoryType.bool_,
        addr = 0x00ff8a76,
    },
    {
        name = "DEBUG_NO_SAVEGAME_CLEAR_ON_GAME_OVER",
        type = CE_MemoryType.bool_,
        addr = 0x00ff8aa2,
    },
    {
        name = "DEBUG_CAMERA_SHAKE_OFFSET",
        type = CE_MemoryType.float_,
        addr = 0x00ff6c2c,
    },
    {
        name = "DEBUG_FREE_CAMERA_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x00f42218,
    },
    {
        name = "DEBUG_DISABLE_POSTFX_DITHERING",
        type = CE_MemoryType.bool_,
        addr = 0x00ff8a8e,
    },
    {
        name = "DEBUG_GIF_WIDTH",
        type = CE_MemoryType.int_,
        addr = 0x00f420f8,
    },
    {
        name = "DEBUG_GIF_HEIGHT",
        type = CE_MemoryType.int_,
        addr = 0x00f420ac,
    },
    {
        name = "DEBUG_GIF_RECORD_60FPS",
        type = CE_MemoryType.bool_,
        addr = 0x00ff8ace,
    },
    {
        name = "DEBUG_SPRITE_UV_GEN_REPORT_MISSING_FILES",
        type = CE_MemoryType.bool_,
        addr = 0x00ff663b,
    },
    {
        name = "DEBUG_NO_PAUSE_ON_WINDOW_FOCUS_LOST",
        type = CE_MemoryType.bool_,
        addr = 0x00ff8a2a,
    },
    {
        name = "DEBUG_DEMO_MODE",
        type = CE_MemoryType.bool_,
        addr = 0x00ff6602,
    },
    {
        name = "DEBUG_DEMO_MODE_RESET_TIMEOUT_FRAMES",
        type = CE_MemoryType.int_,
        addr = 0x00f42d78,
    },
    {
        name = "DEBUG_DEMO_MODE_RESET_WARNING_TIME_FRAMES",
        type = CE_MemoryType.int_,
        addr = 0x00f422c8,
    },
    {
        name = "DEBUG_DISABLE_PHYSICSBODY_OUT_OF_BOUNDS_WARNING",
        type = CE_MemoryType.bool_,
        addr = 0x00ff6aa7,
    },
    {
        name = "DEBUG_ENABLE_AUTOSAVE",
        type = CE_MemoryType.bool_,
        addr = 0x00f42e28,
    },
    {
        name = "DEBUG_AUDIO_WRITE_TO_FILE",
        type = CE_MemoryType.bool_,
        addr = 0x00ff6a8d,
    },
    {
        name = "DEBUG_NO_LOGO_SPLASHES",
        type = CE_MemoryType.bool_,
        addr = 0x00ff661e,
    },
    {
        name = "DEBUG_TEST_SAVE_SPAWN_X",
        type = CE_MemoryType.float_,
        addr = 0x00f42d18,
    },
    {
        name = "DEBUG_INTRO_PLAY_ALWAYS",
        type = CE_MemoryType.bool_,
        addr = 0x00ff8a58,
    },
    {
        name = "DEBUG_REPLAY_RECORDER_FPS",
        type = CE_MemoryType.int_,
        addr = 0x00f420ec,
    },
    {
        name = "DEBUG_F12_OPEN_FOG_OF_WAR",
        type = CE_MemoryType.bool_,
        addr = 0x00f42281,
    },
    {
        name = "DEBUG_ALWAYS_COMPLETE_THE_GAME",
        type = CE_MemoryType.bool_,
        addr = 0x00ff6629,
    },
    {
        name = "DEBUG_SKIP_RELEASE_NOTES",
        type = CE_MemoryType.bool_,
        addr = 0x00ff65fe,
    },
    {
        name = "DEBUG_SKIP_MAIN_MENU",
        type = CE_MemoryType.bool_,
        addr = 0x00ff8aa6,
    },
    {
        name = "DEBUG_SKIP_ALL_START_MENUS",
        type = CE_MemoryType.bool_,
        addr = 0x00ff663d,
    },
    {
        name = "DEBUG_PLAYER_NEVER_DIES",
        type = CE_MemoryType.bool_,
        addr = 0x00ff662b,
    },
    {
        name = "DEBUG_ALWAYS_GET_UNLOCKS",
        type = CE_MemoryType.bool_,
        addr = 0x00ff8a94,
    },
    {
        name = "DEBUG_PROFILE_ALLOCATOR",
        type = CE_MemoryType.bool_,
        addr = 0x00ff662a,
    },
    {
        name = "DEBUG_STREAMING_INTEGRATION_DEV_MODE",
        type = CE_MemoryType.bool_,
        addr = 0x00ff65fd,
    },
    {
        name = "DEBUG_UI_ALL_THE_CARDS_WIDTH",
        type = CE_MemoryType.int_,
        addr = 0x00f42210,
    },
    {
        name = "DEBUG_UI_ALL_THE_CARDS_HEIGHT",
        type = CE_MemoryType.int_,
        addr = 0x00f42d60,
    },
    {
        name = "DEBUG_UI_ALL_THE_CARDS_DISPLAY_EXTRA_INFO",
        type = CE_MemoryType.bool_,
        addr = 0x00f42b79,
    },
    {
        name = "DEBUG_PERSISTENT_FLAGS_DISABLED",
        type = CE_MemoryType.bool_,
        addr = 0x00ff6638,
    },
    {
        name = "DEBUG_LOG_LEVEL",
        type = CE_MemoryType.int_,
        addr = 0x00f420a0,
    },
    {
        name = "DEBUG_LOG_STD_COUT",
        type = CE_MemoryType.bool_,
        addr = 0x00f42e29,
    },
    {
        name = "DEBUG_LOG_SOLID_BACKGROUND",
        type = CE_MemoryType.int_,
        addr = 0x00f42b5c,
    },
    {
        name = "DEBUG_LOG_TODO_ERRORS",
        type = CE_MemoryType.bool_,
        addr = 0x00f4216b,
    },
    {
        name = "DEBUG_LOG_INSTANT_FLUSH",
        type = CE_MemoryType.bool_,
        addr = 0x00ff6654,
    },
    {
        name = "DEBUG_LOG_NEVER_VISIBLE",
        type = CE_MemoryType.bool_,
        addr = 0x00ff8a28,
    },
    {
        name = "DEBUG_ALWAYS_RANDOM_SEED",
        type = CE_MemoryType.bool_,
        addr = 0x00ff65fc,
    },
    {
        name = "DEBUG_ALWAYS_RANDOM_START_POS",
        type = CE_MemoryType.bool_,
        addr = 0x00ff8a22,
    },
    {
        name = "DEBUG_LUA_REPORT_SLOW_SCRIPTS",
        type = CE_MemoryType.bool_,
        addr = 0x00ff7447,
    },
    {
        name = "DEBUG_LUA",
        type = CE_MemoryType.bool_,
        addr = 0x00ff7439,
    },
    {
        name = "DEBUG_LUA_REPORT_PRINT_FILES",
        type = CE_MemoryType.bool_,
        addr = 0x00ff8aa5,
    },
    {
        name = "DEBUG_LUA_LOG_BIOME_SPAWN_SCRIPTS",
        type = CE_MemoryType.bool_,
        addr = 0x00ff8a8f,
    },
    {
        name = "DEBUG_LUA_REPORT_BIOME_SPAWN_ERRORS",
        type = CE_MemoryType.bool_,
        addr = 0x00f42065,
    },
    {
        name = "DEBUG_GAME_LOG_SHOW_DRAWN_ACTIONS",
        type = CE_MemoryType.bool_,
        addr = 0x00ff663c,
    },
    {
        name = "DEBUG_LOG_STREAMING_STATS",
        type = CE_MemoryType.bool_,
        addr = 0x00f42b78,
    },
    {
        name = "DEBUG_LOG_LIFETIME_COMPONENT_DANGLING_PARENTS",
        type = CE_MemoryType.bool_,
        addr = 0x00ff6aa6,
    },
    {
        name = "DEBUG_OLLI_CONFIG",
        type = CE_MemoryType.bool_,
        addr = 0x00ff8acf,
    },
    {
        name = "DEBUG_GENERATE_BIG_WANG_MAP",
        type = CE_MemoryType.bool_,
        addr = 0x00ff6600,
    },
    {
        name = "DEBUG_CRASH_IF_OLD_VERSION",
        type = CE_MemoryType.bool_,
        addr = 0x00f42086,
    },
    {
        name = "DEBUG_RESTART_GAME_IF_OLD_VERSION",
        type = CE_MemoryType.bool_,
        addr = 0x00ff8a8d,
    },
    {
        name = "DEBUG_CAMERABOUND_DISPLAY_ENTITIES",
        type = CE_MemoryType.bool_,
        addr = 0x00ff6639,
    },
    {
        name = "DEBUG_PROFILER_CAPTURE_OLLI_STYLE",
        type = CE_MemoryType.bool_,
        addr = 0x00f420c1,
    },
    {
        name = "DEBUG_PROFILER_CAPTURE_PETRI_STYLE",
        type = CE_MemoryType.bool_,
        addr = 0x00ff8a71,
    },
    {
        name = "DEBUG_PAUSE_BOX2D",
        type = CE_MemoryType.bool_,
        addr = 0x00ff8a95,
    },
    {
        name = "DEBUG_PAUSE_GRID_UPDATE",
        type = CE_MemoryType.bool_,
        addr = 0x00ff8acc,
    },
    {
        name = "DEBUG_PAUSE_SIMULATION",
        type = CE_MemoryType.bool_,
        addr = 0x00ff6644,
    },
    {
        name = "DEBUG_SCREENSHOTTER_ENABLED",
        type = CE_MemoryType.bool_,
        addr = 0x00f42b7a,
    },
    {
        name = "DEBUG_SCREENSHOTTER_SAVE_PPNG",
        type = CE_MemoryType.bool_,
        addr = 0x00f42084,
    },
    {
        name = "DEBUG_PETRI_TAKE_RANDOM_SHADERSHOT",
        type = CE_MemoryType.bool_,
        addr = 0x00ff661d,
    },
    {
        name = "DEBUG_THREADED_WORLD_CREATION",
        type = CE_MemoryType.bool_,
        addr = 0x00f4216a,
    },
    {
        name = "DEBUG_PETRI_START",
        type = CE_MemoryType.bool_,
        addr = 0x00ff6647,
    },
    {
        name = "DEBUG_ATTRACT_MODE",
        type = CE_MemoryType.bool_,
        addr = 0x00ff8a73,
    },
    {
        name = "DEBUG_CTRL_O_USES_PREV_ENTITY_ALWAYS",
        type = CE_MemoryType.bool_,
        addr = 0x00ff7438,
    },
    {
        name = "DEBUG_WANG",
        type = CE_MemoryType.bool_,
        addr = 0x00ff8a48,
    },
    {
        name = "DEBUG_WANG_PATH",
        type = CE_MemoryType.bool_,
        addr = 0x00ff7446,
    },
    {
        name = "DEBUG_FULL_WANG_MAPS",
        type = CE_MemoryType.bool_,
        addr = 0x00ff8a70,
    },
    {
        name = "DEBUG_MATERIAL_AREA_CHECKER",
        type = CE_MemoryType.bool_,
        addr = 0x00ff8a29,
    },
    {
        name = "DEBUG_COLLISION_TRIGGERS",
        type = CE_MemoryType.bool_,
        addr = 0x00ff8aa4,
    },
    {
        name = "DEBUG_SINGLE_THREADED_LOADING",
        type = CE_MemoryType.bool_,
        addr = 0x00ff6a8f,
    },
    {
        name = "DEBUG_TEXT_ENABLE_WORK_MODE",
        type = CE_MemoryType.bool_,
        addr = 0x00ff661f,
    },
    {
        name = "DEBUG_TEXT_WRITE_MISSING_TRANSLATIONS",
        type = CE_MemoryType.bool_,
        addr = 0x00ff7444,
    },
    {
        name = "DEBUG_HOTLOAD_MATERIAL_EDGES",
        type = CE_MemoryType.bool_,
        addr = 0x00ff8a21,
    },
    {
        name = "DEBUG_IMGUI_HOT_LOAD_ENABLED",
        type = CE_MemoryType.bool_,
        addr = 0x00f42b7b,
    },
    {
        name = "_DEBUG_DONT_LOAD_OTHER_MAGIC_NUMBERS",
        type = CE_MemoryType.bool_,
        addr = 0x00ff8a97,
    },
    {
        name = "_DEBUG_DONT_SAVE_MAGIC_NUMBERS",
        type = CE_MemoryType.bool_,
        addr = 0x00ff8a96,
    },
    {
        name = "DESIGN_DAILY_RANDOM_STARTING_ITEMS",
        type = CE_MemoryType.bool_,
        addr = 0x00f42cb6,
    },
    {
        name = "DESIGN_NEW_GAME_PLUS_HP_SCALE_MIN",
        type = CE_MemoryType.float_,
        addr = 0x00f42124,
    },
    {
        name = "DESIGN_NEW_GAME_PLUS_HP_SCALE_MAX",
        type = CE_MemoryType.float_,
        addr = 0x00f42270,
    },
    {
        name = "DESIGN_NEW_GAME_PLUS_ATTACK_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x00f422e8,
    },
    {
        name = "DESIGN_PLAYER_START_RAYCAST_COARSE_TO_GROUND",
        type = CE_MemoryType.bool_,
        addr = 0x00ff8a49,
    },
    {
        name = "DESIGN_PLAYER_START_TELEPORT_TO_GROUND",
        type = CE_MemoryType.bool_,
        addr = 0x00f42d27,
    },
    {
        name = "DESIGN_PLAYER_ALWAYS_TELEPORT_TO_GROUND",
        type = CE_MemoryType.bool_,
        addr = 0x00ff663f,
    },
    {
        name = "DESIGN_PLAYER_START_POS_X",
        type = CE_MemoryType.float_,
        addr = 0x00f42274,
    },
    {
        name = "DESIGN_PLAYER_START_POS_Y",
        type = CE_MemoryType.float_,
        addr = 0x00f42e20,
    },
    {
        name = "DESIGN_RANDOM_STARTING_ITEMS",
        type = CE_MemoryType.bool_,
        addr = 0x00ff6645,
    },
    {
        name = "DESIGN_POLYMORPH_PLAYER_POLYMORPH_ENABLED",
        type = CE_MemoryType.bool_,
        addr = 0x00f42cb5,
    },
    {
        name = "DESIGN_POLYMORPH_CONTROLS_ENABLED",
        type = CE_MemoryType.bool_,
        addr = 0x00f42cb7,
    },
    {
        name = "DESIGN_PLAYER_PICKUP_ENABLED",
        type = CE_MemoryType.bool_,
        addr = 0x00ff8a72,
    },
    {
        name = "DESIGN_CARDS_MUST_BE_IDENTIFIED",
        type = CE_MemoryType.bool_,
        addr = 0x00f42d24,
    },
    {
        name = "DESIGN_WAND_SLOTS_ARE_CONSUMED",
        type = CE_MemoryType.bool_,
        addr = 0x00f42db2,
    },
    {
        name = "DESIGN_ITEMS_CAN_BE_EATEN",
        type = CE_MemoryType.bool_,
        addr = 0x00f42280,
    },
    {
        name = "DESIGN_ITEMCHEST_DROPS_ACTIONS",
        type = CE_MemoryType.bool_,
        addr = 0x00f42121,
    },
    {
        name = "DESIGN_ENEMY_HEALTH_DROPS",
        type = CE_MemoryType.bool_,
        addr = 0x00f42db1,
    },
    {
        name = "DESIGN_ENEMY_2X_MONEY_DROPS",
        type = CE_MemoryType.bool_,
        addr = 0x00f42123,
    },
    {
        name = "DESIGN_FIRE_DAMAGE_BASED_ON_MAX_HP",
        type = CE_MemoryType.bool_,
        addr = 0x00f420c3,
    },
    {
        name = "DESIGN_AGGRO_INDICATOR",
        type = CE_MemoryType.bool_,
        addr = 0x00f421f0,
    },
    {
        name = "DESIGN_CARD_SYMBOL_UNLOCKS",
        type = CE_MemoryType.bool_,
        addr = 0x00f42d25,
    },
    {
        name = "DESIGN_BLOOD_RESTORES_HP",
        type = CE_MemoryType.bool_,
        addr = 0x00ff8aa0,
    },
    {
        name = "DESIGN_MATERIAL_INGESTION_STATUS_FX",
        type = CE_MemoryType.bool_,
        addr = 0x00ff8a4b,
    },
    {
        name = "DESIGN_RANDOMIZE_TEMPLE_CONTENTS",
        type = CE_MemoryType.bool_,
        addr = 0x00ff65ff,
    },
    {
        name = "DESIGN_TEMPLE_CHECK_FOR_LEAKS",
        type = CE_MemoryType.bool_,
        addr = 0x00f42066,
    },
    {
        name = "DESIGN_PLAYER_PHYSICS_KILLS_DONT_TRICK_KILL",
        type = CE_MemoryType.bool_,
        addr = 0x00ff8aa3,
    },
    {
        name = "DESIGN_DAY_CYCLE_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x00f420e4,
    },
    {
        name = "DESIGN_SPELL_VISUALIZER",
        type = CE_MemoryType.bool_,
        addr = 0x00ff743b,
    },
    {
        name = "DESIGN_RELOAD_ALL_THE_TIME",
        type = CE_MemoryType.bool_,
        addr = 0x00f42283,
    },

})

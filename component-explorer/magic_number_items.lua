dofile_once("mods/component-explorer/memory_type.lua")

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
        addr = 0x00f3ac90,
    },
    {
        name = "DEBUG_SHOW_MOUSE_MATERIAL",
        type = CE_MemoryType.bool_,
        addr = 0x00fee3de,
    },
    {
        name = "PLAYER_KICK_FORCE",
        type = CE_MemoryType.float_,
        addr = 0x00f3ab58,
    },
    {
        name = "PLAYER_KICK_VERLET_RADIUS",
        type = CE_MemoryType.float_,
        addr = 0x00f3a0a0,
    },
    {
        name = "PLAYER_KICK_VERLET_FORCE",
        type = CE_MemoryType.float_,
        addr = 0x00f3a0ac,
    },
    {
        name = "PLAYER_KICK_FRAMES_IGNORE_COLLISION",
        type = CE_MemoryType.int_,
        addr = 0x00f3acb4,
    },
    {
        name = "INVENTORY_GUI_ALWAYS_VISIBLE",
        type = CE_MemoryType.bool_,
        addr = 0x00f3b23c,
    },
    {
        name = "CAMERA_IS_FREE",
        type = CE_MemoryType.bool_,
        addr = 0x00fee854,
    },
    {
        name = "REPORT_DAMAGE_TYPE",
        type = CE_MemoryType.bool_,
        addr = 0x00f3ad52,
    },
    {
        name = "REPORT_DAMAGE_FONT",
        type = CE_MemoryType.std_string,
        addr = 0x00f3c5c8,
    },
    {
        name = "REPORT_DAMAGE_SCALE",
        type = CE_MemoryType.float_,
        addr = 0x00f3ad40,
    },
    {
        name = "REPORT_DAMAGE_BLOCK_MESSAGE_INTERVAL_FRAMES",
        type = CE_MemoryType.int_,
        addr = 0x00f3ad04,
    },
    {
        name = "GAME_LOG_ENABLED",
        type = CE_MemoryType.bool_,
        addr = 0x00f3a1cf,
    },
    {
        name = "RANDOMIZE_LARGE_EXPLOSION_RAYS",
        type = CE_MemoryType.bool_,
        addr = 0x00f3a0fc,
    },
    {
        name = "EXPLOSION_FACTORY_FALLING_DIRT_FX_PROBABILITY",
        type = CE_MemoryType.int_,
        addr = 0x00ff0864,
    },
    {
        name = "EXPLOSION_FACTORY_STAIN_PERCENTAGE",
        type = CE_MemoryType.float_,
        addr = 0x00f3ae00,
    },
    {
        name = "PHYSICS_JOINT_MAX_FORCE_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0x00f3a1f0,
    },
    {
        name = "PHYSICS_RAGDOLL_JOINT_MAX_FORCE_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0x00f3ad84,
    },
    {
        name = "PHYSICS_RAGDOLL_JOINT_MIN_BREAK_FORCE",
        type = CE_MemoryType.float_,
        addr = 0x00f3ad28,
    },
    {
        name = "PHYSICS_RAGDOLL_JOINT_STIFFNESS",
        type = CE_MemoryType.float_,
        addr = 0x00f3a164,
    },
    {
        name = "PHYSICS_RAGDOLL_VERY_STIFF_JOINT_STIFFNESS",
        type = CE_MemoryType.float_,
        addr = 0x00f3ab6c,
    },
    {
        name = "PHYSICS_FIX_SHELF_BUG",
        type = CE_MemoryType.bool_,
        addr = 0x00fee3f6,
    },
    {
        name = "GUI_HP_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0x00f3acfc,
    },
    {
        name = "THROW_UI_TIMESTEP_COEFF",
        type = CE_MemoryType.float_,
        addr = 0x00f3ad34,
    },
    {
        name = "VERLET_STAIN_DROP_CHANCE_DIV",
        type = CE_MemoryType.int_,
        addr = 0x00f3a2c8,
    },
    {
        name = "ITEM_SWITCH_ITEM_TWEEN_TIME_FRAMES",
        type = CE_MemoryType.float_,
        addr = 0x00f3a0c0,
    },
    {
        name = "APPARITION_MIN_BONES_REQUIRED",
        type = CE_MemoryType.int_,
        addr = 0x00f3ad80,
    },
    {
        name = "TELEPORT_ATTACK_COOLDOWN_FRAMES",
        type = CE_MemoryType.int_,
        addr = 0x00f3ad78,
    },
    {
        name = "GAMEPLAY_LIVES_ENABLED",
        type = CE_MemoryType.bool_,
        addr = 0x00f3b23d,
    },
    {
        name = "GAMEEFFECT_MOVEMENT_SLOWER_SPEED_MULTIPLIER_MIN",
        type = CE_MemoryType.float_,
        addr = 0x00f3b248,
    },
    {
        name = "GAMEEFFECT_MOVEMENT_SLOWER_SPEED_MULTIPLIER_MAX",
        type = CE_MemoryType.float_,
        addr = 0x00f3a2c0,
    },
    {
        name = "GAMEEFFECT_MOVEMENT_FASTER_SPEED_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0x00f3ab50,
    },
    {
        name = "GAMEEFFECT_MOVEMENT_FASTER_2X_SPEED_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0x00f3b2a0,
    },
    {
        name = "GAMEEFFECT_CRITICAL_HIT_BOOST_CRIT_EXTRA_CHANCE",
        type = CE_MemoryType.int_,
        addr = 0x00f3a2c4,
    },
    {
        name = "GAMEEFFECT_STAINS_DROP_FASTER_DROP_CHANCE_MULTIPLIER",
        type = CE_MemoryType.int_,
        addr = 0x00f3ac70,
    },
    {
        name = "GAMEEFFECT_DAMAGE_MULTIPLIER_COEFF",
        type = CE_MemoryType.float_,
        addr = 0x00f3a124,
    },
    {
        name = "GAMEEFFECT_INVISIBILITY_SHOT_COOLDOWN_FRAMES",
        type = CE_MemoryType.int_,
        addr = 0x00f3ac9c,
    },
    {
        name = "GAMEEFFECT_TELEPORTITIS_COOLDOWN_FRAMES",
        type = CE_MemoryType.int_,
        addr = 0x00f3ab5c,
    },
    {
        name = "GAMEEFFECT_TELEPORTITIS_DAMAGE_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0x00f3ad48,
    },
    {
        name = "GAMEEFFECT_ELECROCUTION_RESISTANCE_DURATION_FRAMES",
        type = CE_MemoryType.int_,
        addr = 0x00f3ad8c,
    },
    {
        name = "GAMEEFFECT_FIRE_MOVEMENT_SPEED_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0x00f3a128,
    },
    {
        name = "GAMEEFFECT_MANA_REGENERATION_SPEED_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0x00f3a22c,
    },
    {
        name = "DAMAGE_CRITICAL_HIT_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0x00f3a224,
    },
    {
        name = "GAMEEFFECT_GLOBAL_GORE_GORE_MULTIPLIER",
        type = CE_MemoryType.int_,
        addr = 0x00f3a1ec,
    },
    {
        name = "GAMEEFFECT_EXTRA_MONEY_TRICK_KILL_MULTIPLIER",
        type = CE_MemoryType.int_,
        addr = 0x00f3ad70,
    },
    {
        name = "GAME_OVER_DAMAGE_FLASH_FADE_SPEED_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0x00f3a1d4,
    },
    {
        name = "INGESTION_AMOUNT_PER_CELL_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0x00f3a0f8,
    },
    {
        name = "INGESTION_SATIATION_PER_CELL",
        type = CE_MemoryType.uint32_t,
        addr = 0x00f3ac2c,
    },
    {
        name = "INGESTION_OVERINGESTION_MSG_PERIOD",
        type = CE_MemoryType.uint32_t,
        addr = 0x00f3adfc,
    },
    {
        name = "INGESTION_LIMIT_SLOW_MOVEMENT",
        type = CE_MemoryType.float_,
        addr = 0x00f3a070,
    },
    {
        name = "INGESTION_LIMIT_DAMAGE",
        type = CE_MemoryType.float_,
        addr = 0x00f3aca4,
    },
    {
        name = "INGESTION_LIMIT_EXPLODING",
        type = CE_MemoryType.float_,
        addr = 0x00f3ac8c,
    },
    {
        name = "INGESTION_LIMIT_EXPLOSION",
        type = CE_MemoryType.float_,
        addr = 0x00f3a25c,
    },
    {
        name = "GAMEPLAY_CHARACTER_LIQUID_FORCES_ENABLED",
        type = CE_MemoryType.bool_,
        addr = 0x00ff0861,
    },
    {
        name = "COOP_RESPAWN_TIMER_FRAMES",
        type = CE_MemoryType.int_,
        addr = 0x00f3b288,
    },
    {
        name = "DROP_LEVEL_1",
        type = CE_MemoryType.float_,
        addr = 0x00f3a06c,
    },
    {
        name = "DROP_LEVEL_2",
        type = CE_MemoryType.float_,
        addr = 0x00f3b28c,
    },
    {
        name = "DROP_LEVEL_3",
        type = CE_MemoryType.float_,
        addr = 0x00f3a0ec,
    },
    {
        name = "DROP_LEVEL_4",
        type = CE_MemoryType.float_,
        addr = 0x00f3a0a4,
    },
    {
        name = "DROP_LEVEL_5",
        type = CE_MemoryType.float_,
        addr = 0x00f3b290,
    },
    {
        name = "DROP_LEVEL_6",
        type = CE_MemoryType.float_,
        addr = 0x00f3acb8,
    },
    {
        name = "DROP_LEVEL_7",
        type = CE_MemoryType.float_,
        addr = 0x00f3ad14,
    },
    {
        name = "DROP_LEVEL_8",
        type = CE_MemoryType.float_,
        addr = 0x00f3b294,
    },
    {
        name = "DROP_LEVEL_9",
        type = CE_MemoryType.float_,
        addr = 0x00f3adb8,
    },
    {
        name = "BIOME_MAP",
        type = CE_MemoryType.std_string,
        addr = 0x00f3d058,
    },
    {
        name = "BIOME_APPARITION_CHANCE",
        type = CE_MemoryType.int_,
        addr = 0x00f3a0b4,
    },
    {
        name = "BIOME_RANDOM_BLOCK_CHANCE",
        type = CE_MemoryType.float_,
        addr = 0x00f3ab78,
    },
    {
        name = "BIOME_USE_BIG_WANG",
        type = CE_MemoryType.bool_,
        addr = 0x00f3a1dc,
    },
    {
        name = "BIOME_PATH_FIND_HEIGHT_LIMIT",
        type = CE_MemoryType.int_,
        addr = 0x00f3b244,
    },
    {
        name = "BIOME_PATH_FIND_WORLD_POS_MIN_X",
        type = CE_MemoryType.int_,
        addr = 0x00f3a144,
    },
    {
        name = "BIOME_PATH_FIND_WORLD_POS_MAX_X",
        type = CE_MemoryType.int_,
        addr = 0x00f3ac28,
    },
    {
        name = "WORLD_SEED",
        type = CE_MemoryType.uint32_t,
        addr = 0x00ff0820,
    },
    {
        name = "NUM_ORBS_TOTAL",
        type = CE_MemoryType.int_,
        addr = 0x00f3a0b0,
    },
    {
        name = "CAMERA_MOUSE_INTERPOLATION_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x00f3a110,
    },
    {
        name = "CAMERA_GAMEPAD_INTERPOLATION_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x00f3a07c,
    },
    {
        name = "CAMERA_GAMEPAD_MAX_DISTANCE",
        type = CE_MemoryType.float_,
        addr = 0x00f3ab54,
    },
    {
        name = "CAMERA_POSITION_INTERPOLATION_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x00f3ac94,
    },
    {
        name = "CAMERA_DISTANCE_INTERPOLATION_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x00f3a160,
    },
    {
        name = "CAMERA_NO_MOVE_BUFFER_NEAR_PLAYER",
        type = CE_MemoryType.float_,
        addr = 0x00fee838,
    },
    {
        name = "CAMERA_NO_MOVE_BUFFER_NEAR_VIEWPORT_EDGE",
        type = CE_MemoryType.float_,
        addr = 0x00f3a114,
    },
    {
        name = "CAMERA_RECOIL_ATTACK_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x00f3a120,
    },
    {
        name = "CAMERA_RECOIL_RELEASE_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x00f3ad94,
    },
    {
        name = "CAMERA_RECOIL_AMOUNT",
        type = CE_MemoryType.float_,
        addr = 0x00f3a2d4,
    },
    {
        name = "MULTIPLAYER_CAMERA_SMOOTHING",
        type = CE_MemoryType.float_,
        addr = 0x00f3a094,
    },
    {
        name = "MULTIPLAYER_CAMERA_MAX_SMOOTH_DISTANCE",
        type = CE_MemoryType.float_,
        addr = 0x00f3ab74,
    },
    {
        name = "CAMERA_IS_UI_OPEN",
        type = CE_MemoryType.bool_,
        addr = 0x00ff084f,
    },
    {
        name = "PLAYER_USE_NEW_JETPACK",
        type = CE_MemoryType.bool_,
        addr = 0x00fee428,
    },
    {
        name = "DOUBLE_CLICK_MAX_SPAN_SECONDS",
        type = CE_MemoryType.float_,
        addr = 0x00f3a058,
    },
    {
        name = "ESC_QUITS_GAME",
        type = CE_MemoryType.bool_,
        addr = 0x00fee85e,
    },
    {
        name = "GAMEPAD_AIMING_VECTOR_SMOOTHING_COEFF",
        type = CE_MemoryType.float_,
        addr = 0x00f3ada8,
    },
    {
        name = "CONTROLS_AIMING_VECTOR_FULL_LENGTH_PIXELS",
        type = CE_MemoryType.float_,
        addr = 0x00f3a060,
    },
    {
        name = "GAMEPAD_SHOT_VIBRATION_FORCE_MIN",
        type = CE_MemoryType.float_,
        addr = 0x00f3ab60,
    },
    {
        name = "GAMEPAD_SHOT_VIBRATION_FORCE_COEFF",
        type = CE_MemoryType.float_,
        addr = 0x00f3ae04,
    },
    {
        name = "GAMEPAD_SHOT_VIBRATION_TIME_COEFF",
        type = CE_MemoryType.float_,
        addr = 0x00f3a1e8,
    },
    {
        name = "GAMEPAD_ANALOG_FLYING_LOW",
        type = CE_MemoryType.float_,
        addr = 0x00f3a0dc,
    },
    {
        name = "GAMEPAD_ANALOG_FLYING_HIGH",
        type = CE_MemoryType.float_,
        addr = 0x00f3a108,
    },
    {
        name = "RAGDOLL_FX_EXPLOSION_ROTATION",
        type = CE_MemoryType.float_,
        addr = 0x00f3ac74,
    },
    {
        name = "RAGDOLL_BLOOD_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0x00f3ab40,
    },
    {
        name = "RAGDOLL_FIRE_DEATH_IGNITE_EVERY_N_PIXEL",
        type = CE_MemoryType.int_,
        addr = 0x00f3ab34,
    },
    {
        name = "RAGDOLL_IMPULSE_RANDOMNESS",
        type = CE_MemoryType.float_,
        addr = 0x00f3a0bc,
    },
    {
        name = "RAGDOLL_OWN_VELOCITY_IMPULSE_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0x00f3a32c,
    },
    {
        name = "RAGDOLL_CRITICAL_HIT_FORCE_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0x00f3acac,
    },
    {
        name = "DAMAGE_BLOOD_AMOUNT_MIN",
        type = CE_MemoryType.int_,
        addr = 0x00f3ae20,
    },
    {
        name = "DAMAGE_BLOOD_AMOUNT_MAX",
        type = CE_MemoryType.int_,
        addr = 0x00f3a0b8,
    },
    {
        name = "DAMAGE_FIRE_DAMAGE_MAX_HP_MIN_BOUND",
        type = CE_MemoryType.float_,
        addr = 0x00f3a088,
    },
    {
        name = "DAMAGE_BLOOD_SPRAY_CHANCE",
        type = CE_MemoryType.int_,
        addr = 0x00f3ab64,
    },
    {
        name = "EXPLOSION_FACTORY_GORE_FX_PROBABLITY",
        type = CE_MemoryType.int_,
        addr = 0x00f3a0d0,
    },
    {
        name = "EXPLOSION_FACTORY_GORE_FX_HOLE_PROBABILITY",
        type = CE_MemoryType.int_,
        addr = 0x00f3a074,
    },
    {
        name = "EXPLOSION_FACTORY_GORE_FX_BLOOD_STAIN_COLOR",
        type = CE_MemoryType.uint32_t,
        addr = 0x00f3a154,
    },
    {
        name = "GRID_MAX_UPDATES_PER_FRAME",
        type = CE_MemoryType.int_,
        addr = 0x00f3b240,
    },
    {
        name = "GRID_FLEXIBLE_MAX_UPDATES",
        type = CE_MemoryType.bool_,
        addr = 0x00fee42b,
    },
    {
        name = "GRID_MIN_UPDATES_PER_FRAME",
        type = CE_MemoryType.int_,
        addr = 0x00f3a130,
    },
    {
        name = "CELLFACTORY_CELLDATA_MAX_COUNT",
        type = CE_MemoryType.int_,
        addr = 0x00f3ab4c,
    },
    {
        name = "VIRTUAL_RESOLUTION_X",
        type = CE_MemoryType.int_,
        addr = 0x00f3ac6c,
    },
    {
        name = "VIRTUAL_RESOLUTION_Y",
        type = CE_MemoryType.int_,
        addr = 0x00f3a0c4,
    },
    {
        name = "VIRTUAL_RESOLUTION_OFFSET_X",
        type = CE_MemoryType.float_,
        addr = 0x00f3a264,
    },
    {
        name = "VIRTUAL_RESOLUTION_OFFSET_Y",
        type = CE_MemoryType.float_,
        addr = 0x00f3a1c4,
    },
    {
        name = "GRID_RENDER_BORDER",
        type = CE_MemoryType.int_,
        addr = 0x00f3ae14,
    },
    {
        name = "GRID_RENDER_TILE_SIZE",
        type = CE_MemoryType.int_,
        addr = 0x00f3a1d0,
    },
    {
        name = "DRAW_PARALLAX_BACKGROUND",
        type = CE_MemoryType.bool_,
        addr = 0x00f3ab72,
    },
    {
        name = "DRAW_PARALLAX_BACKGROUND_BEFORE_DEPTH",
        type = CE_MemoryType.float_,
        addr = 0x00f3a0e4,
    },
    {
        name = "RENDER_PARALLAX_BACKGROUND_SHADER_GRADIENT",
        type = CE_MemoryType.bool_,
        addr = 0x00ff07e5,
        comment = "Might only do something in the main menu",
    },
    {
        name = "RENDER_SKYLIGHT_MAX_REDUCTION_AMOUNT",
        type = CE_MemoryType.float_,
        addr = 0x00f3ad10,
        comment = "Might only do something in the main menu",
    },
    {
        name = "RENDER_SKYLIGHT_ABOVE_WEIGHT",
        type = CE_MemoryType.float_,
        addr = 0x00f3a12c,
        comment = "Might only do something in the main menu",
    },
    {
        name = "RENDER_SKYLIGHT_SIDES_WEIGHT",
        type = CE_MemoryType.float_,
        addr = 0x00f3a1c8,
    },
    {
        name = "RENDER_SKYLIGHT_TOTAL_WEIGHT",
        type = CE_MemoryType.float_,
        addr = 0x00f3acb0,
    },
    {
        name = "RENDER_FIRE_LO_TIME",
        type = CE_MemoryType.float_,
        addr = 0x00f3a1e0,
    },
    {
        name = "RENDER_FIRE_LO_SCALE",
        type = CE_MemoryType.float_,
        addr = 0x00f3a158,
    },
    {
        name = "RENDER_FIRE_LO_FORCE",
        type = CE_MemoryType.float_,
        addr = 0x00f3a2ec,
    },
    {
        name = "RENDER_FIRE_HI_TIME",
        type = CE_MemoryType.float_,
        addr = 0x00f3a0a8,
    },
    {
        name = "RENDER_FIRE_HI_SCALE",
        type = CE_MemoryType.float_,
        addr = 0x00f3a0c8,
    },
    {
        name = "RENDER_FIRE_HI_FORCE",
        type = CE_MemoryType.float_,
        addr = 0x00fee834,
    },
    {
        name = "RENDER_FIRE_GRAVITY",
        type = CE_MemoryType.float_,
        addr = 0x00f3a254,
    },
    {
        name = "RENDER_FIRE_LIFETIME_MIN",
        type = CE_MemoryType.int_,
        addr = 0x00f3ae1c,
    },
    {
        name = "RENDER_FIRE_LIFETIME_MAX",
        type = CE_MemoryType.int_,
        addr = 0x00f3a1a8,
    },
    {
        name = "RENDER_FIRE_GLOW_ALPHA",
        type = CE_MemoryType.float_,
        addr = 0x00f3a104,
    },
    {
        name = "RENDER_FIRE_SHARP_ALPHA",
        type = CE_MemoryType.float_,
        addr = 0x00f3ae10,
    },
    {
        name = "RENDER_POTION_PARTICLE_MAX_COLOR_COMPONENT",
        type = CE_MemoryType.float_,
        addr = 0x00f3ad74,
    },
    {
        name = "RENDER_color_grading_LERP_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x00f3ac88,
    },
    {
        name = "TELEPORT_FLASH_COLOR_R",
        type = CE_MemoryType.float_,
        addr = 0x00fef218,
    },
    {
        name = "TELEPORT_FLASH_COLOR_G",
        type = CE_MemoryType.float_,
        addr = 0x00fef7c0,
    },
    {
        name = "TELEPORT_FLASH_COLOR_B",
        type = CE_MemoryType.float_,
        addr = 0x00ff08a4,
    },
    {
        name = "AUDIO_GAMEEFFECT_FIRE_WEIGHT",
        type = CE_MemoryType.float_,
        addr = 0x00f3a1ac,
    },
    {
        name = "AUDIO_FIRE_WEIGHT",
        type = CE_MemoryType.float_,
        addr = 0x00f3adf8,
    },
    {
        name = "AUDIO_MAGICAL_MATERIAL_WEIGHT",
        type = CE_MemoryType.float_,
        addr = 0x00f3a100,
    },
    {
        name = "AUDIO_GAME_START_FADE_FRAME",
        type = CE_MemoryType.float_,
        addr = 0x00f3a1e4,
    },
    {
        name = "AUDIO_GAME_START_FADE_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x00f3a0f0,
    },
    {
        name = "AUDIO_MUSIC_VOLUME_DEFAULT",
        type = CE_MemoryType.float_,
        addr = 0x00f3a0d8,
    },
    {
        name = "AUDIO_MUSIC_QUIET_FADE_DOWN_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x00f3a228,
    },
    {
        name = "AUDIO_MUSIC_NORMAL_FADE_DOWN_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x00f3ad7c,
    },
    {
        name = "AUDIO_MUSIC_NORMAL_FADE_UP_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x00f3ad30,
    },
    {
        name = "AUDIO_MUSIC_ACTION_FADE_DOWN_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x00f3a1fc,
    },
    {
        name = "AUDIO_MUSIC_ACTION_FADE_UP_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x00f3acf8,
    },
    {
        name = "AUDIO_MUSIC_LOW_ENERGY_TRIGGER_COOLDOWN_SECONDS",
        type = CE_MemoryType.double_,
        addr = 0x00f3a168,
    },
    {
        name = "AUDIO_MUSIC_FORCED_QUIETNESS_TRIGGERS_AFTER_SECONDS",
        type = CE_MemoryType.int_,
        addr = 0x00f3a250,
    },
    {
        name = "AUDIO_MUSIC_FORCED_QUIETNESS_DURATION_SECONDS",
        type = CE_MemoryType.int_,
        addr = 0x00f3a068,
    },
    {
        name = "AUDIO_COLLISION_SIZE_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0x00f3a1a4,
    },
    {
        name = "AUDIO_COLLISION_SPEED_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0x00f3a1f4,
    },
    {
        name = "AUDIO_COLLISION_KICK_SIZE",
        type = CE_MemoryType.float_,
        addr = 0x00f3ad3c,
    },
    {
        name = "AUDIO_COLLISION_COOLDOWN_SECONDS",
        type = CE_MemoryType.float_,
        addr = 0x00f3a15c,
    },
    {
        name = "AUDIO_COLLISION_STATIC_WALL_INTENSITY",
        type = CE_MemoryType.float_,
        addr = 0x00f3ad0c,
    },
    {
        name = "AUDIO_COLLISION_STATIC_WALL_SPEED_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0x00f3ad38,
    },
    {
        name = "AUDIO_PHYSICS_BREAK_MASS_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0x00f3ac80,
    },
    {
        name = "AUDIO_CHARACTER_LIQUID_SPLASH_INTENSITY_MIN",
        type = CE_MemoryType.float_,
        addr = 0x00ff07f8,
    },
    {
        name = "AUDIO_CHARACTER_LIQUID_SPLASH_INTENSITY_MAX",
        type = CE_MemoryType.float_,
        addr = 0x00f3ad88,
    },
    {
        name = "AUDIO_CHARACTER_LIQUID_SPLASH_INTENSITY_SPEED_DIV",
        type = CE_MemoryType.float_,
        addr = 0x00f3ac98,
    },
    {
        name = "AUDIO_EXPLOSION_NO_SOUND_BELOW_RADIUS",
        type = CE_MemoryType.float_,
        addr = 0x00f3a270,
    },
    {
        name = "AUDIO_EXPLOSION_SMALL_SOUND_MAX_RADIUS",
        type = CE_MemoryType.float_,
        addr = 0x00f3ae0c,
    },
    {
        name = "AUDIO_PICK_GOLD_SAND_MIN_AMOUNT_FOR_SOUND",
        type = CE_MemoryType.int_,
        addr = 0x00f3a148,
    },
    {
        name = "AUDIO_PICK_GOLD_SAND_AMOUNT_ACCUMULATION_FRAMES",
        type = CE_MemoryType.int_,
        addr = 0x00f3ab38,
    },
    {
        name = "AUDIO_AMBIENCE_ALTITUDE_SCALE",
        type = CE_MemoryType.float_,
        addr = 0x00f3a2e8,
    },
    {
        name = "AUDIO_CREDITS_TRACK_NAME",
        type = CE_MemoryType.std_string,
        addr = 0x00f3c850,
    },
    {
        name = "PATHFINDING_DISTANCE_FIELD_ENABLED",
        type = CE_MemoryType.bool_,
        addr = 0x00f3a079,
    },
    {
        name = "STREAMING_ENABLED",
        type = CE_MemoryType.bool_,
        addr = 0x00f3b23e,
    },
    {
        name = "STREAMING_FREQUENCY",
        type = CE_MemoryType.double_,
        addr = 0x00f3a268,
    },
    {
        name = "STREAMING_CHUNK_TARGET",
        type = CE_MemoryType.int_,
        addr = 0x00f3adb4,
    },
    {
        name = "STREAMING_PERSISTENT_WORLD",
        type = CE_MemoryType.bool_,
        addr = 0x00f3a1dd,
    },
    {
        name = "STREAMING_AUTOSAVE_PERIOD_SECONDS",
        type = CE_MemoryType.int_,
        addr = 0x00f3a150,
    },
    {
        name = "INVENTORY_ICON_SIZE",
        type = CE_MemoryType.int_,
        addr = 0x00f3ad98,
    },
    {
        name = "INVENTORY_STASH_X",
        type = CE_MemoryType.float_,
        addr = 0x00f3ad5c,
    },
    {
        name = "INVENTORY_STASH_Y",
        type = CE_MemoryType.float_,
        addr = 0x00f3a2d8,
    },
    {
        name = "INVENTORY_DEBUG_X",
        type = CE_MemoryType.float_,
        addr = 0x00f3ad9c,
    },
    {
        name = "INVENTORY_DEBUG_Y",
        type = CE_MemoryType.float_,
        addr = 0x00f3ad6c,
    },
    {
        name = "UI_SNAP_TO_NEAREST_INTEGER_SCALE",
        type = CE_MemoryType.bool_,
        addr = 0x00f3a07a,
    },
    {
        name = "UI_BARS_SCALE",
        type = CE_MemoryType.float_,
        addr = 0x00f3ad08,
    },
    {
        name = "UI_BARS_POS_X",
        type = CE_MemoryType.float_,
        addr = 0x00f3ab68,
    },
    {
        name = "UI_BARS_POS_Y",
        type = CE_MemoryType.float_,
        addr = 0x00f3a138,
    },
    {
        name = "UI_BARS2_OFFSET_X",
        type = CE_MemoryType.float_,
        addr = 0x00f3ad90,
    },
    {
        name = "UI_PLAYER_FULL_STATS_POS_X",
        type = CE_MemoryType.float_,
        addr = 0x00f3a27c,
    },
    {
        name = "UI_PLAYER_FULL_STATS_POS_Y",
        type = CE_MemoryType.float_,
        addr = 0x00f3ac84,
    },
    {
        name = "UI_PLAYER_FULL_STATS_COLUMN2_OFFSET_X",
        type = CE_MemoryType.float_,
        addr = 0x00f3a090,
    },
    {
        name = "UI_PLAYER_FULL_STATS_COLUMN3_OFFSET_X",
        type = CE_MemoryType.float_,
        addr = 0x00f3adac,
    },
    {
        name = "UI_STAT_BAR_EXTRA_SPACING",
        type = CE_MemoryType.float_,
        addr = 0x00f3b24c,
    },
    {
        name = "UI_STAT_BAR_ICON_OFFSET_Y",
        type = CE_MemoryType.float_,
        addr = 0x00fee84c,
    },
    {
        name = "UI_STAT_BAR_TEXT_OFFSET_X",
        type = CE_MemoryType.float_,
        addr = 0x00f3a084,
    },
    {
        name = "UI_STAT_BAR_TEXT_OFFSET_Y",
        type = CE_MemoryType.float_,
        addr = 0x00fee3ec,
    },
    {
        name = "UI_QUICKBAR_OFFSET_X",
        type = CE_MemoryType.float_,
        addr = 0x00feea08,
    },
    {
        name = "UI_QUICKBAR_OFFSET_Y",
        type = CE_MemoryType.float_,
        addr = 0x00ff0804,
    },
    {
        name = "UI_INVENTORY_BACKGROUND_POSITION_X",
        type = CE_MemoryType.float_,
        addr = 0x00ff0810,
    },
    {
        name = "UI_INVENTORY_BACKGROUND_POSITION_Y",
        type = CE_MemoryType.float_,
        addr = 0x00ff0cf8,
    }
})
table_extend(developer_items, {
    {
        name = "UI_FULL_INVENTORY_OFFSET_X",
        type = CE_MemoryType.float_,
        addr = 0x00f3a0f4,
    },
    {
        name = "UI_IMPORTANT_MESSAGE_POS_Y",
        type = CE_MemoryType.int_,
        addr = 0x00f3a2dc,
    },
    {
        name = "UI_IMPORTANT_MESSAGE_TITLE_SCALE",
        type = CE_MemoryType.float_,
        addr = 0x00f3ad64,
    },
    {
        name = "UI_LOW_HP_THRESHOLD",
        type = CE_MemoryType.float_,
        addr = 0x00f3a218,
    },
    {
        name = "UI_LOW_HP_WARNING_FLASH_FREQUENCY",
        type = CE_MemoryType.float_,
        addr = 0x00f3a220,
    },
    {
        name = "UI_PIXEL_FONT_GAME_LOG",
        type = CE_MemoryType.bool_,
        addr = 0x00f3a078,
    },
    {
        name = "UI_PAUSE_MENU_LAYOUT_TOP_EDGE_PERCENTAGE",
        type = CE_MemoryType.int_,
        addr = 0x00f3ad18,
    },
    {
        name = "UI_GAME_OVER_MENU_LAYOUT_TOP_EDGE_PERCENTAGE",
        type = CE_MemoryType.int_,
        addr = 0x00f3a134,
    },
    {
        name = "UI_WOBBLE_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x00f3a2fc,
    },
    {
        name = "UI_WOBBLE_AMOUNT_DEGREES",
        type = CE_MemoryType.float_,
        addr = 0x00f3ae18,
    },
    {
        name = "UI_GAMEOVER_SCREEN_BOX_FROM_TOP_PERCENT",
        type = CE_MemoryType.float_,
        addr = 0x00f3a2f8,
    },
    {
        name = "UI_GAMEOVER_SCREEN_BOX_FROM_SIDE_PERCENT",
        type = CE_MemoryType.float_,
        addr = 0x00f3a1a0,
    },
    {
        name = "UI_GAMEOVER_SCREEN_BOX_FROM_BOTTOM_PERCENT",
        type = CE_MemoryType.float_,
        addr = 0x00f3a2cc,
    },
    {
        name = "UI_GAMEOVER_SCREEN_MUSIC_CUE_TIMER_FRAMES",
        type = CE_MemoryType.int_,
        addr = 0x00f3ad2c,
    },
    {
        name = "UI_COOP_QUICK_INVENTORY_HEIGHT",
        type = CE_MemoryType.float_,
        addr = 0x00f3a0e8,
    },
    {
        name = "UI_COOP_STAT_BARS_HEIGHT",
        type = CE_MemoryType.float_,
        addr = 0x00f3a274,
    },
    {
        name = "UI_SCALE_IN_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x00f3aca0,
    },
    {
        name = "UI_DAMAGE_INDICATOR_RANDOM_OFFSET",
        type = CE_MemoryType.float_,
        addr = 0x00f3b29c,
    },
    {
        name = "UI_ITEM_STAND_OVER_INFO_BOX_OFFSET_X",
        type = CE_MemoryType.float_,
        addr = 0x00f3a2bc,
    },
    {
        name = "UI_ITEM_STAND_OVER_INFO_BOX_OFFSET_Y",
        type = CE_MemoryType.float_,
        addr = 0x00f3a14c,
    },
    {
        name = "UI_MOUSE_WORLD_HOVER_TEXT_OFFSET_X",
        type = CE_MemoryType.float_,
        addr = 0x00f3a2b8,
    },
    {
        name = "UI_MOUSE_WORLD_HOVER_TEXT_OFFSET_Y",
        type = CE_MemoryType.float_,
        addr = 0x00f3ac7c,
    },
    {
        name = "UI_MAX_PERKS_VISIBLE",
        type = CE_MemoryType.int_,
        addr = 0x00f3a080,
    },
    {
        name = "UI_LOCALIZE_RECORD_TEXT",
        type = CE_MemoryType.bool_,
        addr = 0x00feea13,
    },
    {
        name = "UI_DISPLAY_NUMBERS_WITH_KS_AND_MS",
        type = CE_MemoryType.bool_,
        addr = 0x00f3a13e,
    },
    {
        name = "MAIN_MENU_BG_OFFSET_X",
        type = CE_MemoryType.float_,
        addr = 0x00f3a140,
    },
    {
        name = "MAIN_MENU_BG_OFFSET_Y",
        type = CE_MemoryType.float_,
        addr = 0x00f3adbc,
    },
    {
        name = "MAIN_MENU_BG_OFFSET_Y_END",
        type = CE_MemoryType.float_,
        addr = 0x00f3ab7c,
    },
    {
        name = "MAIN_MENU_BG_TWEEN_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x00f3ac78,
    },
    {
        name = "USE_CUSTOM_THREADPOOL",
        type = CE_MemoryType.bool_,
        addr = 0x00f3ad50,
    },
    {
        name = "BOX2D_FREEZE_STUCK_BODIES",
        type = CE_MemoryType.bool_,
        addr = 0x00f3adb1,
    },
    {
        name = "BOX2D_THREAD_MAX_WAIT_IN_MS",
        type = CE_MemoryType.float_,
        addr = 0x00f3ada4,
    },
    {
        name = "CREDITS_SCROLL_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x00f3a24c,
    },
    {
        name = "CREDITS_SCROLL_END_OFFSET_EXTRA",
        type = CE_MemoryType.float_,
        addr = 0x00f3a1d8,
    },
    {
        name = "CREDITS_SCROLL_SKIP_SPEED_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0x00f3a2f4,
    },
    {
        name = "INTRO_WEATHER_FOG",
        type = CE_MemoryType.float_,
        addr = 0x00f3acbc,
    },
    {
        name = "INTRO_WEATHER_RAIN",
        type = CE_MemoryType.float_,
        addr = 0x00f3ad24,
    },
    {
        name = "SETTINGS_MIN_RESOLUTION_X",
        type = CE_MemoryType.int_,
        addr = 0x00f3b298,
    },
    {
        name = "SETTINGS_MIN_RESOLUTION_Y",
        type = CE_MemoryType.int_,
        addr = 0x00f3a2f0,
    },
    {
        name = "STEAM_CLOUD_SIZE_WARNING",
        type = CE_MemoryType.bool_,
        addr = 0x00ff084e,
    },
    {
        name = "DEBUG_KEYS_ENABLED",
        type = CE_MemoryType.bool_,
        addr = 0x00f3a13c,
    },
    {
        name = "DEBUG_EXTRA_SCREENSHOT_KEYS_ENABLED",
        type = CE_MemoryType.bool_,
        addr = 0x00f3a065,
    },
    {
        name = "DEBUG_USE_PRELOAD",
        type = CE_MemoryType.bool_,
        addr = 0x00f3a13f,
    },
    {
        name = "DEBUG_USE_DEBUG_PRELOAD",
        type = CE_MemoryType.bool_,
        addr = 0x00fee855,
    },
    {
        name = "DEBUG_TREES",
        type = CE_MemoryType.bool_,
        addr = 0x00ff0815,
    },
    {
        name = "DEBUG_PIXEL_SCENES",
        type = CE_MemoryType.bool_,
        addr = 0x00feea14,
    },
    {
        name = "DEBUG_TELEPORT",
        type = CE_MemoryType.bool_,
        addr = 0x00fee847,
    },
    {
        name = "DEBUG_SI_TYPE",
        type = CE_MemoryType.int_,
        addr = 0x00feea0c,
    },
    {
        name = "DEBUG_AUDIO_DEV_MODE",
        type = CE_MemoryType.bool_,
        addr = 0x00fee3db,
    },
    {
        name = "DEBUG_AUDIO_MUTE",
        type = CE_MemoryType.bool_,
        addr = 0x00fee3dd,
    },
    {
        name = "DEBUG_AUDIO_MUSIC_MUTE",
        type = CE_MemoryType.bool_,
        addr = 0x00fee3f4,
    },
    {
        name = "DEBUG_AUDIO_VOLUME",
        type = CE_MemoryType.float_,
        addr = 0x00f3ab30,
    },
    {
        name = "DEBUG_TEST_SYMBOL_CLASSIFIER",
        type = CE_MemoryType.bool_,
        addr = 0x00feea17,
    },
    {
        name = "DEBUG_STREAMING_DISABLE_SAVING",
        type = CE_MemoryType.bool_,
        addr = 0x00fef7c7,
    },
    {
        name = "DEBUG_DRAW_ANIMAL_AI_STATE",
        type = CE_MemoryType.bool_,
        addr = 0x00fee876,
    },
    {
        name = "DEBUG_PRINT_COMPONENT_UPDATOR_ORDER",
        type = CE_MemoryType.bool_,
        addr = 0x00feea10,
    },
    {
        name = "DEBUG_SKYLIGHT_NO_SIMD",
        type = CE_MemoryType.bool_,
        addr = 0x00fee413,
    },
    {
        name = "DEBUG_DISABLE_MOUSE_SCROLL_WHEEL",
        type = CE_MemoryType.bool_,
        addr = 0x00ff0860,
    },
    {
        name = "DEBUG_NO_SAVEGAME_CLEAR_ON_GAME_OVER",
        type = CE_MemoryType.bool_,
        addr = 0x00ff087c,
    },
    {
        name = "DEBUG_CAMERA_SHAKE_OFFSET",
        type = CE_MemoryType.float_,
        addr = 0x00feea04,
    },
    {
        name = "DEBUG_FREE_CAMERA_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x00f3a1f8,
    },
    {
        name = "DEBUG_DISABLE_POSTFX_DITHERING",
        type = CE_MemoryType.bool_,
        addr = 0x00ff086c,
    },
    {
        name = "DEBUG_SCREENSHOTS_VIDEO_PATH_PREFIX",
        type = CE_MemoryType.std_string,
        addr = 0x00f3cea8,
    },
    {
        name = "DEBUG_GIF_WIDTH",
        type = CE_MemoryType.int_,
        addr = 0x00f3a0e0,
    },
    {
        name = "DEBUG_GIF_HEIGHT",
        type = CE_MemoryType.int_,
        addr = 0x00f3a098,
    },
    {
        name = "DEBUG_GIF_RECORD_60FPS",
        type = CE_MemoryType.bool_,
        addr = 0x00ff08ac,
    },
    {
        name = "DEBUG_SPRITE_UV_GEN_REPORT_MISSING_FILES",
        type = CE_MemoryType.bool_,
        addr = 0x00fee415,
    },
    {
        name = "DEBUG_NO_PAUSE_ON_WINDOW_FOCUS_LOST",
        type = CE_MemoryType.bool_,
        addr = 0x00ff0814,
    },
    {
        name = "DEBUG_DEMO_MODE",
        type = CE_MemoryType.bool_,
        addr = 0x00fee3dc,
    },
    {
        name = "DEBUG_DEMO_MODE_RESET_TIMEOUT_FRAMES",
        type = CE_MemoryType.int_,
        addr = 0x00f3ad60,
    },
    {
        name = "DEBUG_DEMO_MODE_RESET_WARNING_TIME_FRAMES",
        type = CE_MemoryType.int_,
        addr = 0x00f3a278,
    },
    {
        name = "DEBUG_DISABLE_PHYSICSBODY_OUT_OF_BOUNDS_WARNING",
        type = CE_MemoryType.bool_,
        addr = 0x00fee9f6,
    },
    {
        name = "DEBUG_ENABLE_AUTOSAVE",
        type = CE_MemoryType.bool_,
        addr = 0x00f3adb2,
    },
    {
        name = "DEBUG_AUDIO_WRITE_TO_FILE",
        type = CE_MemoryType.bool_,
        addr = 0x00fee85f,
    },
    {
        name = "DEBUG_NO_LOGO_SPLASHES",
        type = CE_MemoryType.bool_,
        addr = 0x00fee3fc,
    },
    {
        name = "DEBUG_TEST_SAVE_SPAWN_X",
        type = CE_MemoryType.float_,
        addr = 0x00f3ad00,
    },
    {
        name = "DEBUG_INTRO_PLAY_ALWAYS",
        type = CE_MemoryType.bool_,
        addr = 0x00ff082e,
    },
    {
        name = "DEBUG_REPLAY_RECORDER_FPS",
        type = CE_MemoryType.int_,
        addr = 0x00f3a0d4,
    },
    {
        name = "DEBUG_F12_OPEN_FOG_OF_WAR",
        type = CE_MemoryType.bool_,
        addr = 0x00f3a1df,
    },
    {
        name = "DEBUG_ALWAYS_COMPLETE_THE_GAME",
        type = CE_MemoryType.bool_,
        addr = 0x00fee3ff,
    },
    {
        name = "DEBUG_SKIP_RELEASE_NOTES",
        type = CE_MemoryType.bool_,
        addr = 0x00ff08af,
    },
    {
        name = "DEBUG_SKIP_MAIN_MENU",
        type = CE_MemoryType.bool_,
        addr = 0x00ff08a0,
    },
    {
        name = "DEBUG_SKIP_ALL_START_MENUS",
        type = CE_MemoryType.bool_,
        addr = 0x00fee417,
    },
    {
        name = "DEBUG_PLAYER_NEVER_DIES",
        type = CE_MemoryType.bool_,
        addr = 0x00fee411,
    },
    {
        name = "DEBUG_ALWAYS_GET_UNLOCKS",
        type = CE_MemoryType.bool_,
        addr = 0x00ff086e,
    },
    {
        name = "DEBUG_PROFILE_ALLOCATOR",
        type = CE_MemoryType.bool_,
        addr = 0x00fee410,
    },
    {
        name = "DEBUG_STREAMING_INTEGRATION_DEV_MODE",
        type = CE_MemoryType.bool_,
        addr = 0x00fee3d9,
    },
    {
        name = "DEBUG_UI_ALL_THE_CARDS_WIDTH",
        type = CE_MemoryType.int_,
        addr = 0x00f3a21c,
    },
    {
        name = "DEBUG_UI_ALL_THE_CARDS_HEIGHT",
        type = CE_MemoryType.int_,
        addr = 0x00f3ad44,
    },
    {
        name = "DEBUG_UI_ALL_THE_CARDS_DISPLAY_EXTRA_INFO",
        type = CE_MemoryType.bool_,
        addr = 0x00f3ab4a,
    },
    {
        name = "DEBUG_PERSISTENT_FLAGS_DISABLED",
        type = CE_MemoryType.bool_,
        addr = 0x00fee412,
    },
    {
        name = "DEBUG_LOG_LEVEL",
        type = CE_MemoryType.int_,
        addr = 0x00f3a08c,
    },
    {
        name = "DEBUG_LOG_STD_COUT",
        type = CE_MemoryType.bool_,
        addr = 0x00f3adb3,
    },
    {
        name = "DEBUG_LOG_SOLID_BACKGROUND",
        type = CE_MemoryType.int_,
        addr = 0x00f3ab44,
    },
    {
        name = "DEBUG_LOG_TODO_ERRORS",
        type = CE_MemoryType.bool_,
        addr = 0x00f3a1ce,
    },
    {
        name = "DEBUG_LOG_INSTANT_FLUSH",
        type = CE_MemoryType.bool_,
        addr = 0x00fee42a,
    },
    {
        name = "DEBUG_LOG_NEVER_VISIBLE",
        type = CE_MemoryType.bool_,
        addr = 0x00ff07fe,
    },
    {
        name = "DEBUG_ALWAYS_RANDOM_SEED",
        type = CE_MemoryType.bool_,
        addr = 0x00ff08ae,
    },
    {
        name = "DEBUG_ALWAYS_RANDOM_START_POS",
        type = CE_MemoryType.bool_,
        addr = 0x00ff07e7,
    },
    {
        name = "DEBUG_LUA_REPORT_SLOW_SCRIPTS",
        type = CE_MemoryType.bool_,
        addr = 0x00fef7c5,
    },
    {
        name = "DEBUG_LUA",
        type = CE_MemoryType.bool_,
        addr = 0x00feea12,
    },
    {
        name = "DEBUG_LUA_REPORT_PRINT_FILES",
        type = CE_MemoryType.bool_,
        addr = 0x00ff087f,
    },
    {
        name = "DEBUG_LUA_LOG_BIOME_SPAWN_SCRIPTS",
        type = CE_MemoryType.bool_,
        addr = 0x00ff086d,
    },
    {
        name = "DEBUG_LUA_REPORT_BIOME_SPAWN_ERRORS",
        type = CE_MemoryType.bool_,
        addr = 0x00f3b23f,
    },
    {
        name = "DEBUG_GAME_LOG_SHOW_DRAWN_ACTIONS",
        type = CE_MemoryType.bool_,
        addr = 0x00fee416,
    },
    {
        name = "DEBUG_LOG_STREAMING_STATS",
        type = CE_MemoryType.bool_,
        addr = 0x00f3ab4b,
    },
    {
        name = "DEBUG_LOG_LIFETIME_COMPONENT_DANGLING_PARENTS",
        type = CE_MemoryType.bool_,
        addr = 0x00fee9f4,
    },
    {
        name = "DEBUG_OLLI_CONFIG",
        type = CE_MemoryType.bool_,
        addr = 0x00ff08ad,
    },
    {
        name = "DEBUG_GENERATE_BIG_WANG_MAP",
        type = CE_MemoryType.bool_,
        addr = 0x00fee3da,
    },
    {
        name = "DEBUG_CRASH_IF_OLD_VERSION",
        type = CE_MemoryType.bool_,
        addr = 0x00f3a067,
    },
    {
        name = "DEBUG_RESTART_GAME_IF_OLD_VERSION",
        type = CE_MemoryType.bool_,
        addr = 0x00ff0863,
    },
    {
        name = "DEBUG_CAMERABOUND_DISPLAY_ENTITIES",
        type = CE_MemoryType.bool_,
        addr = 0x00fee414,
    },
    {
        name = "DEBUG_PROFILER_CAPTURE_OLLI_STYLE",
        type = CE_MemoryType.bool_,
        addr = 0x00f3a07b,
    },
    {
        name = "DEBUG_PROFILER_CAPTURE_PETRI_STYLE",
        type = CE_MemoryType.bool_,
        addr = 0x00ff083f,
    },
    {
        name = "DEBUG_PAUSE_BOX2D",
        type = CE_MemoryType.bool_,
        addr = 0x00ff086f,
    },
    {
        name = "DEBUG_PAUSE_GRID_UPDATE",
        type = CE_MemoryType.bool_,
        addr = 0x00ff08a2,
    },
    {
        name = "DEBUG_PAUSE_SIMULATION",
        type = CE_MemoryType.bool_,
        addr = 0x00fee41a,
    },
    {
        name = "DEBUG_SCREENSHOTTER_ENABLED",
        type = CE_MemoryType.bool_,
        addr = 0x00f3ab70,
    },
    {
        name = "DEBUG_SCREENSHOTTER_SAVE_PPNG",
        type = CE_MemoryType.bool_,
        addr = 0x00f3a066,
    },
    {
        name = "DEBUG_SCREENSHOTTER_FFMPEG_PATH",
        type = CE_MemoryType.std_string,
        addr = 0x00f3b370,
    },
    {
        name = "DEBUG_PETRI_TAKE_RANDOM_SHADERSHOT",
        type = CE_MemoryType.bool_,
        addr = 0x00fee3f7,
    },
    {
        name = "DEBUG_THREADED_WORLD_CREATION",
        type = CE_MemoryType.bool_,
        addr = 0x00f3a1cc,
    },
    {
        name = "DEBUG_PETRI_START",
        type = CE_MemoryType.bool_,
        addr = 0x00fee429,
    },
    {
        name = "DEBUG_ATTRACT_MODE",
        type = CE_MemoryType.bool_,
        addr = 0x00ff084d,
    },
    {
        name = "DEBUG_PREV_OPENED_ENTITY",
        type = CE_MemoryType.std_string,
        addr = 0x00f3c628,
    },
    {
        name = "DEBUG_CTRL_O_USES_PREV_ENTITY_ALWAYS",
        type = CE_MemoryType.bool_,
        addr = 0x00feea11,
    },
    {
        name = "DEBUG_WANG",
        type = CE_MemoryType.bool_,
        addr = 0x00ff0816,
    },
    {
        name = "DEBUG_WANG_PATH",
        type = CE_MemoryType.bool_,
        addr = 0x00fef7c4,
    },
    {
        name = "DEBUG_FULL_WANG_MAPS",
        type = CE_MemoryType.bool_,
        addr = 0x00ff083e,
    },
    {
        name = "DEBUG_MATERIAL_AREA_CHECKER",
        type = CE_MemoryType.bool_,
        addr = 0x00ff07ff,
    },
    {
        name = "DEBUG_COLLISION_TRIGGERS",
        type = CE_MemoryType.bool_,
        addr = 0x00ff087e,
    },
    {
        name = "DEBUG_SINGLE_THREADED_LOADING",
        type = CE_MemoryType.bool_,
        addr = 0x00fee875,
    },
    {
        name = "DEBUG_TEXT_ENABLE_WORK_MODE",
        type = CE_MemoryType.bool_,
        addr = 0x00fee3fd,
    },
    {
        name = "DEBUG_TEXT_WRITE_MISSING_TRANSLATIONS",
        type = CE_MemoryType.bool_,
        addr = 0x00feea16,
    },
    {
        name = "DEBUG_HOTLOAD_MATERIAL_EDGES",
        type = CE_MemoryType.bool_,
        addr = 0x00ff07fc,
    },
    {
        name = "DEBUG_IMGUI_HOT_LOAD_ENABLED",
        type = CE_MemoryType.bool_,
        addr = 0x00f3ab71,
    },
    {
        name = "_DEBUG_DONT_LOAD_OTHER_MAGIC_NUMBERS",
        type = CE_MemoryType.bool_,
        addr = 0x00ff0875,
    },
    {
        name = "_DEBUG_DONT_SAVE_MAGIC_NUMBERS",
        type = CE_MemoryType.bool_,
        addr = 0x00ff0874,
    },
    {
        name = "DESIGN_DAILY_RANDOM_STARTING_ITEMS",
        type = CE_MemoryType.bool_,
        addr = 0x00f3aca8,
    },
    {
        name = "DESIGN_NEW_GAME_PLUS_HP_SCALE_MIN",
        type = CE_MemoryType.float_,
        addr = 0x00f3a10c,
    },
    {
        name = "DESIGN_NEW_GAME_PLUS_HP_SCALE_MAX",
        type = CE_MemoryType.float_,
        addr = 0x00f3a258,
    },
    {
        name = "DESIGN_NEW_GAME_PLUS_ATTACK_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x00f3a2d0,
    },
    {
        name = "DESIGN_PLAYER_START_RAYCAST_COARSE_TO_GROUND",
        type = CE_MemoryType.bool_,
        addr = 0x00ff0817,
    },
    {
        name = "DESIGN_PLAYER_START_TELEPORT_TO_GROUND",
        type = CE_MemoryType.bool_,
        addr = 0x00f3ad51,
    },
    {
        name = "DESIGN_PLAYER_ALWAYS_TELEPORT_TO_GROUND",
        type = CE_MemoryType.bool_,
        addr = 0x00fee418,
    },
    {
        name = "DESIGN_PLAYER_START_POS_X",
        type = CE_MemoryType.float_,
        addr = 0x00f3a260,
    },
    {
        name = "DESIGN_PLAYER_START_POS_Y",
        type = CE_MemoryType.float_,
        addr = 0x00f3ae08,
    },
    {
        name = "DESIGN_RANDOM_STARTING_ITEMS",
        type = CE_MemoryType.bool_,
        addr = 0x00fee41b,
    },
    {
        name = "DESIGN_POLYMORPH_PLAYER_POLYMORPH_ENABLED",
        type = CE_MemoryType.bool_,
        addr = 0x00f3ab73,
    },
    {
        name = "DESIGN_POLYMORPH_CONTROLS_ENABLED",
        type = CE_MemoryType.bool_,
        addr = 0x00f3aca9,
    },
    {
        name = "DESIGN_PLAYER_PICKUP_ENABLED",
        type = CE_MemoryType.bool_,
        addr = 0x00ff084c,
    },
    {
        name = "DESIGN_CARDS_MUST_BE_IDENTIFIED",
        type = CE_MemoryType.bool_,
        addr = 0x00f3acaa,
    },
    {
        name = "DESIGN_WAND_SLOTS_ARE_CONSUMED",
        type = CE_MemoryType.bool_,
        addr = 0x00f3adb0,
    },
    {
        name = "DESIGN_ITEMS_CAN_BE_EATEN",
        type = CE_MemoryType.bool_,
        addr = 0x00f3a1de,
    },
    {
        name = "DESIGN_ITEMCHEST_DROPS_ACTIONS",
        type = CE_MemoryType.bool_,
        addr = 0x00f3a0ff,
    },
    {
        name = "DESIGN_ENEMY_HEALTH_DROPS",
        type = CE_MemoryType.bool_,
        addr = 0x00f3ad53,
    },
    {
        name = "DESIGN_ENEMY_2X_MONEY_DROPS",
        type = CE_MemoryType.bool_,
        addr = 0x00f3a13d,
    },
    {
        name = "DESIGN_FIRE_DAMAGE_BASED_ON_MAX_HP",
        type = CE_MemoryType.bool_,
        addr = 0x00f3a0fd,
    },
    {
        name = "DESIGN_AGGRO_INDICATOR",
        type = CE_MemoryType.bool_,
        addr = 0x00f3a1cd,
    },
    {
        name = "DESIGN_CARD_SYMBOL_UNLOCKS",
        type = CE_MemoryType.bool_,
        addr = 0x00f3acab,
    },
    {
        name = "DESIGN_BLOOD_RESTORES_HP",
        type = CE_MemoryType.bool_,
        addr = 0x00ff0877,
    },
    {
        name = "DESIGN_MATERIAL_INGESTION_STATUS_FX",
        type = CE_MemoryType.bool_,
        addr = 0x00ff082d,
    },
    {
        name = "DESIGN_RANDOMIZE_TEMPLE_CONTENTS",
        type = CE_MemoryType.bool_,
        addr = 0x00fee3d8,
    },
    {
        name = "DESIGN_TEMPLE_CHECK_FOR_LEAKS",
        type = CE_MemoryType.bool_,
        addr = 0x00f3a064,
    },
    {
        name = "DESIGN_PLAYER_PHYSICS_KILLS_DONT_TRICK_KILL",
        type = CE_MemoryType.bool_,
        addr = 0x00ff087d,
    },
    {
        name = "DESIGN_DAY_CYCLE_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x00f3a0cc,
    },
    {
        name = "DESIGN_SPELL_VISUALIZER",
        type = CE_MemoryType.bool_,
        addr = 0x00feea15,
    },
    {
        name = "DESIGN_RELOAD_ALL_THE_TIME",
        type = CE_MemoryType.bool_,
        addr = 0x00f3ab49,
    },
})

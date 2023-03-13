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
        addr = 0x00f41ca8,
    },
    {
        name = "DEBUG_SHOW_MOUSE_MATERIAL",
        type = CE_MemoryType.bool_,
        addr = 0x00ff55e0,
    },
    {
        name = "PLAYER_KICK_FORCE",
        type = CE_MemoryType.float_,
        addr = 0x00f41b6c,
    },
    {
        name = "PLAYER_KICK_VERLET_RADIUS",
        type = CE_MemoryType.float_,
        addr = 0x00f410b4,
    },
    {
        name = "PLAYER_KICK_VERLET_FORCE",
        type = CE_MemoryType.float_,
        addr = 0x00f410c4,
    },
    {
        name = "PLAYER_KICK_FRAMES_IGNORE_COLLISION",
        type = CE_MemoryType.int_,
        addr = 0x00f41ccc,
    },
    {
        name = "INVENTORY_GUI_ALWAYS_VISIBLE",
        type = CE_MemoryType.bool_,
        addr = 0x00f41e2a,
    },
    {
        name = "CAMERA_IS_FREE",
        type = CE_MemoryType.bool_,
        addr = 0x00ff5627,
    },
    {
        name = "REPORT_DAMAGE_TYPE",
        type = CE_MemoryType.bool_,
        addr = 0x00f41dac,
    },
    {
        name = "REPORT_DAMAGE_FONT",
        type = CE_MemoryType.std_string,
        addr = 0x00f435d0,
    },
    {
        name = "REPORT_DAMAGE_SCALE",
        type = CE_MemoryType.float_,
        addr = 0x00f41d5c,
    },
    {
        name = "REPORT_DAMAGE_BLOCK_MESSAGE_INTERVAL_FRAMES",
        type = CE_MemoryType.int_,
        addr = 0x00f41d1c,
    },
    {
        name = "GAME_LOG_ENABLED",
        type = CE_MemoryType.bool_,
        addr = 0x00f411f1,
    },
    {
        name = "RANDOMIZE_LARGE_EXPLOSION_RAYS",
        type = CE_MemoryType.bool_,
        addr = 0x00f410c2,
    },
    {
        name = "EXPLOSION_FACTORY_FALLING_DIRT_FX_PROBABILITY",
        type = CE_MemoryType.int_,
        addr = 0x00ff7a58,
    },
    {
        name = "EXPLOSION_FACTORY_STAIN_PERCENTAGE",
        type = CE_MemoryType.float_,
        addr = 0x00f41e18,
    },
    {
        name = "PHYSICS_JOINT_MAX_FORCE_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0x00f411fc,
    },
    {
        name = "PHYSICS_RAGDOLL_JOINT_MAX_FORCE_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0x00f41d9c,
    },
    {
        name = "PHYSICS_RAGDOLL_JOINT_MIN_BREAK_FORCE",
        type = CE_MemoryType.float_,
        addr = 0x00f41d44,
    },
    {
        name = "PHYSICS_RAGDOLL_JOINT_STIFFNESS",
        type = CE_MemoryType.float_,
        addr = 0x00f411bc,
    },
    {
        name = "PHYSICS_RAGDOLL_VERY_STIFF_JOINT_STIFFNESS",
        type = CE_MemoryType.float_,
        addr = 0x00f41b88,
    },
    {
        name = "PHYSICS_FIX_SHELF_BUG",
        type = CE_MemoryType.bool_,
        addr = 0x00ff55ec,
    },
    {
        name = "GUI_HP_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0x00f41d14,
    },
    {
        name = "THROW_UI_TIMESTEP_COEFF",
        type = CE_MemoryType.float_,
        addr = 0x00f41d50,
    },
    {
        name = "VERLET_STAIN_DROP_CHANCE_DIV",
        type = CE_MemoryType.int_,
        addr = 0x00f412e0,
    },
    {
        name = "ITEM_SWITCH_ITEM_TWEEN_TIME_FRAMES",
        type = CE_MemoryType.float_,
        addr = 0x00f410d8,
    },
    {
        name = "APPARITION_MIN_BONES_REQUIRED",
        type = CE_MemoryType.int_,
        addr = 0x00f41d98,
    },
    {
        name = "TELEPORT_ATTACK_COOLDOWN_FRAMES",
        type = CE_MemoryType.int_,
        addr = 0x00f41d90,
    },
    {
        name = "GAMEPLAY_LIVES_ENABLED",
        type = CE_MemoryType.bool_,
        addr = 0x00f41e2b,
    },
    {
        name = "GAMEEFFECT_MOVEMENT_SLOWER_SPEED_MULTIPLIER_MIN",
        type = CE_MemoryType.float_,
        addr = 0x00f42260,
    },
    {
        name = "GAMEEFFECT_MOVEMENT_SLOWER_SPEED_MULTIPLIER_MAX",
        type = CE_MemoryType.float_,
        addr = 0x00f412d8,
    },
    {
        name = "GAMEEFFECT_MOVEMENT_FASTER_SPEED_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0x00f41b70,
    },
    {
        name = "GAMEEFFECT_MOVEMENT_FASTER_2X_SPEED_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0x00f41068,
    },
    {
        name = "GAMEEFFECT_CRITICAL_HIT_BOOST_CRIT_EXTRA_CHANCE",
        type = CE_MemoryType.int_,
        addr = 0x00f412dc,
    },
    {
        name = "GAMEEFFECT_STAINS_DROP_FASTER_DROP_CHANCE_MULTIPLIER",
        type = CE_MemoryType.int_,
        addr = 0x00f41c88,
    },
    {
        name = "GAMEEFFECT_DAMAGE_MULTIPLIER_COEFF",
        type = CE_MemoryType.float_,
        addr = 0x00f41130,
    },
    {
        name = "GAMEEFFECT_INVISIBILITY_SHOT_COOLDOWN_FRAMES",
        type = CE_MemoryType.int_,
        addr = 0x00f41cb8,
    },
    {
        name = "GAMEEFFECT_TELEPORTITIS_COOLDOWN_FRAMES",
        type = CE_MemoryType.int_,
        addr = 0x00f41b78,
    },
    {
        name = "GAMEEFFECT_TELEPORTITIS_DAMAGE_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0x00f41d64,
    },
    {
        name = "GAMEEFFECT_ELECROCUTION_RESISTANCE_DURATION_FRAMES",
        type = CE_MemoryType.int_,
        addr = 0x00f41da4,
    },
    {
        name = "GAMEEFFECT_FIRE_MOVEMENT_SPEED_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0x00f4113c,
    },
    {
        name = "GAMEEFFECT_MANA_REGENERATION_SPEED_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0x00f4125c,
    },
    {
        name = "DAMAGE_CRITICAL_HIT_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0x00f41210,
    },
    {
        name = "GAMEEFFECT_GLOBAL_GORE_GORE_MULTIPLIER",
        type = CE_MemoryType.int_,
        addr = 0x00f411f8,
    },
    {
        name = "GAMEEFFECT_EXTRA_MONEY_TRICK_KILL_MULTIPLIER",
        type = CE_MemoryType.int_,
        addr = 0x00f41d88,
    },
    {
        name = "GAME_OVER_DAMAGE_FLASH_FADE_SPEED_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0x00f411e8,
    },
    {
        name = "INGESTION_AMOUNT_PER_CELL_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0x00f41110,
    },
    {
        name = "INGESTION_SATIATION_PER_CELL",
        type = CE_MemoryType.uint32_t,
        addr = 0x00f41c44,
    },
    {
        name = "INGESTION_OVERINGESTION_MSG_PERIOD",
        type = CE_MemoryType.uint32_t,
        addr = 0x00f41ddc,
    },
    {
        name = "INGESTION_LIMIT_SLOW_MOVEMENT",
        type = CE_MemoryType.float_,
        addr = 0x00f41088,
    },
    {
        name = "INGESTION_LIMIT_DAMAGE",
        type = CE_MemoryType.float_,
        addr = 0x00f41cc0,
    },
    {
        name = "INGESTION_LIMIT_EXPLODING",
        type = CE_MemoryType.float_,
        addr = 0x00f41ca4,
    },
    {
        name = "INGESTION_LIMIT_EXPLOSION",
        type = CE_MemoryType.float_,
        addr = 0x00f41268,
    },
    {
        name = "GAMEPLAY_CHARACTER_LIQUID_FORCES_ENABLED",
        type = CE_MemoryType.bool_,
        addr = 0x00ff7a47,
    },
    {
        name = "COOP_RESPAWN_TIMER_FRAMES",
        type = CE_MemoryType.int_,
        addr = 0x00f42268,
    },
    {
        name = "DROP_LEVEL_1",
        type = CE_MemoryType.float_,
        addr = 0x00f41080,
    },
    {
        name = "DROP_LEVEL_2",
        type = CE_MemoryType.float_,
        addr = 0x00f4226c,
    },
    {
        name = "DROP_LEVEL_3",
        type = CE_MemoryType.float_,
        addr = 0x00f41104,
    },
    {
        name = "DROP_LEVEL_4",
        type = CE_MemoryType.float_,
        addr = 0x00f410b8,
    },
    {
        name = "DROP_LEVEL_5",
        type = CE_MemoryType.float_,
        addr = 0x00f41058,
    },
    {
        name = "DROP_LEVEL_6",
        type = CE_MemoryType.float_,
        addr = 0x00f41d08,
    },
    {
        name = "DROP_LEVEL_7",
        type = CE_MemoryType.float_,
        addr = 0x00f41d30,
    },
    {
        name = "DROP_LEVEL_8",
        type = CE_MemoryType.float_,
        addr = 0x00f4105c,
    },
    {
        name = "DROP_LEVEL_9",
        type = CE_MemoryType.float_,
        addr = 0x00f41dd0,
    },
    {
        name = "BIOME_MAP",
        type = CE_MemoryType.std_string,
        addr = 0x00f43ec8,
    },
    {
        name = "BIOME_APPARITION_CHANCE",
        type = CE_MemoryType.int_,
        addr = 0x00f410cc,
    },
    {
        name = "BIOME_RANDOM_BLOCK_CHANCE",
        type = CE_MemoryType.float_,
        addr = 0x00f41c40,
    },
    {
        name = "BIOME_USE_BIG_WANG",
        type = CE_MemoryType.bool_,
        addr = 0x00f411f2,
    },
    {
        name = "BIOME_PATH_FIND_HEIGHT_LIMIT",
        type = CE_MemoryType.int_,
        addr = 0x00f41e5c,
    },
    {
        name = "BIOME_PATH_FIND_WORLD_POS_MIN_X",
        type = CE_MemoryType.int_,
        addr = 0x00f41158,
    },
    {
        name = "BIOME_PATH_FIND_WORLD_POS_MAX_X",
        type = CE_MemoryType.int_,
        addr = 0x00f41c3c,
    },
    {
        name = "WORLD_SEED",
        type = CE_MemoryType.uint32_t,
        addr = 0x00ff7a18,
    },
    {
        name = "NUM_ORBS_TOTAL",
        type = CE_MemoryType.int_,
        addr = 0x00f410c8,
    },
    {
        name = "CAMERA_MOUSE_INTERPOLATION_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x00f41134,
    },
    {
        name = "CAMERA_GAMEPAD_INTERPOLATION_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x00f41090,
    },
    {
        name = "CAMERA_GAMEPAD_MAX_DISTANCE",
        type = CE_MemoryType.float_,
        addr = 0x00f41b68,
    },
    {
        name = "CAMERA_POSITION_INTERPOLATION_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x00f41cac,
    },
    {
        name = "CAMERA_DISTANCE_INTERPOLATION_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x00f41170,
    },
    {
        name = "CAMERA_NO_MOVE_BUFFER_NEAR_PLAYER",
        type = CE_MemoryType.float_,
        addr = 0x00ff5a30,
    },
    {
        name = "CAMERA_NO_MOVE_BUFFER_NEAR_VIEWPORT_EDGE",
        type = CE_MemoryType.float_,
        addr = 0x00f41138,
    },
    {
        name = "CAMERA_RECOIL_ATTACK_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x00f4112c,
    },
    {
        name = "CAMERA_RECOIL_RELEASE_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x00f41db0,
    },
    {
        name = "CAMERA_RECOIL_AMOUNT",
        type = CE_MemoryType.float_,
        addr = 0x00f412ec,
    },
    {
        name = "MULTIPLAYER_CAMERA_SMOOTHING",
        type = CE_MemoryType.float_,
        addr = 0x00f410a8,
    },
    {
        name = "MULTIPLAYER_CAMERA_MAX_SMOOTH_DISTANCE",
        type = CE_MemoryType.float_,
        addr = 0x00f41b8c,
    },
    {
        name = "CAMERA_IS_UI_OPEN",
        type = CE_MemoryType.bool_,
        addr = 0x00ff7a45,
    },
    {
        name = "PLAYER_USE_NEW_JETPACK",
        type = CE_MemoryType.bool_,
        addr = 0x00ff5616,
    },
    {
        name = "DOUBLE_CLICK_MAX_SPAN_SECONDS",
        type = CE_MemoryType.float_,
        addr = 0x00f41070,
    },
    {
        name = "ESC_QUITS_GAME",
        type = CE_MemoryType.bool_,
        addr = 0x00ff5a5c,
    },
    {
        name = "GAMEPAD_AIMING_VECTOR_SMOOTHING_COEFF",
        type = CE_MemoryType.float_,
        addr = 0x00f41dc4,
    },
    {
        name = "CONTROLS_AIMING_VECTOR_FULL_LENGTH_PIXELS",
        type = CE_MemoryType.float_,
        addr = 0x00f41078,
    },
    {
        name = "GAMEPAD_SHOT_VIBRATION_FORCE_MIN",
        type = CE_MemoryType.float_,
        addr = 0x00f41b74,
    },
    {
        name = "GAMEPAD_SHOT_VIBRATION_FORCE_COEFF",
        type = CE_MemoryType.float_,
        addr = 0x00f41e1c,
    },
    {
        name = "GAMEPAD_SHOT_VIBRATION_TIME_COEFF",
        type = CE_MemoryType.float_,
        addr = 0x00f41204,
    },
    {
        name = "GAMEPAD_ANALOG_FLYING_LOW",
        type = CE_MemoryType.float_,
        addr = 0x00f410f4,
    },
    {
        name = "GAMEPAD_ANALOG_FLYING_HIGH",
        type = CE_MemoryType.float_,
        addr = 0x00f4111c,
    },
    {
        name = "RAGDOLL_FX_EXPLOSION_ROTATION",
        type = CE_MemoryType.float_,
        addr = 0x00f41c8c,
    },
    {
        name = "RAGDOLL_BLOOD_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0x00f41b50,
    },
    {
        name = "RAGDOLL_FIRE_DEATH_IGNITE_EVERY_N_PIXEL",
        type = CE_MemoryType.int_,
        addr = 0x00f41b54,
    },
    {
        name = "RAGDOLL_IMPULSE_RANDOMNESS",
        type = CE_MemoryType.float_,
        addr = 0x00f410d4,
    },
    {
        name = "RAGDOLL_OWN_VELOCITY_IMPULSE_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0x00f41344,
    },
    {
        name = "RAGDOLL_CRITICAL_HIT_FORCE_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0x00f41cc4,
    },
    {
        name = "DAMAGE_BLOOD_AMOUNT_MIN",
        type = CE_MemoryType.int_,
        addr = 0x00f41e3c,
    },
    {
        name = "DAMAGE_BLOOD_AMOUNT_MAX",
        type = CE_MemoryType.int_,
        addr = 0x00f410d0,
    },
    {
        name = "DAMAGE_FIRE_DAMAGE_MAX_HP_MIN_BOUND",
        type = CE_MemoryType.float_,
        addr = 0x00f4109c,
    },
    {
        name = "DAMAGE_BLOOD_SPRAY_CHANCE",
        type = CE_MemoryType.int_,
        addr = 0x00f41b80,
    },
    {
        name = "EXPLOSION_FACTORY_GORE_FX_PROBABLITY",
        type = CE_MemoryType.int_,
        addr = 0x00f410e8,
    },
    {
        name = "EXPLOSION_FACTORY_GORE_FX_HOLE_PROBABILITY",
        type = CE_MemoryType.int_,
        addr = 0x00f4108c,
    },
    {
        name = "EXPLOSION_FACTORY_GORE_FX_BLOOD_STAIN_COLOR",
        type = CE_MemoryType.uint32_t,
        addr = 0x00f41174,
    },
    {
        name = "GRID_MAX_UPDATES_PER_FRAME",
        type = CE_MemoryType.int_,
        addr = 0x00f41e58,
    },
    {
        name = "GRID_FLEXIBLE_MAX_UPDATES",
        type = CE_MemoryType.bool_,
        addr = 0x00ff5625,
    },
    {
        name = "GRID_MIN_UPDATES_PER_FRAME",
        type = CE_MemoryType.int_,
        addr = 0x00f41150,
    },
    {
        name = "CELLFACTORY_CELLDATA_MAX_COUNT",
        type = CE_MemoryType.int_,
        addr = 0x00f41b60,
    },
    {
        name = "PARTICLE_EMITTER_MAX_PARTICLES",
        type = CE_MemoryType.int_,
        addr = 0x00f41b64,
    },
    {
        name = "VIRTUAL_RESOLUTION_X",
        type = CE_MemoryType.int_,
        addr = 0x00f41c48,
    },
    {
        name = "VIRTUAL_RESOLUTION_Y",
        type = CE_MemoryType.int_,
        addr = 0x00f410dc,
    },
    {
        name = "VIRTUAL_RESOLUTION_OFFSET_X",
        type = CE_MemoryType.float_,
        addr = 0x00f41284,
    },
    {
        name = "VIRTUAL_RESOLUTION_OFFSET_Y",
        type = CE_MemoryType.float_,
        addr = 0x00f411dc,
    },
    {
        name = "GRID_RENDER_BORDER",
        type = CE_MemoryType.int_,
        addr = 0x00f41e30,
    },
    {
        name = "GRID_RENDER_TILE_SIZE",
        type = CE_MemoryType.int_,
        addr = 0x00f411e4,
    },
    {
        name = "DRAW_PARALLAX_BACKGROUND",
        type = CE_MemoryType.bool_,
        addr = 0x00f41cb4,
    },
    {
        name = "DRAW_PARALLAX_BACKGROUND_BEFORE_DEPTH",
        type = CE_MemoryType.float_,
        addr = 0x00f410fc,
    },
    {
        name = "RENDER_PARALLAX_BACKGROUND_SHADER_GRADIENT",
        type = CE_MemoryType.bool_,
        addr = 0x00ff79db,
    },
    {
        name = "RENDER_SKYLIGHT_MAX_REDUCTION_AMOUNT",
        type = CE_MemoryType.float_,
        addr = 0x00f41d2c,
    },
    {
        name = "RENDER_SKYLIGHT_ABOVE_WEIGHT",
        type = CE_MemoryType.float_,
        addr = 0x00f41144,
    },
    {
        name = "RENDER_SKYLIGHT_SIDES_WEIGHT",
        type = CE_MemoryType.float_,
        addr = 0x00f411d8,
    },
    {
        name = "RENDER_SKYLIGHT_TOTAL_WEIGHT",
        type = CE_MemoryType.float_,
        addr = 0x00f41cc8,
    },
    {
        name = "RENDER_FIRE_LO_TIME",
        type = CE_MemoryType.float_,
        addr = 0x00f411f4,
    },
    {
        name = "RENDER_FIRE_LO_SCALE",
        type = CE_MemoryType.float_,
        addr = 0x00f4116c,
    },
    {
        name = "RENDER_FIRE_LO_FORCE",
        type = CE_MemoryType.float_,
        addr = 0x00f412fc,
    },
    {
        name = "RENDER_FIRE_HI_TIME",
        type = CE_MemoryType.float_,
        addr = 0x00f410bc,
    },
    {
        name = "RENDER_FIRE_HI_SCALE",
        type = CE_MemoryType.float_,
        addr = 0x00f410e0,
    },
    {
        name = "RENDER_FIRE_HI_FORCE",
        type = CE_MemoryType.float_,
        addr = 0x00ff5628,
    },
    {
        name = "RENDER_FIRE_GRAVITY",
        type = CE_MemoryType.float_,
        addr = 0x00f4126c,
    },
    {
        name = "RENDER_FIRE_LIFETIME_MIN",
        type = CE_MemoryType.int_,
        addr = 0x00f41e38,
    },
    {
        name = "RENDER_FIRE_LIFETIME_MAX",
        type = CE_MemoryType.int_,
        addr = 0x00f411d4,
    },
    {
        name = "RENDER_FIRE_GLOW_ALPHA",
        type = CE_MemoryType.float_,
        addr = 0x00f41118,
    },
    {
        name = "RENDER_FIRE_SHARP_ALPHA",
        type = CE_MemoryType.float_,
        addr = 0x00f41e2c,
    },
    {
        name = "RENDER_POTION_PARTICLE_MAX_COLOR_COMPONENT",
        type = CE_MemoryType.float_,
        addr = 0x00f41d8c,
    },
    {
        name = "RENDER_color_grading_LERP_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x00f41ca0,
    },
    {
        name = "TELEPORT_FLASH_COLOR_R",
        type = CE_MemoryType.float_,
        addr = 0x00ff640c,
    },
    {
        name = "TELEPORT_FLASH_COLOR_G",
        type = CE_MemoryType.float_,
        addr = 0x00ff6418,
    },
    {
        name = "TELEPORT_FLASH_COLOR_B",
        type = CE_MemoryType.float_,
        addr = 0x00ff7a98,
    },
    {
        name = "AUDIO_GAMEEFFECT_FIRE_WEIGHT",
        type = CE_MemoryType.float_,
        addr = 0x00f411e0,
    },
    {
        name = "AUDIO_FIRE_WEIGHT",
        type = CE_MemoryType.float_,
        addr = 0x00f41dd8,
    },
    {
        name = "AUDIO_MAGICAL_MATERIAL_WEIGHT",
        type = CE_MemoryType.float_,
        addr = 0x00f41114,
    },
    {
        name = "AUDIO_GAME_START_FADE_FRAME",
        type = CE_MemoryType.float_,
        addr = 0x00f41200,
    },
    {
        name = "AUDIO_GAME_START_FADE_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x00f41108,
    },
    {
        name = "AUDIO_MUSIC_VOLUME_DEFAULT",
        type = CE_MemoryType.float_,
        addr = 0x00f410f0,
    },
    {
        name = "AUDIO_MUSIC_QUIET_FADE_DOWN_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x00f4123c,
    },
    {
        name = "AUDIO_MUSIC_NORMAL_FADE_DOWN_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x00f41d94,
    },
    {
        name = "AUDIO_MUSIC_NORMAL_FADE_UP_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x00f41d4c,
    },
    {
        name = "AUDIO_MUSIC_ACTION_FADE_DOWN_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x00f4120c,
    },
    {
        name = "AUDIO_MUSIC_ACTION_FADE_UP_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x00f41d10,
    },
    {
        name = "AUDIO_MUSIC_LOW_ENERGY_TRIGGER_COOLDOWN_SECONDS",
        type = CE_MemoryType.double_,
        addr = 0x00f41178,
    },
    {
        name = "AUDIO_MUSIC_FORCED_QUIETNESS_TRIGGERS_AFTER_SECONDS",
        type = CE_MemoryType.int_,
        addr = 0x00f41264,
    },
    {
        name = "AUDIO_MUSIC_FORCED_QUIETNESS_DURATION_SECONDS",
        type = CE_MemoryType.int_,
        addr = 0x00f4107c,
    },
    {
        name = "AUDIO_COLLISION_SIZE_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0x00f411b8,
    },
    {
        name = "AUDIO_COLLISION_SPEED_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0x00f41208,
    },
    {
        name = "AUDIO_COLLISION_KICK_SIZE",
        type = CE_MemoryType.float_,
        addr = 0x00f41d58,
    },
    {
        name = "AUDIO_COLLISION_COOLDOWN_SECONDS",
        type = CE_MemoryType.float_,
        addr = 0x00f41180,
    },
    {
        name = "AUDIO_COLLISION_STATIC_WALL_INTENSITY",
        type = CE_MemoryType.float_,
        addr = 0x00f41d28,
    },
    {
        name = "AUDIO_COLLISION_STATIC_WALL_SPEED_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0x00f41d54,
    },
    {
        name = "AUDIO_PHYSICS_BREAK_MASS_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0x00f41c98,
    },
    {
        name = "AUDIO_CHARACTER_LIQUID_SPLASH_INTENSITY_MIN",
        type = CE_MemoryType.float_,
        addr = 0x00ff79dc,
    },
    {
        name = "AUDIO_CHARACTER_LIQUID_SPLASH_INTENSITY_MAX",
        type = CE_MemoryType.float_,
        addr = 0x00f41da0,
    },
    {
        name = "AUDIO_CHARACTER_LIQUID_SPLASH_INTENSITY_SPEED_DIV",
        type = CE_MemoryType.float_,
        addr = 0x00f41cb0,
    },
    {
        name = "AUDIO_EXPLOSION_NO_SOUND_BELOW_RADIUS",
        type = CE_MemoryType.float_,
        addr = 0x00f41288,
    },
    {
        name = "AUDIO_EXPLOSION_SMALL_SOUND_MAX_RADIUS",
        type = CE_MemoryType.float_,
        addr = 0x00f41e24,
    },
    {
        name = "AUDIO_PICK_GOLD_SAND_MIN_AMOUNT_FOR_SOUND",
        type = CE_MemoryType.int_,
        addr = 0x00f4115c,
    },
    {
        name = "AUDIO_PICK_GOLD_SAND_AMOUNT_ACCUMULATION_FRAMES",
        type = CE_MemoryType.int_,
        addr = 0x00f41b48,
    },
    {
        name = "AUDIO_AMBIENCE_ALTITUDE_SCALE",
        type = CE_MemoryType.float_,
        addr = 0x00f41304,
    },
    {
        name = "AUDIO_CREDITS_TRACK_NAME",
        type = CE_MemoryType.std_string,
        addr = 0x00f43960,
    },
    {
        name = "PATHFINDING_DISTANCE_FIELD_ENABLED",
        type = CE_MemoryType.bool_,
        addr = 0x00f41087,
    },
    {
        name = "STREAMING_ENABLED",
        type = CE_MemoryType.bool_,
        addr = 0x00f41064,
    },
    {
        name = "STREAMING_FREQUENCY",
        type = CE_MemoryType.double_,
        addr = 0x00f41278,
    },
    {
        name = "STREAMING_CHUNK_TARGET",
        type = CE_MemoryType.int_,
        addr = 0x00f41dcc,
    },
    {
        name = "STREAMING_PERSISTENT_WORLD",
        type = CE_MemoryType.bool_,
        addr = 0x00f411f3,
    },
    {
        name = "STREAMING_AUTOSAVE_PERIOD_SECONDS",
        type = CE_MemoryType.int_,
        addr = 0x00f41164,
    },
    {
        name = "INVENTORY_ICON_SIZE",
        type = CE_MemoryType.int_,
        addr = 0x00f41db4,
    },
    {
        name = "INVENTORY_STASH_X",
        type = CE_MemoryType.float_,
        addr = 0x00f41d74,
    },
    {
        name = "INVENTORY_STASH_Y",
        type = CE_MemoryType.float_,
        addr = 0x00f412f0,
    },
    {
        name = "INVENTORY_DEBUG_X",
        type = CE_MemoryType.float_,
        addr = 0x00f41db8,
    },
    {
        name = "INVENTORY_DEBUG_Y",
        type = CE_MemoryType.float_,
        addr = 0x00f41d84,
    },
    {
        name = "UI_SNAP_TO_NEAREST_INTEGER_SCALE",
        type = CE_MemoryType.bool_,
        addr = 0x00f410c0,
    },
    {
        name = "UI_BARS_SCALE",
        type = CE_MemoryType.float_,
        addr = 0x00f41d20,
    },
    {
        name = "UI_BARS_POS_X",
        type = CE_MemoryType.float_,
        addr = 0x00f41b84,
    },
    {
        name = "UI_BARS_POS_Y",
        type = CE_MemoryType.float_,
        addr = 0x00f4114c,
    },
    {
        name = "UI_BARS2_OFFSET_X",
        type = CE_MemoryType.float_,
        addr = 0x00f41da8,
    },
    {
        name = "UI_PLAYER_FULL_STATS_POS_X",
        type = CE_MemoryType.float_,
        addr = 0x00f412d0,
    },
    {
        name = "UI_PLAYER_FULL_STATS_POS_Y",
        type = CE_MemoryType.float_,
        addr = 0x00f41c9c,
    },
    {
        name = "UI_PLAYER_FULL_STATS_COLUMN2_OFFSET_X",
        type = CE_MemoryType.float_,
        addr = 0x00f410a4,
    },
    {
        name = "UI_PLAYER_FULL_STATS_COLUMN3_OFFSET_X",
        type = CE_MemoryType.float_,
        addr = 0x00f41dc8,
    },
    {
        name = "UI_STAT_BAR_EXTRA_SPACING",
        type = CE_MemoryType.float_,
        addr = 0x00f42264,
    },
    {
        name = "UI_STAT_BAR_ICON_OFFSET_Y",
        type = CE_MemoryType.float_,
        addr = 0x00ff5a44,
    },
    {
        name = "UI_STAT_BAR_TEXT_OFFSET_X",
        type = CE_MemoryType.float_,
        addr = 0x00f41098,
    },
    {
        name = "UI_STAT_BAR_TEXT_OFFSET_Y",
        type = CE_MemoryType.float_,
        addr = 0x00ff55e4,
    },
    {
        name = "UI_QUICKBAR_OFFSET_X",
        type = CE_MemoryType.float_,
        addr = 0x00ff5c00,
    },
    {
        name = "UI_QUICKBAR_OFFSET_Y",
        type = CE_MemoryType.float_,
        addr = 0x00ff79f8,
    },
    {
        name = "UI_INVENTORY_BACKGROUND_POSITION_X",
        type = CE_MemoryType.float_,
        addr = 0x00ff7a08,
    },
    {
        name = "UI_INVENTORY_BACKGROUND_POSITION_Y",
        type = CE_MemoryType.float_,
        addr = 0x00ff55c8,
    },
})
table_extend(developer_items, {
    {
        name = "UI_FULL_INVENTORY_OFFSET_X",
        type = CE_MemoryType.float_,
        addr = 0x00f4110c,
    },
    {
        name = "UI_IMPORTANT_MESSAGE_POS_Y",
        type = CE_MemoryType.int_,
        addr = 0x00f412f4,
    },
    {
        name = "UI_IMPORTANT_MESSAGE_TITLE_SCALE",
        type = CE_MemoryType.float_,
        addr = 0x00f41d7c,
    },
    {
        name = "UI_LOW_HP_THRESHOLD",
        type = CE_MemoryType.float_,
        addr = 0x00f41238,
    },
    {
        name = "UI_LOW_HP_WARNING_FLASH_FREQUENCY",
        type = CE_MemoryType.float_,
        addr = 0x00f4121c,
    },
    {
        name = "UI_PIXEL_FONT_GAME_LOG",
        type = CE_MemoryType.bool_,
        addr = 0x00f41085,
    },
    {
        name = "UI_PAUSE_MENU_LAYOUT_TOP_EDGE_PERCENTAGE",
        type = CE_MemoryType.int_,
        addr = 0x00f41d34,
    },
    {
        name = "UI_GAME_OVER_MENU_LAYOUT_TOP_EDGE_PERCENTAGE",
        type = CE_MemoryType.int_,
        addr = 0x00f41148,
    },
    {
        name = "UI_WOBBLE_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x00f4133c,
    },
    {
        name = "UI_WOBBLE_AMOUNT_DEGREES",
        type = CE_MemoryType.float_,
        addr = 0x00f41e34,
    },
    {
        name = "UI_GAMEOVER_SCREEN_BOX_FROM_TOP_PERCENT",
        type = CE_MemoryType.float_,
        addr = 0x00f41310,
    },
    {
        name = "UI_GAMEOVER_SCREEN_BOX_FROM_SIDE_PERCENT",
        type = CE_MemoryType.float_,
        addr = 0x00f411b4,
    },
    {
        name = "UI_GAMEOVER_SCREEN_BOX_FROM_BOTTOM_PERCENT",
        type = CE_MemoryType.float_,
        addr = 0x00f412e4,
    },
    {
        name = "UI_GAMEOVER_SCREEN_MUSIC_CUE_TIMER_FRAMES",
        type = CE_MemoryType.int_,
        addr = 0x00f41d48,
    },
    {
        name = "UI_COOP_QUICK_INVENTORY_HEIGHT",
        type = CE_MemoryType.float_,
        addr = 0x00f41100,
    },
    {
        name = "UI_COOP_STAT_BARS_HEIGHT",
        type = CE_MemoryType.float_,
        addr = 0x00f4128c,
    },
    {
        name = "UI_SCALE_IN_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x00f41cbc,
    },
    {
        name = "UI_DAMAGE_INDICATOR_RANDOM_OFFSET",
        type = CE_MemoryType.float_,
        addr = 0x00f4106c,
    },
    {
        name = "UI_ITEM_STAND_OVER_INFO_BOX_OFFSET_X",
        type = CE_MemoryType.float_,
        addr = 0x00f412d4,
    },
    {
        name = "UI_ITEM_STAND_OVER_INFO_BOX_OFFSET_Y",
        type = CE_MemoryType.float_,
        addr = 0x00f41160,
    },
    {
        name = "UI_MOUSE_WORLD_HOVER_TEXT_OFFSET_X",
        type = CE_MemoryType.float_,
        addr = 0x00f412cc,
    },
    {
        name = "UI_MOUSE_WORLD_HOVER_TEXT_OFFSET_Y",
        type = CE_MemoryType.float_,
        addr = 0x00f41c94,
    },
    {
        name = "UI_MAX_PERKS_VISIBLE",
        type = CE_MemoryType.int_,
        addr = 0x00f41094,
    },
    {
        name = "UI_LOCALIZE_RECORD_TEXT",
        type = CE_MemoryType.bool_,
        addr = 0x00ff640a,
    },
    {
        name = "UI_DISPLAY_NUMBERS_WITH_KS_AND_MS",
        type = CE_MemoryType.bool_,
        addr = 0x00f41168,
    },
    {
        name = "MAIN_MENU_BG_OFFSET_X",
        type = CE_MemoryType.float_,
        addr = 0x00f41154,
    },
    {
        name = "MAIN_MENU_BG_OFFSET_Y",
        type = CE_MemoryType.float_,
        addr = 0x00f41dd4,
    },
    {
        name = "MAIN_MENU_BG_OFFSET_Y_END",
        type = CE_MemoryType.float_,
        addr = 0x00f41c38,
    },
    {
        name = "MAIN_MENU_BG_TWEEN_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x00f41c90,
    },
    {
        name = "USE_CUSTOM_THREADPOOL",
        type = CE_MemoryType.bool_,
        addr = 0x00f41d26,
    },
    {
        name = "BOX2D_FREEZE_STUCK_BODIES",
        type = CE_MemoryType.bool_,
        addr = 0x00f41daf,
    },
    {
        name = "BOX2D_THREAD_MAX_WAIT_IN_MS",
        type = CE_MemoryType.float_,
        addr = 0x00f41dc0,
    },
    {
        name = "CREDITS_SCROLL_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x00f41260,
    },
    {
        name = "CREDITS_SCROLL_END_OFFSET_EXTRA",
        type = CE_MemoryType.float_,
        addr = 0x00f411ec,
    },
    {
        name = "CREDITS_SCROLL_SKIP_SPEED_MULTIPLIER",
        type = CE_MemoryType.float_,
        addr = 0x00f4130c,
    },
    {
        name = "INTRO_WEATHER_FOG",
        type = CE_MemoryType.float_,
        addr = 0x00f41d0c,
    },
    {
        name = "INTRO_WEATHER_RAIN",
        type = CE_MemoryType.float_,
        addr = 0x00f41d40,
    },
    {
        name = "SETTINGS_MIN_RESOLUTION_X",
        type = CE_MemoryType.int_,
        addr = 0x00f41060,
    },
    {
        name = "SETTINGS_MIN_RESOLUTION_Y",
        type = CE_MemoryType.int_,
        addr = 0x00f41308,
    },
    {
        name = "STEAM_CLOUD_SIZE_WARNING",
        type = CE_MemoryType.bool_,
        addr = 0x00ff7a43,
    },
    {
        name = "DEBUG_KEYS_ENABLED",
        type = CE_MemoryType.bool_,
        addr = 0x00f41122,
    },
    {
        name = "DEBUG_EXTRA_SCREENSHOT_KEYS_ENABLED",
        type = CE_MemoryType.bool_,
        addr = 0x00f41067,
    },
    {
        name = "DEBUG_USE_PRELOAD",
        type = CE_MemoryType.bool_,
        addr = 0x00f41169,
    },
    {
        name = "DEBUG_USE_DEBUG_PRELOAD",
        type = CE_MemoryType.bool_,
        addr = 0x00ff5a3f,
    },
    {
        name = "DEBUG_TREES",
        type = CE_MemoryType.bool_,
        addr = 0x00ff79ff,
    },
    {
        name = "DEBUG_PIXEL_SCENES",
        type = CE_MemoryType.bool_,
        addr = 0x00ff5bfb,
    },
    {
        name = "DEBUG_TELEPORT",
        type = CE_MemoryType.bool_,
        addr = 0x00ff5626,
    },
    {
        name = "DEBUG_SI_TYPE",
        type = CE_MemoryType.int_,
        addr = 0x00ff5c04,
    },
    {
        name = "DEBUG_AUDIO_DEV_MODE",
        type = CE_MemoryType.bool_,
        addr = 0x00ff55d1,
    },
    {
        name = "DEBUG_AUDIO_MUTE",
        type = CE_MemoryType.bool_,
        addr = 0x00ff55d3,
    },
    {
        name = "DEBUG_AUDIO_MUSIC_MUTE",
        type = CE_MemoryType.bool_,
        addr = 0x00ff55e2,
    },
    {
        name = "DEBUG_AUDIO_VOLUME",
        type = CE_MemoryType.float_,
        addr = 0x00f41b58,
    },
    {
        name = "DEBUG_TEST_SYMBOL_CLASSIFIER",
        type = CE_MemoryType.bool_,
        addr = 0x00ff6415,
    },
    {
        name = "DEBUG_STREAMING_DISABLE_SAVING",
        type = CE_MemoryType.bool_,
        addr = 0x00ff79d9,
    },
    {
        name = "DEBUG_DRAW_ANIMAL_AI_STATE",
        type = CE_MemoryType.bool_,
        addr = 0x00ff5a74,
    },
    {
        name = "DEBUG_PRINT_COMPONENT_UPDATOR_ORDER",
        type = CE_MemoryType.bool_,
        addr = 0x00ff5bfa,
    },
    {
        name = "DEBUG_SKYLIGHT_NO_SIMD",
        type = CE_MemoryType.bool_,
        addr = 0x00ff560a,
    },
    {
        name = "DEBUG_DISABLE_MOUSE_SCROLL_WHEEL",
        type = CE_MemoryType.bool_,
        addr = 0x00ff7a46,
    },
    {
        name = "DEBUG_NO_SAVEGAME_CLEAR_ON_GAME_OVER",
        type = CE_MemoryType.bool_,
        addr = 0x00ff7a72,
    },
    {
        name = "DEBUG_CAMERA_SHAKE_OFFSET",
        type = CE_MemoryType.float_,
        addr = 0x00ff5bfc,
    },
    {
        name = "DEBUG_FREE_CAMERA_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x00f41218,
    },
    {
        name = "DEBUG_DISABLE_POSTFX_DITHERING",
        type = CE_MemoryType.bool_,
        addr = 0x00ff7a5e,
    },
    {
        name = "DEBUG_SCREENSHOTS_VIDEO_PATH_PREFIX",
        type = CE_MemoryType.std_string,
        addr = 0x00f43eb0,
    },
    {
        name = "DEBUG_GIF_WIDTH",
        type = CE_MemoryType.int_,
        addr = 0x00f410f8,
    },
    {
        name = "DEBUG_GIF_HEIGHT",
        type = CE_MemoryType.int_,
        addr = 0x00f410ac,
    },
    {
        name = "DEBUG_GIF_RECORD_60FPS",
        type = CE_MemoryType.bool_,
        addr = 0x00ff7a9e,
    },
    {
        name = "DEBUG_SPRITE_UV_GEN_REPORT_MISSING_FILES",
        type = CE_MemoryType.bool_,
        addr = 0x00ff560b,
    },
    {
        name = "DEBUG_NO_PAUSE_ON_WINDOW_FOCUS_LOST",
        type = CE_MemoryType.bool_,
        addr = 0x00ff79fe,
    },
    {
        name = "DEBUG_DEMO_MODE",
        type = CE_MemoryType.bool_,
        addr = 0x00ff55d2,
    },
    {
        name = "DEBUG_DEMO_MODE_RESET_TIMEOUT_FRAMES",
        type = CE_MemoryType.int_,
        addr = 0x00f41d78,
    },
    {
        name = "DEBUG_DEMO_MODE_RESET_WARNING_TIME_FRAMES",
        type = CE_MemoryType.int_,
        addr = 0x00f412c8,
    },
    {
        name = "DEBUG_DISABLE_PHYSICSBODY_OUT_OF_BOUNDS_WARNING",
        type = CE_MemoryType.bool_,
        addr = 0x00ff5a77,
    },
    {
        name = "DEBUG_ENABLE_AUTOSAVE",
        type = CE_MemoryType.bool_,
        addr = 0x00f41e28,
    },
    {
        name = "DEBUG_AUDIO_WRITE_TO_FILE",
        type = CE_MemoryType.bool_,
        addr = 0x00ff5a5d,
    },
    {
        name = "DEBUG_NO_LOGO_SPLASHES",
        type = CE_MemoryType.bool_,
        addr = 0x00ff55ee,
    },
    {
        name = "DEBUG_TEST_SAVE_SPAWN_X",
        type = CE_MemoryType.float_,
        addr = 0x00f41d18,
    },
    {
        name = "DEBUG_INTRO_PLAY_ALWAYS",
        type = CE_MemoryType.bool_,
        addr = 0x00ff7a28,
    },
    {
        name = "DEBUG_REPLAY_RECORDER_FPS",
        type = CE_MemoryType.int_,
        addr = 0x00f410ec,
    },
    {
        name = "DEBUG_F12_OPEN_FOG_OF_WAR",
        type = CE_MemoryType.bool_,
        addr = 0x00f41281,
    },
    {
        name = "DEBUG_ALWAYS_COMPLETE_THE_GAME",
        type = CE_MemoryType.bool_,
        addr = 0x00ff55f9,
    },
    {
        name = "DEBUG_SKIP_RELEASE_NOTES",
        type = CE_MemoryType.bool_,
        addr = 0x00ff55cd,
    },
    {
        name = "DEBUG_SKIP_MAIN_MENU",
        type = CE_MemoryType.bool_,
        addr = 0x00ff7a76,
    },
    {
        name = "DEBUG_SKIP_ALL_START_MENUS",
        type = CE_MemoryType.bool_,
        addr = 0x00ff560d,
    },
    {
        name = "DEBUG_PLAYER_NEVER_DIES",
        type = CE_MemoryType.bool_,
        addr = 0x00ff55fb,
    },
    {
        name = "DEBUG_ALWAYS_GET_UNLOCKS",
        type = CE_MemoryType.bool_,
        addr = 0x00ff7a64,
    },
    {
        name = "DEBUG_PROFILE_ALLOCATOR",
        type = CE_MemoryType.bool_,
        addr = 0x00ff55fa,
    },
    {
        name = "DEBUG_STREAMING_INTEGRATION_DEV_MODE",
        type = CE_MemoryType.bool_,
        addr = 0x00ff55ce,
    },
    {
        name = "DEBUG_UI_ALL_THE_CARDS_WIDTH",
        type = CE_MemoryType.int_,
        addr = 0x00f41214,
    },
    {
        name = "DEBUG_UI_ALL_THE_CARDS_HEIGHT",
        type = CE_MemoryType.int_,
        addr = 0x00f41d60,
    },
    {
        name = "DEBUG_UI_ALL_THE_CARDS_DISPLAY_EXTRA_INFO",
        type = CE_MemoryType.bool_,
        addr = 0x00f41b7d,
    },
    {
        name = "DEBUG_PERSISTENT_FLAGS_DISABLED",
        type = CE_MemoryType.bool_,
        addr = 0x00ff5608,
    },
    {
        name = "DEBUG_LOG_LEVEL",
        type = CE_MemoryType.int_,
        addr = 0x00f410a0,
    },
    {
        name = "DEBUG_LOG_STD_COUT",
        type = CE_MemoryType.bool_,
        addr = 0x00f41e29,
    },
    {
        name = "DEBUG_LOG_SOLID_BACKGROUND",
        type = CE_MemoryType.int_,
        addr = 0x00f41b5c,
    },
    {
        name = "DEBUG_LOG_TODO_ERRORS",
        type = CE_MemoryType.bool_,
        addr = 0x00f4116b,
    },
    {
        name = "DEBUG_LOG_INSTANT_FLUSH",
        type = CE_MemoryType.bool_,
        addr = 0x00ff5624,
    },
    {
        name = "DEBUG_LOG_NEVER_VISIBLE",
        type = CE_MemoryType.bool_,
        addr = 0x00ff79fc,
    },
    {
        name = "DEBUG_ALWAYS_RANDOM_SEED",
        type = CE_MemoryType.bool_,
        addr = 0x00ff55cc,
    },
    {
        name = "DEBUG_ALWAYS_RANDOM_START_POS",
        type = CE_MemoryType.bool_,
        addr = 0x00ff79f1,
    },
    {
        name = "DEBUG_LUA_REPORT_SLOW_SCRIPTS",
        type = CE_MemoryType.bool_,
        addr = 0x00ff6417,
    },
    {
        name = "DEBUG_LUA",
        type = CE_MemoryType.bool_,
        addr = 0x00ff6409,
    },
    {
        name = "DEBUG_LUA_REPORT_PRINT_FILES",
        type = CE_MemoryType.bool_,
        addr = 0x00ff7a75,
    },
    {
        name = "DEBUG_LUA_LOG_BIOME_SPAWN_SCRIPTS",
        type = CE_MemoryType.bool_,
        addr = 0x00ff7a5f,
    },
    {
        name = "DEBUG_LUA_REPORT_BIOME_SPAWN_ERRORS",
        type = CE_MemoryType.bool_,
        addr = 0x00f41065,
    },
    {
        name = "DEBUG_GAME_LOG_SHOW_DRAWN_ACTIONS",
        type = CE_MemoryType.bool_,
        addr = 0x00ff560c,
    },
    {
        name = "DEBUG_LOG_STREAMING_STATS",
        type = CE_MemoryType.bool_,
        addr = 0x00f41b7c,
    },
    {
        name = "DEBUG_LOG_LIFETIME_COMPONENT_DANGLING_PARENTS",
        type = CE_MemoryType.bool_,
        addr = 0x00ff5a76,
    },
    {
        name = "DEBUG_OLLI_CONFIG",
        type = CE_MemoryType.bool_,
        addr = 0x00ff7a9f,
    },
    {
        name = "DEBUG_GENERATE_BIG_WANG_MAP",
        type = CE_MemoryType.bool_,
        addr = 0x00ff55d0,
    },
    {
        name = "DEBUG_CRASH_IF_OLD_VERSION",
        type = CE_MemoryType.bool_,
        addr = 0x00f41086,
    },
    {
        name = "DEBUG_RESTART_GAME_IF_OLD_VERSION",
        type = CE_MemoryType.bool_,
        addr = 0x00ff7a5d,
    },
    {
        name = "DEBUG_CAMERABOUND_DISPLAY_ENTITIES",
        type = CE_MemoryType.bool_,
        addr = 0x00ff5609,
    },
    {
        name = "DEBUG_PROFILER_CAPTURE_OLLI_STYLE",
        type = CE_MemoryType.bool_,
        addr = 0x00f410c1,
    },
    {
        name = "DEBUG_PROFILER_CAPTURE_PETRI_STYLE",
        type = CE_MemoryType.bool_,
        addr = 0x00ff7a41,
    },
    {
        name = "DEBUG_PAUSE_BOX2D",
        type = CE_MemoryType.bool_,
        addr = 0x00ff7a65,
    },
    {
        name = "DEBUG_PAUSE_GRID_UPDATE",
        type = CE_MemoryType.bool_,
        addr = 0x00ff7a9c,
    },
    {
        name = "DEBUG_PAUSE_SIMULATION",
        type = CE_MemoryType.bool_,
        addr = 0x00ff5614,
    },
    {
        name = "DEBUG_SCREENSHOTTER_ENABLED",
        type = CE_MemoryType.bool_,
        addr = 0x00f41b7e,
    },
    {
        name = "DEBUG_SCREENSHOTTER_SAVE_PPNG",
        type = CE_MemoryType.bool_,
        addr = 0x00f41084,
    },
    {
        name = "DEBUG_SCREENSHOTTER_FFMPEG_PATH",
        type = CE_MemoryType.std_string,
        addr = 0x00f42378,
    },
    {
        name = "DEBUG_PETRI_TAKE_RANDOM_SHADERSHOT",
        type = CE_MemoryType.bool_,
        addr = 0x00ff55ed,
    },
    {
        name = "DEBUG_THREADED_WORLD_CREATION",
        type = CE_MemoryType.bool_,
        addr = 0x00f4116a,
    },
    {
        name = "DEBUG_PETRI_START",
        type = CE_MemoryType.bool_,
        addr = 0x00ff5617,
    },
    {
        name = "DEBUG_ATTRACT_MODE",
        type = CE_MemoryType.bool_,
        addr = 0x00ff7a44,
    },
    {
        name = "DEBUG_PREV_OPENED_ENTITY",
        type = CE_MemoryType.std_string,
        addr = 0x00f43668,
    },
    {
        name = "DEBUG_CTRL_O_USES_PREV_ENTITY_ALWAYS",
        type = CE_MemoryType.bool_,
        addr = 0x00ff6408,
    },
    {
        name = "DEBUG_WANG",
        type = CE_MemoryType.bool_,
        addr = 0x00ff7a14,
    },
    {
        name = "DEBUG_WANG_PATH",
        type = CE_MemoryType.bool_,
        addr = 0x00ff6416,
    },
    {
        name = "DEBUG_FULL_WANG_MAPS",
        type = CE_MemoryType.bool_,
        addr = 0x00ff7a40,
    },
    {
        name = "DEBUG_MATERIAL_AREA_CHECKER",
        type = CE_MemoryType.bool_,
        addr = 0x00ff79fd,
    },
    {
        name = "DEBUG_COLLISION_TRIGGERS",
        type = CE_MemoryType.bool_,
        addr = 0x00ff7a74,
    },
    {
        name = "DEBUG_SINGLE_THREADED_LOADING",
        type = CE_MemoryType.bool_,
        addr = 0x00ff5a5f,
    },
    {
        name = "DEBUG_TEXT_ENABLE_WORK_MODE",
        type = CE_MemoryType.bool_,
        addr = 0x00ff55ef,
    },
    {
        name = "DEBUG_TEXT_WRITE_MISSING_TRANSLATIONS",
        type = CE_MemoryType.bool_,
        addr = 0x00ff6414,
    },
    {
        name = "DEBUG_HOTLOAD_MATERIAL_EDGES",
        type = CE_MemoryType.bool_,
        addr = 0x00ff79f2,
    },
    {
        name = "DEBUG_IMGUI_HOT_LOAD_ENABLED",
        type = CE_MemoryType.bool_,
        addr = 0x00f41b7f,
    },
    {
        name = "_DEBUG_DONT_LOAD_OTHER_MAGIC_NUMBERS",
        type = CE_MemoryType.bool_,
        addr = 0x00ff7a67,
    },
    {
        name = "_DEBUG_DONT_SAVE_MAGIC_NUMBERS",
        type = CE_MemoryType.bool_,
        addr = 0x00ff7a66,
    },
    {
        name = "DESIGN_DAILY_RANDOM_STARTING_ITEMS",
        type = CE_MemoryType.bool_,
        addr = 0x00f41cb6,
    },
    {
        name = "DESIGN_NEW_GAME_PLUS_HP_SCALE_MIN",
        type = CE_MemoryType.float_,
        addr = 0x00f41124,
    },
    {
        name = "DESIGN_NEW_GAME_PLUS_HP_SCALE_MAX",
        type = CE_MemoryType.float_,
        addr = 0x00f41270,
    },
    {
        name = "DESIGN_NEW_GAME_PLUS_ATTACK_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x00f412e8,
    },
    {
        name = "DESIGN_PLAYER_START_RAYCAST_COARSE_TO_GROUND",
        type = CE_MemoryType.bool_,
        addr = 0x00ff7a15,
    },
    {
        name = "DESIGN_PLAYER_START_TELEPORT_TO_GROUND",
        type = CE_MemoryType.bool_,
        addr = 0x00f41d27,
    },
    {
        name = "DESIGN_PLAYER_ALWAYS_TELEPORT_TO_GROUND",
        type = CE_MemoryType.bool_,
        addr = 0x00ff560f,
    },
    {
        name = "DESIGN_PLAYER_START_POS_X",
        type = CE_MemoryType.float_,
        addr = 0x00f41274,
    },
    {
        name = "DESIGN_PLAYER_START_POS_Y",
        type = CE_MemoryType.float_,
        addr = 0x00f41e20,
    },
    {
        name = "DESIGN_RANDOM_STARTING_ITEMS",
        type = CE_MemoryType.bool_,
        addr = 0x00ff5615,
    },
    {
        name = "DESIGN_POLYMORPH_PLAYER_POLYMORPH_ENABLED",
        type = CE_MemoryType.bool_,
        addr = 0x00f41cb5,
    },
    {
        name = "DESIGN_POLYMORPH_CONTROLS_ENABLED",
        type = CE_MemoryType.bool_,
        addr = 0x00f41cb7,
    },
    {
        name = "DESIGN_PLAYER_PICKUP_ENABLED",
        type = CE_MemoryType.bool_,
        addr = 0x00ff7a42,
    },
    {
        name = "DESIGN_CARDS_MUST_BE_IDENTIFIED",
        type = CE_MemoryType.bool_,
        addr = 0x00f41d24,
    },
    {
        name = "DESIGN_WAND_SLOTS_ARE_CONSUMED",
        type = CE_MemoryType.bool_,
        addr = 0x00f41dae,
    },
    {
        name = "DESIGN_ITEMS_CAN_BE_EATEN",
        type = CE_MemoryType.bool_,
        addr = 0x00f41280,
    },
    {
        name = "DESIGN_ITEMCHEST_DROPS_ACTIONS",
        type = CE_MemoryType.bool_,
        addr = 0x00f41121,
    },
    {
        name = "DESIGN_ENEMY_HEALTH_DROPS",
        type = CE_MemoryType.bool_,
        addr = 0x00f41dad,
    },
    {
        name = "DESIGN_ENEMY_2X_MONEY_DROPS",
        type = CE_MemoryType.bool_,
        addr = 0x00f41123,
    },
    {
        name = "DESIGN_FIRE_DAMAGE_BASED_ON_MAX_HP",
        type = CE_MemoryType.bool_,
        addr = 0x00f410c3,
    },
    {
        name = "DESIGN_AGGRO_INDICATOR",
        type = CE_MemoryType.bool_,
        addr = 0x00f411f0,
    },
    {
        name = "DESIGN_CARD_SYMBOL_UNLOCKS",
        type = CE_MemoryType.bool_,
        addr = 0x00f41d25,
    },
    {
        name = "DESIGN_BLOOD_RESTORES_HP",
        type = CE_MemoryType.bool_,
        addr = 0x00ff7a71,
    },
    {
        name = "DESIGN_MATERIAL_INGESTION_STATUS_FX",
        type = CE_MemoryType.bool_,
        addr = 0x00ff7a17,
    },
    {
        name = "DESIGN_RANDOMIZE_TEMPLE_CONTENTS",
        type = CE_MemoryType.bool_,
        addr = 0x00ff55cf,
    },
    {
        name = "DESIGN_TEMPLE_CHECK_FOR_LEAKS",
        type = CE_MemoryType.bool_,
        addr = 0x00f41066,
    },
    {
        name = "DESIGN_PLAYER_PHYSICS_KILLS_DONT_TRICK_KILL",
        type = CE_MemoryType.bool_,
        addr = 0x00ff7a73,
    },
    {
        name = "DESIGN_DAY_CYCLE_SPEED",
        type = CE_MemoryType.float_,
        addr = 0x00f410e4,
    },
    {
        name = "DESIGN_SPELL_VISUALIZER",
        type = CE_MemoryType.bool_,
        addr = 0x00ff640b,
    },
    {
        name = "DESIGN_RELOAD_ALL_THE_TIME",
        type = CE_MemoryType.bool_,
        addr = 0x00f41283,
    },
})

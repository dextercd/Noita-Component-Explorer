herd_id_values = {
    "-1",
    "ant",
    "apparition",
    "bat",
    "boss_dragon",
    "boss_limbs",
    "crawler",
    "curse",
    "eel",
    "electricity",
    "fire",
    "flower",
    "fly",
    "fungus",
    "ghost",
    "ghost_boss",
    "ghoul",
    "giant",
    "healer",
    "helpless",
    "ice",
    "mage",
    "mage_swapper",
    "nest",
    "orcs",
    "player",
    "rat",
    "robot",
    "slimes",
    "spider",
    "target",
    "trap",
    "wolf",
    "worm",
    "zombie",
}

arc_type = {
    "MATERIAL",
    "LIGHTNING",
}

audio_layer = {
    "EFFECT_GAME",
    "EFFECT_UI",
    "AMBIENCE",
    "MUSIC",
}

biome_type = {
    "BIOME_PROCEDURAL",
    "BIOME_BITMAP",
    "BIOME_WANG_TILE",
}

damage_types = {
    "NONE",
    "DAMAGE_MELEE",
    "DAMAGE_PROJECTILE",
    "DAMAGE_EXPLOSION",
    "DAMAGE_BITE",
    "DAMAGE_FIRE",
    "DAMAGE_MATERIAL",
    "DAMAGE_FALL",
    "DAMAGE_ELECTRICITY",
    "DAMAGE_DROWNING",
    "DAMAGE_PHYSICS_BODY_DAMAGED",
    "DAMAGE_DRILL",
    "DAMAGE_SLICE",
    "DAMAGE_ICE",
    "DAMAGE_HEALING",
    "DAMAGE_PHYSICS_HIT",
    "DAMAGE_RADIOACTIVE",
    "DAMAGE_POISON",
    "DAMAGE_MATERIAL_WITH_FLASH",
    "DAMAGE_OVEREATING",
    "DAMAGE_CURSE",
}

edge_style = {
    "COLOR_EDGE_PIXELS",
    "EVERYWHERE",
    "CARDINAL_DIRECTIONS",
    "NORMAL_BASED",
}

explosion_trigger_type = {
    "ON_DEATH",
    "ON_CREATE",
    "ON_TIMER",
}

fog_of_war_type = {
    "DEFAULT",
    "HEAVY_CLEAR_AT_PLAYER",
    "HEAVY_CLEAR_WITH_MAGIC",
    "HEAVY_NO_CLEAR",
}

game_effect = {
    "NONE",
    "ELECTROCUTION",
    "FROZEN",
    "ON_FIRE",
    "POISON",
    "BERSERK",
    "CHARM",
    "POLYMORPH",
    "POLYMORPH_RANDOM",
    "BLINDNESS",
    "TELEPATHY",
    "TELEPORTATION",
    "REGENERATION",
    "LEVITATION",
    "MOVEMENT_SLOWER",
    "FARTS",
    "DRUNK",
    "BREATH_UNDERWATER",
    "RADIOACTIVE",
    "WET",
    "OILED",
    "BLOODY",
    "SLIMY",
    "CRITICAL_HIT_BOOST",
    "CONFUSION",
    "MELEE_COUNTER",
    "WORM_ATTRACTOR",
    "WORM_DETRACTOR",
    "FOOD_POISONING",
    "FRIEND_THUNDERMAGE",
    "FRIEND_FIREMAGE",
    "INTERNAL_FIRE",
    "INTERNAL_ICE",
    "JARATE",
    "KNOCKBACK",
    "KNOCKBACK_IMMUNITY",
    "MOVEMENT_SLOWER_2X",
    "MOVEMENT_FASTER",
    "STAINS_DROP_FASTER",
    "SAVING_GRACE",
    "DAMAGE_MULTIPLIER",
    "HEALING_BLOOD",
    "RESPAWN",
    "PROTECTION_FIRE",
    "PROTECTION_RADIOACTIVITY",
    "PROTECTION_EXPLOSION",
    "PROTECTION_MELEE",
    "PROTECTION_ELECTRICITY",
    "TELEPORTITIS",
    "STAINLESS_ARMOUR",
    "GLOBAL_GORE",
    "EDIT_WANDS_EVERYWHERE",
    "EXPLODING_CORPSE_SHOTS",
    "EXPLODING_CORPSE",
    "EXTRA_MONEY",
    "EXTRA_MONEY_TRICK_KILL",
    "HOVER_BOOST",
    "PROJECTILE_HOMING",
    "ABILITY_ACTIONS_MATERIALIZED",
    "NO_DAMAGE_FLASH",
    "NO_SLIME_SLOWDOWN",
    "MOVEMENT_FASTER_2X",
    "NO_WAND_EDITING",
    "LOW_HP_DAMAGE_BOOST",
    "FASTER_LEVITATION",
    "STUN_PROTECTION_ELECTRICITY",
    "STUN_PROTECTION_FREEZE",
    "IRON_STOMACH",
    "PROTECTION_ALL",
    "INVISIBILITY",
    "REMOVE_FOG_OF_WAR",
    "MANA_REGENERATION",
    "PROTECTION_DURING_TELEPORT",
    "PROTECTION_POLYMORPH",
    "PROTECTION_FREEZE",
    "FROZEN_SPEED_UP",
    "UNSTABLE_TELEPORTATION",
    "POLYMORPH_UNSTABLE",
    "CUSTOM",
    "ALLERGY_RADIOACTIVE",
    "RAINBOW_FARTS",
}

general_noise = {
    "IQNoise",
    "DirtyPeeNoise",
    "QemNoise",
    "WhiteNoise",
    "MixNoise",
    "SimplexNoise",
    "STB_Perlin",
    "FastBlockNoise",
    "SimplexNoise1234",
}

hit_effect = {
    "NONE",
    "LOAD_ENTITY",
    "LOAD_CHILD_ENTITY",
    "LOAD_UNIQUE_CHILD_ENTITY",
    "LOAD_GAME_EFFECT",
    "LOAD_UNIQUE_GAME_EFFECT",
    "CONVERT_RAGDOLL_TO_MATERIAL",
    "CRITICAL_HIT_BOOST",
    "DAMAGE_BOOST",
    "SWAPPER",
}

inventory_kind = {
    "QUICK",
    "FULL",
}

joint_type = {
    "REVOLUTE_JOINT",
    "WELD_JOINT",
    "REVOLUTE_JOINT_ATTACH_TO_NEARBY_SURFACE",
    "WELD_JOINT_ATTACH_TO_NEARBY_SURFACE",
}

lua_vm_type = {
    "SHARED_BY_MANY_COMPONENTS",
    "CREATE_NEW_EVERY_EXECUTION",
    "ONE_PER_COMPONENT_INSTANCE",
}

materialaudio_type = {
    "NONE",
    "LAVA",
    "MAGICAL",
}

materialbreakaudio_type = {
    "NONE",
    "WOOD",
    "CHAIN",
}

movetosurface_type = {
    "ENTITY",
    "VERLET_ROPE_ONE_JOINT",
    "VERLET_ROPE_TWO_JOINTS",
}

noise_type = {
    "IQ2_SIMPLEX1234",
    "IQ_SIMPLEX",
    "SIN_CAPPED_EVERYTHING",
    "SIN_CAPPED_SIMPLEX",
}

particle_emitter_custom_style = {
    "NONE",
    "FIRE",
}

projectile_type = {
    "PROJECTILE",
    "LIGHTNING",
    "VERLET",
    "MATERIAL_PARTICLE",
}

ragdoll_fx = {
    "NONE",
    "NORMAL",
    "BLOOD_EXPLOSION",
    "BLOOD_SPRAY",
    "FROZEN",
    "CONVERT_TO_MATERIAL",
    "CUSTOM_RAGDOLL_ENTITY",
    "DISINTEGRATED",
    "NO_RAGDOLL_FILE",
    "PLAYER_RAGDOLL_CAMERA",
}

verlet_type = {
    "CHAIN",
    "CLOTH",
    "BLOB",
}

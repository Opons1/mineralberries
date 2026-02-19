mineralberries.settings = {
    rarity_multiplier = tonumber(minetest.settings:get("mineralberries_rarity_multiplier")) or 1,
    drop_multiplier = tonumber(minetest.settings:get("mineralberries_drop_multiplier")) or 1,
    growth_multiplier = tonumber(minetest.settings:get("mineralberries_growth_multiplier")) or 1,

    require_ore_below = minetest.settings:get_bool("mineralberries_require_ore_below") or true,

    enable_technic_extractor = minetest.settings:get_bool("mineralberries_enable_technic_extractor") or true,
    enable_bush_crafts = minetest.settings:get_bool("mineralberries_enable_bush_crafts") or false,
    enable_oreblock_crafts = minetest.settings:get_bool("mineralberries_enable_oreblock_crafts") or true,
    enable_harvester_craft = minetest.settings:get_bool("mineralberries_enable_harvester_craft") or true,
}

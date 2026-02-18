mineralberries.settings = {
    rarity_multiplier = tonumber(minetest.settings:get("mineralberries_rarity_multiplier") or "1.0"),
    drop_multiplier = tonumber(minetest.settings:get("mineralberries_drop_multiplier") or "1.0"),
    growth_multiplier = tonumber(minetest.settings:get("mineralberries_growth_multiplier") or "1.0"),

    require_ore_below = minetest.settings:get_bool("mineralberries_require_ore_below", true),
    overgrown_consume_ore = minetest.settings:get_bool("mineralberries_overgrown_consumes_ore", true),

    enable_technic_extractor = minetest.settings:get_bool("mineralberries_enable_technic_extractor", true),
    enable_bush_crafts = minetest.settings:get_bool("mineralberries_enable_bush_crafts", false),
    enable_oreblock_crafts = minetest.settings:get_bool("mineralberries_enable_oreblock_crafts", true),
}

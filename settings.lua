mineralberries.settings = {
    rarity = minetest.settings:get_float("mineralberries.rarity_multiplier", 1.0),
    drop_mult = minetest.settings:get_float("mineralberries.drop_multiplier", 1.0),
    growth_mult = minetest.settings:get_float("mineralberries.growth_multiplier", 1.0),

    enable_small = minetest.settings:get_bool("mineralberries.enable_small", true),
    enable_large = minetest.settings:get_bool("mineralberries.enable_large", true),
    enable_overgrown = minetest.settings:get_bool("mineralberries.enable_overgrown", true),

    require_ore = minetest.settings:get_bool("mineralberries.require_ore_below", true),
    overgrown_consume_ore = minetest.settings:get_bool("mineralberries.overgrown_consumes_ore", true),

    technic_extractor = minetest.settings:get_bool("mineralberries.enable_technic_extractor", true),
    enable_crafts = minetest.settings:get_bool("mineralberries.enable_bush_crafts", false),
}

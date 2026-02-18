function mineralberries.register_berry(ore, ore_name, oreblock, berry_texture, bush_texture, berry_bush_texture, berries_dropped, growth_time, bush_rarity)
    local berry_name = "mineralberries:"..ore_name .. "_berry"
    local bush_name ="mineralberries:"..ore_name .. "_bush"
    local bush_name_with_berries = "mineralberries:"..ore_name .. "_bush_with_berries"
    local growth_timer = (growth_time or 300)/mineralberries.settings.growth_multiplier
    if bush_rarity then
        bush_rarity = 1/bush_rarity*1/mineralberries.settings.rarity_multiplier
    end
    core.register_craftitem(":"..berry_name, {
        description = ore_name .. " Berry",
        inventory_image = berry_texture,
        on_use = minetest.item_eat(0),
    })
    core.register_craft({
        output = ore,
        recipe = {
            {berry_name, berry_name, ""},
            {berry_name, berry_name, ""},
            {"", "", ""},
        }
    })
    if mineralberries.settings.enable_oreblock_crafts then
        core.register_craft({
            output = oreblock,
            recipe = {
                {berry_name, berry_name, berry_name},
                {berry_name, "default:stone", berry_name},
                {berry_name, berry_name, berry_name},
            }
        })
    end
    if mineralberries.settings.enable_bush_crafts == true then
        core.register_craft({
            output = bush_name,
            recipe = {
                {berry_name, berry_name, berry_name},
                {berry_name, oreblock, berry_name},
                {berry_name, berry_name, berry_name},
            }
        })
    end
    core.register_node(":"..bush_name, {
        description = ore_name .. " Bush",
        drawtype = "leaflike",
        tiles = {bush_texture},
        groups = {snappy = 3, flammable = 2},
        on_construct = function(pos)
            local timer = minetest.get_node_timer(pos)
            timer:start(growth_timer)
        end,
        on_timer = function(pos, elapsed)
            local node_below = minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z})
            if mineralberries.settings.require_ore_below and node_below.name ~= oreblock then
                minetest.remove_node(pos)
                return
            end
            core.set_node(pos, {name = bush_name_with_berries})
            return true
        end,
    })
    core.register_node(":"..bush_name_with_berries, {
        description = ore_name .. " Bush (with Berries)",
        drawtype = "leaflike",
        tiles = {berry_bush_texture},
        groups = {snappy = 3, flammable = 2},
        drop = berry_name.." "..berries_dropped,
        after_dig_node = function(pos)
            core.set_node(pos, {name = bush_name})
        end,
    })
    core.register_decoration({
        name = "mineralberries:"..ore_name .. "_bush_decoration",
        deco_type = "simple",
        place_on = {oreblock},
        sidelen = 16,
        fill_ratio = bush_rarity or 0.01,
        y_max = 31000,
        y_min = -31000,
        decoration = bush_name,
    })
end
--TODO: technic extractor support

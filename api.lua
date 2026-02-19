--harvester, automatically farms the node below
core.register_node("mineralberries:harvester", {
    description = "Mineral Berry Harvester",
    tiles = {"mineralberries_harvester_top.png", "mineralberries_harvester_bottom.png", "mineralberries_harvester_side.png"},
    groups = {cracky = 2, level = 2},
    on_construct = function(pos)
        local below = {x=pos.x, y=pos.y-1, z=pos.z}
        local meta = core.get_meta(pos)
        meta:set_string("infotext", "Mineral Berry Harvester")
        local inv = meta:get_inventory()
        inv:set_size("main", 8*4)
        meta:set_string("formspec", "size[8,9]"..
            "list[current_name;main;0,0.3;8,4;]"..
            "list[current_player;main;0,4.85;8,1;]"..
            "list[current_player;main;0,6.08;8,3;8]")
        if mineralberries.bushes[core.get_node(below).name] then
            if inv:room_for_item("main", mineralberries.bushes[core.get_node(below).name].drops) then
                inv:add_item("main", mineralberries.bushes[core.get_node(below).name].drops)
            else
                core.add_item({x = pos.x, y = pos.y + 1.5, z = pos.z}, mineralberries.bushes[core.get_node(below).name].drops)
            end
            core.set_node(below, {name = mineralberries.bushes[core.get_node(below).name].name})
        end
    end,
})
if mineralberries.settings.enable_harvester_craft == true then
    core.register_craft({
        output = "mineralberries:harvester",
        recipe = {
            {"default:obsidian", "default:steelblock", "default:obsidian"},
            {"default:obsidian", "default:mese_crystal", "default:obsidian"},
            {"default:obsidian", "group:mineralberry_bush", "default:obsidian"},
        }
    })
end
--table with bush data to link the bushes to the bushes with berries and hold other info
mineralberries.bushes = {}

function mineralberries.register_berry(ore, ore_name, oreblock, berry_texture, bush_texture, berry_bush_texture, berries_dropped, growth_time, bush_rarity)
    local berry_name = "mineralberries:"..ore_name .. "_berry"
    local bush_name ="mineralberries:"..ore_name .. "_bush"
    local bush_name_with_berries = "mineralberries:"..ore_name .. "_bush_with_berries"
    local growth_timer = (growth_time or 300)/mineralberries.settings.growth_multiplier
    if bush_rarity then
        bush_rarity = 1/bush_rarity/mineralberries.settings.rarity_multiplier
    end
    mineralberries.bushes[bush_name_with_berries] = {name = bush_name, drops = berry_name.." "..berries_dropped}
    --register berries
    core.register_craftitem(":"..berry_name, {
        description = ore_name .. " Berry",
        inventory_image = berry_texture,
        on_use = core.item_eat(0),
        groups = {mineralberries = 1}
    })
    --ore craft recipe
    core.register_craft({
        output = ore,
        recipe = {
            {berry_name, berry_name, ""},
            {berry_name, berry_name, ""},
            {"", "", ""},
        }
    })
    --recipe to craft oreblocks bushes need to be placed on
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
    --bush recipe
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
    --bush
    core.register_node(":"..bush_name, {
        description = ore_name .. " Bush",
        drawtype = "allfaces_optional",
        tiles = {bush_texture},
        groups = {snappy = 3, flammable = 2, mineralberry_bush = 1},
        on_construct = function(pos)
            local timer = core.get_node_timer(pos)
            timer:start(growth_timer)
        end,
        on_timer = function(pos, elapsed)
            local node_below = core.get_node({x=pos.x, y=pos.y-1, z=pos.z})
            local node_above = core.get_node({x=pos.x, y=pos.y+1, z=pos.z})
            local drops = berry_name.." "..berries_dropped
            local timer = core.get_node_timer(pos)
            if mineralberries.settings.require_ore_below == true and node_below.name ~= oreblock then
                return
            end
            if node_above.name == "mineralberries:harvester" then
                local meta = core.get_meta({x=pos.x, y=pos.y+1, z=pos.z})
                local inv = meta:get_inventory()
                if inv:room_for_item("main", drops) then
                    inv:add_item("main", drops)
                    timer:start(growth_timer)
                    return
                else
                    core.add_item({x = pos.x, y = pos.y + 1.5, z = pos.z}, drops)
                    timer:start(growth_timer)
                    return
                end
            end
            core.set_node(pos, {name = bush_name_with_berries})
            timer:start(growth_timer)
        end,
    })
    core.register_node(":"..bush_name_with_berries, {
        description = ore_name .. " Bush (with Berries)",
        drawtype = "allfaces_optional",
        tiles = {berry_bush_texture},
        groups = {snappy = 3, flammable = 2, mineralberries_grown = 1},
        drop = berry_name.." "..berries_dropped,
        after_dig_node = function(pos)
            core.set_node(pos, {name = bush_name})
        end,
    })
    core.register_decoration({
        name = "mineralberries:"..ore_name .. "_bush_decoration",
        deco_type = "simple",
        place_on = {oreblock},
        flags = "all_floors",
        sidelen = 8,
        fill_ratio = bush_rarity or 0.01,
        y_max = 31000,
        y_min = -31000,
        decoration = bush_name_with_berries,
    })
    if core.get_modpath("technic") and mineralberries.settings.enable_technic_extractor then
        technic.register_extractor_recipe({
            input = {berry_name .. " 3"},
            output = ore .. " 1",
            time = 40,
        })
    end
end

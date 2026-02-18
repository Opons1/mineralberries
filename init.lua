--GOALS
--three types of bush for a total of 6 nodes per mineral. 
--small, large, and overgrown(TBD)
--they will require an ore below them to grow, with overgrown consumng the ore after making 10 berries(TBD)
--small can not require an ore, but it dies after a while.
--easy api to register them hopefuly
--by default bushes will spawn on the ore, with 3 adjacent blocks being air (via core.register_decoration)
--faint glow(luminance: 3 maybe?)
--can die when no ore below
--a book detailing some info about oreberries spawning in dungeons maybe?
--oreberries can be crafted into the ore block
--technic support to maybe have an extractor make it go ot dust?
--support for multiple mods
--200-400 seconds per berry growth?
--SETTINGTYPES.TXT goals:
--general rarity multiplier for each
--general berry drop mult for each
--enable/disable small bushes
--enable/disable large bushes
--enable/disable overgrown bushes
--general growth speed multiplier for each
--enable/disable required ore node below
--enable/disable overgrown node consumption
--enable/disable technic custom machine
--enable/disable technic extractor recipes
--enable/disable bush recipes
mineralberries = {}
dofile(minetest.get_modpath("mineralberries").."/settings.lua")
dofile(minetest.get_modpath("mineralberries").."/api.lua")
dofile(minetest.get_modpath("mineralberries").."/book.lua")

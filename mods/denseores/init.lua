--[	This build was finished on: 3-25-2015.	--]

--[[
Order of everything here:
coal, iron, copper, gold, mese, diamond
Large, small
--]]

denseores_modpath = minetest.get_modpath("denseores")

--[	Small Items	--]

minetest.register_craftitem("denseores:small_coal_lump", {
	description = "Small Coal Lump",
	inventory_image = "small_coal_lump.png",
})

minetest.register_craftitem("denseores:small_iron_lump", {
	description = "Small Iron Lump",
	inventory_image = "small_iron_lump.png",
})

minetest.register_craftitem("denseores:small_copper_lump", {
	description = "Small Copper Lump",
	inventory_image = "small_copper_lump.png",
})

minetest.register_craftitem("denseores:small_gold_lump", {
	description = "Small Gold Lump",
	inventory_image = "small_gold_lump.png",
})

minetest.register_craftitem("denseores:small_mese_gem", {
	description = "Small Mese Gem",
	inventory_image = "small_mese_gem.png",
})

minetest.register_craftitem("denseores:small_diamond_gem", {
	description = "Small Diamond Gem",
	inventory_image = "small_diamond_gem.png",
})

--[	Large Ore Nodes	--]

minetest.register_node("denseores:large_coal_ore", {	--coal
	description = "Large Coal Ore",
	tiles ={"default_stone.png^large_coal_ore.png"},
	groups = {cracky=3},
	drop = 'denseores:large_coal_ore',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("denseores:large_iron_ore", {	--iron
	description = "Large Iron Ore",
	tiles ={"default_stone.png^large_iron_ore.png"},
	groups = {cracky=2},
	drop = 'denseores:large_iron_ore',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("denseores:large_copper_ore", {	--copper
	description = "Large Copper Ore",
	tiles ={"default_stone.png^large_copper_ore.png"},
	groups = {cracky=2},
	drop = 'denseores:large_copper_ore',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("denseores:large_gold_ore", {	--gold
	description = "Large Gold Ore",
	tiles ={"default_stone.png^large_gold_ore.png"},
	groups = {cracky=2},
	drop = 'denseores:large_gold_ore',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("denseores:large_mese_ore", {	--mese
	description = "Large Mese Ore",
	tiles ={"default_stone.png^large_mese_ore.png"},
	groups = {cracky=1},
	drop = 'denseores:large_mese_ore',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("denseores:large_diamond_ore", {	--diamond
	description = "Large Diamond Ore",
	tiles ={"default_stone.png^large_diamond_ore.png"},
	groups = {cracky=1},
	drop = 'denseores:large_diamond_ore',
	sounds = default.node_sound_stone_defaults(),
})

--[	Small Ore Nodes	--]

minetest.register_node("denseores:small_coal_ore", {	--coal
	description = "Small Coal Ore",
	tiles ={"default_stone.png^small_coal_ore.png"},
	groups = {cracky=3},
	drop = 'denseores:small_coal_lump',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("denseores:small_iron_ore", {	--iron
	description = "Small Iron Ore",
	tiles ={"default_stone.png^small_iron_ore.png"},
	groups = {cracky=2},
	drop = 'denseores:small_iron_lump',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("denseores:small_copper_ore", {	--copper
	description = "Small Copper Ore",
	tiles ={"default_stone.png^small_copper_ore.png"},
	groups = {cracky=2},
	drop = 'denseores:small_copper_lump',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("denseores:small_gold_ore", {	--gold
	description = "Small Gold Ore",
	tiles ={"default_stone.png^small_gold_ore.png"},
	groups = {cracky=2},
	drop = 'denseores:small_gold_lump',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("denseores:small_mese_ore", {	--mese
	description = "Small Mese Ore",
	tiles ={"default_stone.png^small_mese_ore.png"},
	groups = {cracky=1},
	drop = 'denseores:small_mese_gem',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("denseores:small_diamond_ore", {	--diamond
	description = "Small Diamond Ore",
	tiles ={"default_stone.png^small_diamond_ore.png"},
	groups = {cracky=1},
	drop = 'denseores:small_diamond_gem',
	sounds = default.node_sound_stone_defaults(),
})

--[	Large Ore Defenitions	--]

minetest.register_ore({
    ore_type       = "scatter",
    ore            = "denseores:large_coal_ore",
    wherein        = "default:stone_with_coal",
    clust_scarcity = 14,
    clust_num_ores = 2,
    clust_size     = 2,
    height_min     = -31000,
    height_max     = 64,
})

minetest.register_ore({
    ore_type       = "scatter",
    ore            = "denseores:large_iron_ore",
    wherein        = "default:stone_with_iron",
    clust_scarcity = 14,
    clust_num_ores = 2,
    clust_size     = 2,
    height_min     = -31000,
    height_max     = 2,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "denseores:large_copper_ore",
	wherein        = "default:stone_with_copper",
	clust_scarcity = 14,
	clust_num_ores = 2,
	clust_size     = 2,
	height_min     = -31000,
	height_max     = 2,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "denseores:large_gold_ore",
	wherein        = "default:stone_with_gold",
	clust_scarcity = 14,
	clust_num_ores = 2,
	clust_size     = 2,
	height_min     = -31000,
	height_max     = 2,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "denseores:large_mese_ore",
	wherein        = "default:stone_with_mese",
	clust_scarcity = 14,
	clust_num_ores = 2,
	clust_size     = 2,
	height_min     = -31000,
	height_max     = -64,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "denseores:large_diamond_ore",
	wherein        = "default:stone_with_diamond",
	clust_scarcity = 14,
	clust_num_ores = 2,
	clust_size     = 2,
	height_min     = -31000,
	height_max     = -128,
})

--[	Small Ore Defenitions	--]

minetest.register_ore({
    ore_type       = "scatter",
    ore            = "denseores:small_coal_ore",
    wherein        = "default:stone_with_coal",
    clust_scarcity = 14,
    clust_num_ores = 2,
    clust_size     = 2,
    height_min     = -31000,
    height_max     = 64,
})

minetest.register_ore({
    ore_type       = "scatter",
    ore            = "denseores:small_iron_ore",
    wherein        = "default:stone_with_iron",
    clust_scarcity = 14,
    clust_num_ores = 2,
    clust_size     = 2,
    height_min     = -31000,
    height_max     = 2,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "denseores:small_copper_ore",
	wherein        = "default:stone_with_copper",
	clust_scarcity = 14,
	clust_num_ores = 2,
	clust_size     = 2,
	height_min     = -31000,
	height_max     = -16,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "denseores:small_gold_ore",
	wherein        = "default:stone_with_gold",
	clust_scarcity = 14,
	clust_num_ores = 2,
	clust_size     = 2,
	height_min     = -31000,
	height_max     = -64,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "denseores:small_mese_ore",
	wherein        = "default:stone_with_mese",
	clust_scarcity = 14,
	clust_num_ores = 2,
	clust_size     = 2,
	height_min     = -31000,
	height_max     = -64,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "denseores:small_diamond_ore",
	wherein        = "default:stone_with_diamond",
	clust_scarcity = 14,
	clust_num_ores = 2,
	clust_size     = 2,
	height_min     = -31000,
	height_max     = -128,
})

--[	Crafting Recipies	--]
--[	From Large to Normal	--]

minetest.register_craft( {
	type = "shapeless",
	output = "default:coal_lump 2", --coal
	recipe = {
		"denseores:large_coal_ore",
	}
})

minetest.register_craft( {
	type = "shapeless",
	output = "default:iron_lump 2", --iron
	recipe = {
		"denseores:large_iron_ore",
	}
})

minetest.register_craft( {
	type = "shapeless",
	output = "default:copper_lump 2", --copper
	recipe = {
		"denseores:large_copper_ore",
	}
})

minetest.register_craft( {
	type = "shapeless",
	output = "default:gold_lump 2", --gold
	recipe = {
		"denseores:large_gold_ore",
	}
})

minetest.register_craft( {
	type = "shapeless",
	output = "default:mese_crystal 2", --mese
	recipe = {
		"denseores:large_mese_ore",
	}
})

minetest.register_craft( {
	type = "shapeless",
	output = "default:diamond 2", --diamond
	recipe = {
		"denseores:large_diamond_ore",
	}
})

--[	Crafting Recipies	--]
--[	From Small to Normal	--]

minetest.register_craft( {
	type = "shapeless",
	output = "default:coal_lump 1", --coal
	recipe = {
		"denseores:small_coal_lump",
		"denseores:small_coal_lump",
	}
})

minetest.register_craft( {
	type = "shapeless",
	output = "default:iron_lump 1", --iron
	recipe = {
		"denseores:small_iron_lump",
		"denseores:small_iron_lump",
	}
})

minetest.register_craft( {
	type = "shapeless",
	output = "default:copper_lump 1", --copper
	recipe = {
		"denseores:small_copper_lump",
		"denseores:small_copper_lump",
	}
})

minetest.register_craft( {
	type = "shapeless",
	output = "default:gold_lump 1", --gold
	recipe = {
		"denseores:small_gold_lump",
		"denseores:small_gold_lump",
	}
})

minetest.register_craft( {
	type = "shapeless",
	output = "default:mese_crystal 1", --mese
	recipe = {
		"denseores:small_mese_gem",
		"denseores:small_mese_gem",
	}
})

minetest.register_craft( {
	type = "shapeless",
	output = "default:diamond 1", --diamond
	recipe = {
		"denseores:small_diamond_gem",
		"denseores:small_diamond_gem",
	}
})

-- Special things happen from this line down.

minetest.register_craft({
	type = "fuel",
	recipe = "denseores:small_coal_lump",
	burntime = 20,
})


-- Does moreores exist? Let's find out!
if minetest.get_modpath("moreores") then		--Thank you Kazea of the Minetest Fourums.
	dofile(denseores_modpath .. "/mo.lua")
end

-- Does technic exist? Let's find out!
if minetest.get_modpath("technic") then
	dofile(denseores_modpath .. "/tn.lua")
end



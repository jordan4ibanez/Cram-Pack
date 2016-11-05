
-- Default tree schematics
local dpath = minetest.get_modpath("default") .. "/schematics/"

lucky_block:add_schematics({
	{"appletree", dpath .. "apple_tree_from_sapling.mts", {x = 2, y = 1, z = 2}},
	{"jungletree", dpath .. "jungle_tree_from_sapling.mts", {x = 2, y = 1, z = 2}},
	{"defpinetree", dpath .. "pine_tree_from_sapling.mts", {x = 2, y = 1, z = 2}},
	{"acaciatree", dpath .. "acacia_tree_from_sapling.mts", {x = 4, y = 1, z = 4}},
	{"aspentree", dpath .. "aspen_tree_from_sapling.mts", {x = 2, y = 1, z = 2}},
})

-- Default blocks
lucky_block:add_blocks({
	{"sch", "watertrap", 1, true},
	{"tel"},
	{"dro", {"wool:"}, 10, true},
	{"dro", {"default:apple"}, 10},
	{"sch", "appletree", 0, false},
	{"dro", {"default:snow"}, 10},
	{"nod", "default:chest", 0, {
		{name = "bucket:bucket_water", max = 1},
		{name = "default:wood", max = 3},
		{name = "default:pick_diamond", max = 1},
		{name = "default:coal_lump", max = 3}}},
	{"sch", "sandtrap", 1, true},
	{"nod", "flowers:rose", 0},
	{"sch", "defpinetree", 0, false},
	{"sch", "lavatrap", 1, true},
	{"dro", {"default:mese_crystal_fragment", "default:mese_crystal"}, 10},
	{"exp"},
	{"nod", "default:diamondblock", 0},
	{"nod", "default:steelblock", 0},
	{"nod", "default:dirt", 0},
	{"dro", {"dye:"}, 10, true},
	{"dro", {"default:sword_steel"}, 1},
	{"sch", "jungletree", 0, false},
	{"dro", {"default:pick_steel"}, 1},
	{"dro", {"default:shovel_steel"}, 1},
	{"dro", {"default:coal_lump"}, 3},
	{"sch", "acaciatree", 0, false},
	{"dro", {"default:axe_steel"}, 1},
	{"dro", {"default:sword_bronze"}, 1},
	{"exp"},
	{"sch", "platform", 1, true},
	{"nod", "default:wood", 0},
	{"dro", {"default:pick_bronze"}, 1},
	{"sch", "aspentree", 0, false},
	{"dro", {"default:shovel_bronze"}, 1},
	{"nod", "default:gravel", 0},
	{"dro", {"default:axe_bronze"}, 1},
})

-- Farming mod
if minetest.get_modpath("farming") then
	lucky_block:add_blocks({
		{"dro", {"farming:bread"}, 5},
		{"sch", "instafarm", 0, true},
		{"nod", "default:water_source", 1},
	})

if farming.mod and farming.mod == "redo" then
	lucky_block:add_blocks({
		{"dro", {"farming:corn"}, 5},
		{"dro", {"farming:coffee_cup_hot"}, 1},
		{"dro", {"farming:bread"}, 5},
		{"nod", "farming:jackolantern", 0},
		{"tro", "farming:jackolantern_on"},
		{"nod", "default:river_water_source", 1},
		{"dro", {"farming:trellis", "farming:grapes"}, 5},
		{"dro", {"farming:bottle_ethanol"}, 1},
		{"nod", "farming:melon", 0},
		{"dro", {"farming:donut", "farming:donut_chocolate", "farming:donut_apple"}, 5},
	})
end

end -- END farming mod

-- Mobs mod
if minetest.get_modpath("mobs") then
	lucky_block:add_blocks({
		{"spw", "mobs:sheep", 5},
		{"spw", "mobs:dungeon_master", 1, nil, nil, 3, "Billy"},
		{"spw", "mobs:sand_monster", 3},
		{"spw", "mobs:stone_monster", 3, nil, nil, 3, "Bob"},
		{"dro", {"mobs:meat_raw"}, 5},
		{"spw", "mobs:rat", 5},
		{"spw", "mobs:dirt_monster", 3},
		{"spw", "mobs:tree_monster", 3},
		{"spw", "mobs:oerkki", 3},
		{"dro", {"mobs:rat_cooked"}, 5},
		{"exp"},
	})
if mobs.mod and mobs.mod == "redo" then
	lucky_block:add_blocks({
		{"spw", "mobs:bunny", 3},
		{"spw", "mobs:spider", 5},
		{"nod", "mobs:honey_block", 0},
		{"spw", "mobs:pumba", 5},
		{"spw", "mobs:mese_monster", 2},
		{"nod", "mobs:cheeseblock", 0},
		{"spw", "mobs:chicken", 5},
		{"dro", {"mobs:egg"}, 5},
		{"spw", "mobs:lava_flan", 3},
		{"spw", "mobs:cow", 5},
		{"dro", {"mobs:bucket_milk"}, 10},
		{"spw", "mobs:kitten", 2},
		{"tro", "default:nyancat", "mobs_kitten", true},
		{"nod", "default:chest", 0, {
			{name = "mobs:lava_orb", max = 1}}},
	})
end

end -- END mobs mod

-- Home Decor mod
if minetest.get_modpath("homedecor") then
	lucky_block:add_blocks({
		{"nod", "homedecor:toilet", 0},
		{"nod", "homedecor:table", 0},
		{"nod", "homedecor:chair", 0},
		{"nod", "homedecor:table_lamp_off", 0},
	})
end

-- Teleport Potion mod
if minetest.get_modpath("teleport_potion") then
	lucky_block:add_blocks({
		{"dro", {"teleport_potion:potion"}, 1},
		{"tel"},
	})
end

-- Boats mod
if minetest.get_modpath("boats") then
	lucky_block:add_blocks({
		{"dro", {"boats:boat"}, 1},
	})
end

-- Carts mod
if minetest.get_modpath("carts")
or minetest.get_modpath("boost_cart") then
	lucky_block:add_blocks({
		{"dro", {"boats:boat"}, 1},
		{"dro", {"default:rail"}, 10},
		{"dro", {"carts:powerrail"}, 5},
	})
end

-- Hopper mod
if minetest.get_modpath("hopper") then
	lucky_block:add_blocks({
		{"dro", {"hopper:hopper"}, 3},
		{"nod", "default:lava_source", 1},
	})
end

-- Protector mod
if minetest.get_modpath("protector") then
	lucky_block:add_blocks({
		{"dro", {"protector:protect"}, 3},
	})
if protector and protector.mod and protector.mod == "redo" then
	lucky_block:add_blocks({
		{"dro", {"protector:protect2"}, 3},
		{"dro", {"protector:door_wood"}, 1},
		{"dro", {"protector:door_steel"}, 1},
		{"dro", {"protector:chest"}, 1},
	})
end
end

-- Ethereal mod
if minetest.get_modpath("ethereal") then

local epath = minetest.get_modpath("ethereal") .. "/schematics/"

lucky_block:add_schematics({
	{"pinetree", epath .. "pinetree.mts", {x = 3, y = 0, z = 3}},
	{"palmtree", epath .. "palmtree.mts", {x = 4, y = 0, z = 4}},
	{"bananatree", ethereal.bananatree, {x = 3, y = 0, z = 3}},
	{"orangetree", ethereal.orangetree, {x = 1, y = 0, z = 1}},
	{"birchtree", ethereal.birchtree, {x = 2, y = 0, z = 2}},
})

lucky_block:add_blocks({
	{"nod", "ethereal:crystal_spike", 1},
	{"sch", "pinetree", 0, false},
	{"dro", {"ethereal:orange"}, 10},
	{"sch", "appletree", 0, false},
	{"dro", {"ethereal:strawberry"}, 10},
	{"sch", "bananatree", 0, false},
	{"sch", "orangetree", 0, false},
	{"dro", {"ethereal:banana"}, 10},
	{"sch", "acaciatree", 0, false},
	{"dro", {"ethereal:golden_apple"}, 3},
	{"sch", "palmtree", 0, false},
	{"dro", {"ethereal:tree_sapling", "ethereal:orange_tree_sapling", "ethereal:banana_tree_sapling"}, 10},
	{"dro", {"ethereal:green_dirt", "ethereal:prairie_dirt", "ethereal:grove_dirt", "ethereal:cold_dirt"}, 10},
	{"dro", {"ethereal:axe_crystal"}, 1},
	{"nod", "ethereal:fire_flower", 1},
	{"dro", {"ethereal:sword_crystal"}, 1},
	{"dro", {"ethereal:pick_crystal"}, 1},
	{"sch", "birchtree", 0, false},
	{"dro", {"ethereal:fish_raw"}, 1},
	{"dro", {"ethereal:shovel_crystal"}, 1},
	{"dro", {"ethereal:fishing_rod_baited"}, 1},
	{"exp"},
	{"dro", {"ethereal:fire_dust"}, 2},
})

if minetest.get_modpath("3d_armor") then
lucky_block:add_blocks({
	{"dro", {"3d_armor:helmet_crystal"}, 1},
	{"dro", {"3d_armor:chestplate_crystal"}, 1},
	{"dro", {"3d_armor:leggings_crystal"}, 1},
	{"dro", {"3d_armor:boots_crystal"}, 1},
	{"lig"},
})
end

if minetest.get_modpath("shields") then
lucky_block:add_blocks({
	{"dro", {"shields:shield_crystal"}, 1},
	{"exp"},
})
end

end -- END Ethereal mod

-- 3D Armor mod
if minetest.get_modpath("3d_armor") then
lucky_block:add_blocks({
	{"dro", {"3d_armor:boots_wood", "3d_armor:leggings_wood", "3d_armor:chestplate_wood", "3d_armor:helmet_wood"}, 1},
	{"dro", {"3d_armor:boots_steel", "3d_armor:leggings_steel", "3d_armor:chestplate_steel", "3d_armor:helmet_steel"}, 1},
	{"dro", {"3d_armor:boots_gold", "3d_armor:leggings_gold", "3d_armor:chestplate_gold", "3d_armor:helmet_gold"}, 1},
	{"dro", {"3d_armor:boots_cactus", "3d_armor:leggings_cactus", "3d_armor:chestplate_cactus", "3d_armor:helmet_cactus"}, 1},
	{"dro", {"3d_armor:boots_bronze", "3d_armor:leggings_bronze", "3d_armor:chestplate_bronze", "3d_armor:helmet_bronze"}, 1},
	{"lig"},
})
end

-- 3D Armor's Shields mod
if minetest.get_modpath("shields") then
lucky_block:add_blocks({
	{"dro", {"shields:shield_wood"}, 1},
	{"dro", {"shields:shield_steel"}, 1},
	{"dro", {"shields:shield_gold"}, 1},
	{"dro", {"shields:shield_cactus"}, 1},
	{"dro", {"shields:shield_bronze"}, 1},
	{"exp"},
})
end

-- Fire mod
if minetest.get_modpath("fire") then
lucky_block:add_blocks({
	{"dro", {"fire:flint_and_steel"}, 1},
	{"nod", "fire:basic_flame", 1},
	{"nod", "fire:permanent_flame", 1},
})
end

-- Pie mod
if minetest.get_modpath("pie") then
lucky_block:add_blocks({
	{"nod", "pie:pie_0", 0},
	{"nod", "pie:choc_0", 0},
	{"nod", "pie:coff_0", 0},
	{"tro", "pie:pie_0"},
	{"nod", "pie:rvel_0", 0},
	{"nod", "pie:scsk_0", 0},
	{"nod", "pie:bana_0", 0},
	{"nod", "pie:meat_0", 0},
	{"lig"},
})
end

-- Bakedclay mod
if minetest.get_modpath("bakedclay") then
local p = "bakedclay:"
lucky_block:add_blocks({
	{"dro", {"bakedclay:"}, 10, true},
	{"fal", {p.."black", p.."blue", p.."brown", p.."cyan", p.."dark_green",
		p.."dark_grey", p.."green", p.."grey", p.."magenta", p.."orange",
		p.."pink", p.."red", p.."violet", p.."white", p.."yellow"}, 0},
	{"fal", {p.."black", p.."blue", p.."brown", p.."cyan", p.."dark_green",
		p.."dark_grey", p.."green", p.."grey", p.."magenta", p.."orange",
		p.."pink", p.."red", p.."violet", p.."white", p.."yellow"}, 0, true},
})
end

-- TNT mod
if minetest.get_modpath("tnt") then
local p = "tnt:tnt_burning"
lucky_block:add_blocks({
	{"dro", {"tnt:gunpowder"}, 5, true},
	{"fal", {p, p, p, p, p}, 1, true, 4},
})
end

-- Coloured Blocks mod
if minetest.get_modpath("cblocks") then
lucky_block:add_blocks({
	{"dro", {"cblocks:wood_"}, 10, true},
	{"dro", {"cblocks:stonebrick_"}, 10, true},
	{"dro", {"cblocks:glass_"}, 10, true},
})
end

-- More Ore's mod
if minetest.get_modpath("moreores") then
lucky_block:add_blocks({
	{"nod", "moreores:tin_block", 0},
	{"nod", "moreores:silver_block", 0},
	{"fal", {"default:sand", "default:sand", "default:sand", "default:sand", "default:sand", "default:sand", "moreores:mithril_block"}, 0},
	{"dro", {"moreores:pick_silver"}, 1},
	{"dro", {"moreores:pick_mithril"}, 1},
	{"tro", "moreores:silver_block"},
	{"dro", {"moreores:shovel_silver"}, 1},
	{"dro", {"moreores:shovel_mithril"}, 1},
	{"dro", {"moreores:axe_silver"}, 1},
	{"dro", {"moreores:axe_mithril"}, 1},
	{"tro", "moreores:mithril_block"},
	{"dro", {"moreores:hoe_silver"}, 1},
	{"dro", {"moreores:hoe_mithril"}, 1},
	{"lig"},
})

if minetest.get_modpath("3d_armor") then
lucky_block:add_blocks({
	{"dro", {"3d_armor:helmet_mithril"}, 1},
	{"dro", {"3d_armor:chestplate_mithril"}, 1},
	{"dro", {"3d_armor:leggings_mithril"}, 1},
	{"dro", {"3d_armor:boots_mithril"}, 1},
})
end

if minetest.get_modpath("shields") then
lucky_block:add_blocks({
	{"dro", {"shields:shield_mithril"}, 1},
})
end

end

-- Bows mod
if minetest.get_modpath("bows") then
lucky_block:add_blocks({
	{"dro", {"bows:bow_wood"}, 1},
	{"dro", {"bows:bow_steel"}, 1},
	{"dro", {"bows:bow_bronze"}, 1},
	{"dro", {"bows:arrow"}, 5},
	{"dro", {"bows:arrow_steel"}, 5},
	{"dro", {"bows:arrow_mese"}, 5},
	{"dro", {"bows:arrow_diamond"}, 5},
})
end

-- Xanadu Server specific
if minetest.get_modpath("xanadu") then
lucky_block:add_blocks({
	{"dro", {"xanadu:cupcake"}, 8},
	{"spw", "mobs:creeper", 1, nil, nil, 5, "Mr. Boombastic"},
	{"spw", "mobs:npc", 1, true, true},
	{"nod", "default:chest", 0, {
		{name = "xanadu:axe_super", max = 1},
		{name = "xanadu:pizza", max = 2}}},
	{"dro", {"paintings:"}, 10, true},
	{"spw", "mobs:greensmall", 4},
	{"lig"},
	{"dro", {"carpet:"}, 10, true},
	{"dro", {"xanadu:bone"}, 2},
	{"spw", "mobs:bat", 3},
	{"dro", {"xanadu:cupcake_chocolate"}, 8},
	{"dro", {"xanadu:bacon"}, 8},
	{"dro", {"3d_armor:boots_bunny"}, 1},
	{"dro", {"carpet:wallpaper_"}, 10, true},
	{"nod", "default:chest", 0, {
		{name = "mobs:mese_monster_wing", max = 1}}},
	{"exp"},
	{"dro", {"more_chests:giftbox_red", "more_chests:giftbox_green"}, 1},
	{"dro", {"xanadu:taco"}, 2},
	{"dro", {"xanadu:gingerbread_man"}, 2},
	{"spw", "mobs:evil_bonny", 1},
})
end

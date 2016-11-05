
-- Based on TenPlus1's Baked Clay

local clay = {
	{"white", "White hardened"},
	{"grey", "Grey hardened"},
	{"black", "Black hardened"},
	{"red", "Red hardened"},
	{"yellow", "Yellow hardened"},
	{"green", "Green hardened"},
	{"cyan", "Cyan hardened"},
	{"blue", "Blue hardened"},
	{"magenta", "Magenta hardened"},
	{"orange", "Orange hardened"},
	{"violet", "Violet hardened"},
	{"brown", "Brown hardened"},
	{"pink", "Pink hardened"},
	{"dark_grey", "Dark Grey hardened"},
	{"dark_green", "Dark Green hardened"},
	{"hardened", "Hardened"},
}

for n = 1, #clay do

	-- node definition
	minetest.register_node("colored_clay:" .. clay[n][1], {
		description = clay[n][2] .. " clay",
		tiles = {"colored_clay_" .. clay[n][1] ..".png"},
		groups = {cracky = 3},
		sounds = default.node_sound_stone_defaults(),
	})

	-- craft from dye and any hardened clay
	minetest.register_craft({
		output = "colored_clay:" .. clay[n][1].." 8",
		recipe = {
				{"colored_clay:hardened", "colored_clay:hardened", "colored_clay:hardened"},
				{"colored_clay:hardened", "dye:" .. clay[n][1], "colored_clay:hardened"},
				{"colored_clay:hardened", "colored_clay:hardened", "colored_clay:hardened"},
			 },
	})

	-- register stair and slab
	if stairs and not stairs.mod then
	stairs.register_stair_and_slab("colored_clay_".. clay[n][1], "colored_clay:".. clay[n][1],
		{cracky = 3},
		{"colored_clay_" .. clay[n][1] .. ".png"},
		clay[n][2] .. " Clay Stair",
		clay[n][2] .. " Clay Slab",
		default.node_sound_stone_defaults())
	end
end

-- cook clay block into white hardened clay

minetest.register_craft({
	type = "cooking",
	output = "colored_clay:hardened",
	recipe = "default:clay",
})

-- register a few extra dye colour options

minetest.register_craft( {
	type = "shapeless",
	output = "dye:dark_grey 3",
	recipe = {
		"dye:black", "dye:black", "dye:white",
	},
})

minetest.register_craft( {
	type = "shapeless",
	output = "dye:grey 3",
	recipe = {
		"dye:black", "dye:white", "dye:white",
	},
})

minetest.register_craft( {
	type = "shapeless",
	output = "dye:green 4",
	recipe = {
		"default:cactus",
	},
})

minetest.register_craft( {
	type = "shapeless",
	output = "dye:black 4",
	recipe = {
		"default:coal_lump",
	},
})

minetest.register_craft( {
	type = "shapeless",
	output = "dye:brown 4",
	recipe = {
		"default:dry_shrub",
	},
})

print ("[MOD] Colored Clay loaded")



-- Boilerplate to support localized strings if intllib mod is installed.
local S
if (minetest.get_modpath("intllib")) then
  dofile(minetest.get_modpath("intllib").."/intllib.lua")
  S = intllib.Getter(minetest.get_current_modname())
else
  S = function ( s ) return s end
end

-- Nodes will be called simplyslopes:{'',outer_,outer2_,inner_,inner2_}<subname>
function simplyslopes.register_all2(recipeitem)
	
	-- Todo 
	
	local thisnode=minetest.registered_nodes[recipeitem]
	if thisnode == nil 
	then -- thisnode is empty, get out of here!
		return
	end

	--create the new node "subname"	
	local tmp = simplyslopes.splitstring(recipeitem)
	local modname=tmp[1]
	local subname=tmp[2]
	
	-- Bakedclay and wool mod name their blocks like "bakedclay:white"
	if  modname == 'bakedclay' or modname == 'wool'
		-- We must add modname to subname	
		then subname= modname .. '_' .. subname
	end

	local desc = thisnode.description
	-- remove "Block" and "Planks" form description;
	desc=string.gsub(desc,'Block', '')
	desc=string.gsub(desc,'Plank', ' ')
	--desc=string.gsub(desc,'  ', ' ')
	desc=string.gsub(desc,'%s+', ' ')
	
if (subname == nil)
then error(recipeitem .. ", " .. modname..", "..subname)
end
	simplyslopes.register_slope(subname, recipeitem, thisnode.groups, thisnode.tiles, desc, thisnode.sounds)
	simplyslopes.register_slopecorner(subname, recipeitem, thisnode.groups, thisnode.tiles, desc, thisnode.sounds)		
	simplyslopes.register_slopecorner2(subname, recipeitem, thisnode.groups, thisnode.tiles, desc, thisnode.sounds)
	simplyslopes.register_slopeinner(subname, recipeitem, thisnode.groups, thisnode.tiles, desc, thisnode.sounds)
	simplyslopes.register_slopeinner2(subname, recipeitem, thisnode.groups, thisnode.tiles, desc, thisnode.sounds)

end



-- Node will be called simplyslopes:<subname>
function simplyslopes.register_slope(subname, recipeitem, groups, images, description, snds)
	local newitem="simplyslopes:" .. subname,
	minetest.register_node(":simplyslopes:" .. subname, {
		description = S(description.." Slope"),
		drawtype = "mesh",
		mesh = "simplyslopes_slope.obj",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = false,
		groups = groups,
		sounds = snds,

		selection_box = {
			type = "fixed",
			fixed = {
			  {-0.5, -0.5, -0.5, 0.5, -0.1875, 0.5}, -- NodeBox1
			  {-0.5, -0.1875, -0.1875, 0.5, 0.1875, 0.5}, -- NodeBox3
			  {-0.5, 0.1875, 0.1875, 0.5, 0.5, 0.5}, -- NodeBox2
			},
		},

		collision_box = {
			type = "fixed",
			fixed = {
			  {-0.5, -0.5, -0.5, 0.5, -0.1875, 0.5}, -- NodeBox1
			  {-0.5, -0.1875, -0.1875, 0.5, 0.1875, 0.5}, -- NodeBox3
			  {-0.5, 0.1875, 0.1875, 0.5, 0.5, 0.5}, -- NodeBox2
			},
		},
		on_place = minetest.rotate_node
	})

	minetest.register_craft({
		output = newitem .. ' 6',
		recipe = {
			{recipeitem, "", ""},
			{ "",recipeitem, ""},
			{"","",recipeitem},
		},
	})
	minetest.register_craft({
		type = "shapeless" ,
		output = recipeitem ..' 1',
		recipe = {newitem, newitem},
	})
	minetest.register_alias("simplyslopes:slope_" .. subname, "simplyslopes:" .. subname)
end

-- Node will be called simplyslopes:inner_<subname>
function simplyslopes.register_slopeinner(subname, recipeitem, groups, images, description, snds)
	local newitem="simplyslopes:inner_" .. subname,
	minetest.register_node(":simplyslopes:inner_" .. subname, {
		description = description.." Inner Slope Corner",
		drawtype = "mesh",
		mesh = "simplyslopes_slopeinsidecorner.obj",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = false,
		groups = groups,
		sounds = snds,

		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
				{-0.5, 0, 0, 0.5, 0.5, 0.5},
				{-0.5, 0, -0.5, 0, 0.5, 0},
			},
		},
		collision_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
				{-0.5, 0, 0, 0.5, 0.5, 0.5},
				{-0.5, 0, -0.5, 0, 0.5, 0},
			},
		},
		on_place = minetest.rotate_node
	})


	minetest.register_craft({
		output = "simplyslopes:inner_" .. subname ..' 5',
		recipe = {
			{recipeitem, recipeitem, ""},
			{"", "", recipeitem},
			{"","", recipeitem},
		},
	})

	minetest.register_craft({
		type = "shapeless" ,
		output = recipeitem ..' 4',
		recipe = {newitem, newitem, newitem, newitem, newitem},
	})


	minetest.register_alias("simplyslopes:slopeinner_" .. subname, "simplyslopes:inner_" .. subname)
end

-- Node will be called simplyslopes:inner2_<subname>
function simplyslopes.register_slopeinner2(subname, recipeitem, groups, images, description, snds)
	local newitem="simplyslopes:inner2_" .. subname,
	minetest.register_node(":simplyslopes:inner2_" .. subname, {
		description = description.." Inner Slope Corner",
--		drawtype = "nodebox",
		drawtype = "mesh",
		mesh = "simplyslopes_slopeinsidecorner2.obj",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = false,
		groups = groups,
		sounds = snds,

		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
				{-0.5, 0, 0, 0.5, 0.5, 0.5},
				{-0.5, 0, -0.5, 0, 0.5, 0},
			},
		},
		collision_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
				{-0.5, 0, 0, 0.5, 0.5, 0.5},
				{-0.5, 0, -0.5, 0, 0.5, 0},
			},
		},
		on_place = minetest.rotate_node
	})

	minetest.register_craft({
		output = newitem .. ' 6',
		recipe = {
			{recipeitem, recipeitem, ""},
			{"", "", recipeitem},
			{recipeitem,"", recipeitem},
		},
	})
	minetest.register_craft({
		type = "shapeless" ,
		output = recipeitem ..' 5',
		recipe = {newitem, newitem, newitem, newitem, newitem, newitem},
	})

	minetest.register_alias("simplyslopes:slopeinsidecorner2_" .. subname, "simplyslopes:inner2_" .. subname)
end


-- Node will be called simplyslopes:outer_<subname>
function simplyslopes.register_slopecorner(subname, recipeitem, groups, images, description, snds)
	local newitem="simplyslopes:outer_" .. subname,
	minetest.register_node(":simplyslopes:outer_" .. subname, {
		description = description.." Outer Slope Corner",
--		drawtype = "nodebox",
		drawtype = "mesh",
		mesh = "simplyslopes_slopecorner.obj",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = false,
		groups = groups,
		sounds = snds,

		selection_box = {
			type = "fixed",
			fixed = {
			  {-0.5, -0.5, -0.5, 0.5, -0.1875, 0.5}, -- NodeBox1
			  {-0.5, -0.1875, -0.1875,  0.1875, 0.1875, 0.5}, -- NodeBox3
			  {-0.5, 0.1875, 0.1875,  -0.1875, 0.5, 0.5}, -- NodeBox2
			},
		},

		collision_box = {
			type = "fixed",
			fixed = {
			  {-0.5, -0.5, -0.5, 0.5, -0.1875, 0.5}, -- NodeBox1
			  {-0.5, -0.1875, -0.1875, 0.5, 0.1875, 0.5}, -- NodeBox3
			  {-0.5, 0.1875, 0.1875, 0.5, 0.5, 0.5}, -- NodeBox2
			},
		},
		on_place = minetest.rotate_node
	})

	minetest.register_craft({
		output = newitem .. ' 15',
		recipe = {
			{ "",recipeitem, ""},
			{recipeitem,"",recipeitem},
		},
		minetest.register_craft({
			type = "shapeless" ,
			output = recipeitem ..' 1',
			recipe = {newitem, newitem, newitem, newitem, newitem},
		})
	})


	minetest.register_alias("simplyslopes:slopecorner_" .. subname, "simplyslopes:outer_" .. subname)
end

-- Node will be called simplyslopes:outer2_<subname>
function simplyslopes.register_slopecorner2(subname, recipeitem, groups, images, description, snds)
	local newitem="simplyslopes:outer2_" .. subname,
	minetest.register_node(":simplyslopes:outer2_" .. subname, {
		description = description.." Outer Slope Corner",
--		drawtype = "nodebox",
		drawtype = "mesh",
		mesh = "simplyslopes_slopecorner2.obj",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = false,
		sunlight_propagates = true,
		groups = groups,
		sounds = snds,

		selection_box = {
			type = "fixed",
			fixed = {
			  {-0.5, -0.5, -0.5, 0.5, -0.1875, 0.5}, -- NodeBox1
			  {-0.5, -0.1875, -0.1875,  0.1875, 0.1875, 0.5}, -- NodeBox3
			  {-0.5, 0.1875, 0.1875,  -0.1875, 0.5, 0.5}, -- NodeBox2
			},
		},

		collision_box = {
			type = "fixed",
			fixed = {
			  {-0.5, -0.5, -0.5, 0.5, -0.1875, 0.5}, -- NodeBox1
			  {-0.5, -0.1875, -0.1875, 0.5, 0.1875, 0.5}, -- NodeBox3
			  {-0.5, 0.1875, 0.1875, 0.5, 0.5, 0.5}, -- NodeBox2
			},
		},
		on_place = minetest.rotate_node
	})

	minetest.register_craft({
		output = newitem .. ' 18',
		recipe = {
			{ "",recipeitem, ""},
			{"",recipeitem,recipeitem},
		},
	})
	minetest.register_craft({
		type = "shapeless" ,
		output = recipeitem ..' 1',
		recipe = {newitem, newitem, newitem, newitem, newitem, newitem},
		})
	minetest.register_alias("simplyslopes:slopecorner2_" .. subname, "simplyslopes:outer2_" .. subname)
end


-- Split string with the format mod:item to mod and item seperately
function simplyslopes.splitstring(inputstr)
	local sep = ':'
        local t={}  
	local i=1
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
                t[i] = str
                i = i + 1
        end
        return t
end

-- Helper

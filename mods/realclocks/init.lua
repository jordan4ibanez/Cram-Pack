local clock_cbox = {
	type = "fixed",
	fixed = {
		{ -8/32, -3/32, 14/32, 8/32, 3/32, 16/32 },
		{ -7/32, -5/32, 14/32, 7/32, 5/32, 16/32 },
		{ -6/32, -6/32, 14/32, 6/32, 6/32, 16/32 },
		{ -5/32, -7/32, 14/32, 5/32, 7/32, 16/32 },
		{ -3/32, -8/32, 14/32, 3/32, 8/32, 16/32 }
	}
}

local clock_sbox = {
	type = "fixed",
	fixed = { -8/32, -8/32, 14/32, 8/32, 8/32, 16/32 }
}

local materials = {"plastic", "wood"}

for _,m in ipairs(materials) do

	minetest.register_node("realclocks:analog_clock_"..m.."_12", {
		drawtype = "mesh",
		description = "Analog "..m.." clock",
		mesh = "realclocks_analog_clock.obj",
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		tiles = { "realclocks_analog_clock_"..m..".png^clock_12.png" },
		inventory_image = "realclocks_analog_clock_"..m.."_inv.png",
		wield_image = "realclocks_analog_clock_"..m.."_inv.png",
		collision_box = clock_cbox,
		selection_box = clock_sbox,
		groups = {snappy=3},
	})
	--allow both to be crafted
	local realclocks_material_thing = "default:stick"
	if m == "plastic" then
		realclocks_material_thing = "homedecor:plastic_sheeting"
	end
	minetest.register_craft({
		output = "realclocks:analog_clock_"..m.."_12",
		recipe = {
			{ "", "dye:black", "" },
			{ "", realclocks_material_thing, "" },
			{ "", "dye:black", "" },
		},
	})

	for i = 1,11 do

		minetest.register_node("realclocks:analog_clock_"..m.."_"..i, {
			drawtype = "mesh",
			mesh = "realclocks_analog_clock.obj",
			paramtype = "light",
			paramtype2 = "facedir",
			sunlight_propagates = true,
			tiles = { "realclocks_analog_clock_"..m..".png^clock_"..i..".png" },
			collision_box = clock_cbox,
			selection_box = clock_sbox,
			groups = {snappy=3, not_in_creative_inventory=1},
			drop = "realclocks:analog_clock_"..m.."_12",
		})

	end

	for n = 1,12 do

		minetest.register_abm({
			nodenames = { "realclocks:analog_clock_"..m.."_"..n },
			interval = math.min(60, (3600 / (tonumber(minetest.setting_get("time_speed")))) / 3),
			chance = 1,
			action = function(pos, node, active_object_count, active_object_count_wider)
				local hour = minetest.get_timeofday() * 24
				if hour > 12 then
					hour = hour - 12
				end
				hour = math.ceil(hour)
				if hour < 1 then
					hour = 1
				elseif hour > 12 then
					hour = 12
				end
				if node.name ~= "realclocks:analog_clock_"..m.."_"..hour then
					local fdir = minetest.get_node(pos).param2
					minetest.set_node(pos, {name="realclocks:analog_clock_"..m.."_"..hour, param2=fdir})
				end
			end
		})
		
	end
end

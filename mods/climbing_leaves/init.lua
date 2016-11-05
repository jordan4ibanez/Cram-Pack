for _,v in pairs(minetest.registered_nodes) do
	if minetest.get_item_group(v.name, "leaves") ~= 0 then
		minetest.override_item(v.name, {
			walkable = false,
			climbable = true,
		})
	end
end

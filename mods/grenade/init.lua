local def = {
	name = "grenade:explosion",
	description = "Grenade Explosion (you hacker you!)",
	radius = 3,
	tiles = {
		side = "default_dirt.png",
		top = "default_dirt.png",
		bottom = "default_dirt.png",
		burning = "default_dirt.png"
	},
}

tnt.register_tnt(def)



minetest.register_craftitem("grenade:grenade", {
	description = "Grenade",
	inventory_image = "grenade_grenade.png",
	on_use = function(itemstack, user, pointed_thing)
		local v = user:get_look_dir()
		local pos = user:getpos()
		pos.y = pos.y + 1.2

		local obj = minetest.add_entity(pos, "grenade:grenade")
		--play sound when throwing
		minetest.sound_play("tnt_ignite", {
			max_hear_distance = 20,
			gain = 10.0,
			object = obj,
		})
		obj:setvelocity({x = v.x * 7, y = v.y * 7 + 4, z = v.z * 7})
		obj:setacceleration({x = 0, y = -10, z = 0})

		itemstack:take_item()
		return itemstack
	end,
})


minetest.register_entity("grenade:grenade", {
	physical = true,
	collide_with_objects = true,
	weight = 5,
	collisionbox = {-0.25, -0.25, -0.25, 0.25, 0.25, 0.25},
	textures = {"grenade_grenade.png"},
	on_activate = function(self, staticdata)
		self.timer = 0
	end,
	on_step = function(self, dtime)
		local vel = self.object:getvelocity()
		--standard blow up on timer
		self.timer = self.timer + dtime
		if self.timer > 4 or vel.y == 0 then
			tnt.boom(self.object:getpos(), def)
			return -- to not crash
		end
		--Make grenades blow up when they hit something
		if self.oldvel then
		if  (math.abs(self.oldvel.x) ~= 0 and vel.x == 0) or
			(math.abs(self.oldvel.y) ~= 0 and vel.y == 0) or
			(math.abs(self.oldvel.z) ~= 0 and vel.z == 0) then
			tnt.boom(self.object:getpos(), def)
			return -- to not crash
		end
		end
		
		self.oldvel = vel
	end,
})
minetest.register_craft({
	output = "grenade:grenade",
	recipe = {
		{"default:stick", "default:steel_ingot", ""},
		{"default:steel_ingot", "default:coal_lump", "default:steel_ingot"},
		{"", "default:steel_ingot", ""}
	}
})

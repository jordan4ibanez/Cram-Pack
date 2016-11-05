hook_extras_workrbot={}
hook_extras_workrbot_tmp_user=""
hook_extras_dis_pvp=minetest.setting_getbool("enable_pvp")

minetest.register_craft({
	output = "hook_extras:serbotcon",
	recipe = {
		{"", "default:mese", ""},
		{"default:steel_ingot", "default:steelblock", "default:steel_ingot"},
		{"default:pick_diamond", "", "default:sword_diamond"},
	},
})
minetest.register_on_leaveplayer(function(player)
	local name=player:get_player_name()

	if hook_extras_workrbot[name] and hook_extras_workrbot[name].ob then
		hook_extras_workrbot[name].ob:set_hp(0)
		hook_extras_workrbot[name].ob:punch(hook_extras_workrbot[name].ob,1, "default:bronze_pick", nil)
	end
		hook_extras_workrbot[name]=nil
end)

minetest.register_tool("hook_extras:serbotcon", {
	description = "hook_extras servicebot (controller)",
	range = 15,
	inventory_image = "hook_extrasconroler.png",
on_use=function(itemstack, user, pointed_thing)
	hook_extras_workrbotUese(itemstack, user, pointed_thing)
	return itemstack
end,
on_place=function(itemstack, user, pointed_thing)
	hook_extras_workrbotSetMode(itemstack, user, pointed_thing)
	return itemstack
	end,
})

function hook_extras_is_unbreakable(pos)
local n=minetest.registered_nodes[minetest.get_node(pos).name]
if n==nil then return true end
return n.drop==""
end


local function hook_extras_distance(self,o)
if o==nil or o.x==nil then return nil end
local p=self.object:getpos()
return math.sqrt((p.x-o.x)*(p.x-o.x) + (p.y-o.y)*(p.y-o.y)+(p.z-o.z)*(p.z-o.z))
end

function hook_extras_visiable(pos,ob)
	if ob==nil or ob:getpos()==nil or ob:getpos().y==nil then return false end
	local ta=ob:getpos()
	local v = {x = pos.x - ta.x, y = pos.y - ta.y-1, z = pos.z - ta.z}
	v.y=v.y-1
	local amount = (v.x ^ 2 + v.y ^ 2 + v.z ^ 2) ^ 0.5
	local d=math.sqrt((pos.x-ta.x)*(pos.x-ta.x) + (pos.y-ta.y)*(pos.y-ta.y)+(pos.z-ta.z)*(pos.z-ta.z))
	v.x = (v.x  / amount)*-1
	v.y = (v.y  / amount)*-1
	v.z = (v.z  / amount)*-1
	for i=1,d,1 do
		local node=minetest.registered_nodes[minetest.get_node({x=pos.x+(v.x*i),y=pos.y+(v.y*i),z=pos.z+(v.z*i)}).name]
		if node.walkable then
			return false
		end
	end
	return true
end

local function hook_extras_serbot_walk(self)
	local pos=self.object:getpos()
	local yaw=self.object:getyaw()
	if yaw ~= yaw then
		self.status_curr=self.status_next
		return true
	end
	local x =math.sin(yaw) * -1
	local z =math.cos(yaw) * 1
	self.move.x=x
	self.move.z=z
	self.object:setvelocity({
		x = x*(self.move.speed+1),
		y = self.object:getvelocity().y,
		z = z*(self.move.speed+1)})
		setanim(self,"walk")
	return self
end

local function hook_extras_serbot_lookat(self)
	local folow
	local pos=self.object:getpos()
	if self.status_curr=="attack" then folow=self.status_target1:getpos() end
	if self.status_curr=="goto" then folow=self.status_target2 end


	if folow==nil or folow.x==nil then
		return false
	end
	local vec = {x=pos.x-folow.x, y=pos.y-folow.y, z=pos.z-folow.z}
	local yaw = math.atan(vec.z/vec.x)-math.pi/2

	if pos.x > folow.x then yaw = yaw+math.pi end
	self.object:setyaw(yaw)
	if self.status_curr~="" then hook_extras_serbot_walk(self) end
	return self
end


local hook_extras_serbot=function(self, dtime)
	self.timer=self.timer+dtime
	self.timer2=self.timer2+dtime
	if self.timer2>=0.5 then
		self.timer2=0
		if self.uname==nil or hook_extras_workrbot[self.uname]==nil then
			return self
		end

-- set status by controler
		if hook_extras_workrbot[self.uname].status~="" then
			if hook_extras_workrbot[self.uname].status=="walkto" then 
				self.status_target1={}
				self.status_target2=hook_extras_workrbot[self.uname].target2
				self.status_curr="goto"
				self.status_next="stay"
				self.status_static="stay"
			end
			if hook_extras_workrbot[self.uname].status=="attack" then 
				if not hook_extras_workrbot[self.uname].target1.e then
					self.status_target1=hook_extras_workrbot[self.uname].target1
					self.status_curr="attack"
				else
					self.status_target2=hook_extras_workrbot[self.uname].target2
					self.status_curr="goto"
				end
				self.status_static="stay"
				self.status_next="stay"
			end
			if hook_extras_workrbot[self.uname].status=="protect" then 
				self.status_target1={}
				self.status_target2={}
				self.status_target3=hook_extras_workrbot[self.uname].target3
				self.status_curr="protect"
				self.status_next="protect"
				self.status_static="protect"
			end
			if hook_extras_workrbot[self.uname].status=="settarget" then
				if not hook_extras_workrbot[self.uname].target1.e then
					self.status_target1=hook_extras_workrbot[self.uname].target1
					self.status_next=self.status_curr
					self.status_curr="attack"
				elseif not hook_extras_workrbot[self.uname].target2.e then
					self.status_target2=hook_extras_workrbot[self.uname].target2
					self.status_next=self.status_curr
					self.status_curr="goto"
				elseif not hook_extras_workrbot[self.uname].target3.e then
					self.status_target3=hook_extras_workrbot[self.uname].target3
				end
			end
			if hook_extras_workrbot[self.uname].status=="place" or hook_extras_workrbot[self.uname].status=="dig" then 
				self.status_target3=hook_extras_workrbot[self.uname].target3
				self.status_target2=hook_extras_workrbot[self.uname].target3
				self.status_target1={}
				self.status_curr="goto"
				self.status_node=hook_extras_workrbot[self.uname].node
				self.status_next=hook_extras_workrbot[self.uname].status
				self.status_static="stay"
			end
			if hook_extras_workrbot[self.uname].status=="keepdigging" then 
				self.status_target3=hook_extras_workrbot[self.uname].target3
				self.status_target2=hook_extras_workrbot[self.uname].target3
				self.status_target1={}
				self.status_curr="goto"
				self.status_next="dig"
				self.status_static="keepdigging"
				self.status_node=hook_extras_workrbot[self.uname].node
			end
			if hook_extras_workrbot[self.uname].status=="folow" then 
				self.status_target3=hook_extras_workrbot[self.uname].target3
				self.status_target2=hook_extras_workrbot[self.uname].target3
				self.status_target1={}
				self.status_curr="goto"
				self.status_next="stay"
				self.status_static="folow"
			end
			hook_extras_workrbot[self.uname].status=""
			hook_extras_workrbot[self.uname].target1={e=1}
			hook_extras_workrbot[self.uname].target2={e=1}
			hook_extras_workrbot[self.uname].target3={e=1}
		end

-- if attacking or goto
		if self.status_curr=="attack" or self.status_curr=="goto" then
			local tpos=0
			hook_extras_serbot_lookat(self)
			if self.status_curr=="goto" then
				tpos=hook_extras_distance(self,self.status_target2)
				if self.stuck_path>5 then
					self.stuck_path=0
					self.status_curr=self.status_next
				end
				if tpos==nil or tpos<=2 then
				self.status_curr=self.status_next
				if self.status_static~="keepdigging" then
					self.status_next=self.status_static
				end
				self.status_target2={}
				if self.status_curr=="stay" or self.status_curr=="place" or self.status_curr=="dig" then
					setanim(self,"stand")
					self.move.x=0
					self.move.z=0
					self.object:setvelocity({x = self.move.x, y = 0, z =self.move.z})
				end

				if self.status_target2_next.x then
					self.status_target2=self.status_target2_next
					self.status_target2_next={}
				end

				if self.status_curr=="goto" then
					local yaw=self.object:getyaw()
					if yaw ~= yaw then return true end
					yaw = yaw+math.pi
					self.object:setyaw(yaw)
					hook_extras_serbot_walk(self)
				end
				end
			end
			if self.status_curr=="attack" then
				tpos=hook_extras_distance(self,self.status_target1:getpos())
				if tpos==nil or tpos>self.distance or self.status_target1:get_hp()<=0 or
				hook_extras_visiable(self.object:getpos(),self.status_target1)==false then
					self.status_curr=self.status_next
					setanim(self,"stand")
					return self
				end
--hurting

				if tpos<=3 and math.random(3)==1 then
					self.object:setvelocity({x=0, y=self.move.y, z=0})

					if self.status_target1:get_luaentity() and self.status_target1:get_luaentity().itemstring and self.status_static~="protect" then
						self.status_target1:punch(self.user,1, "default:bronze_pick", nil)
					else
						self.status_target1:set_hp(self.status_target1:get_hp()-self.dmg)
						self.status_target1:punch(self.object,1, "default:bronze_pick", nil)
					end
					minetest.sound_play("hook_extras_punch", {pos = self.object:getpos(), gain = 1.1, max_hear_distance = 7})
					if self.axid then minetest.set_node(self.status_target1:getpos(), {name="hook_extras:acid_fire"}) end
					setanim(self,"mine")
					if self.status_target1:get_hp()<=0 and self.status_target1:is_player()==false then
						self.object:set_hp(self.object:get_hp()+5)
						setanim(self,"stand")
					end
				end
			end
		end

--jump+falling

--after jump
		if self.move.jump==1 then
			self.move.jump_timer=self.move.jump_timer-1
			if self.move.jump_timer<=0 then
				self.move.jump=0
				self.object:setacceleration({x =0, y = 0, z =0})
			end
		end
--front of a wall
		if self.move.y==0 and self.move.jump==0 then
			local ppos=self.object:getpos()
			local nodes={}
			for i=1,5,1 do --starts front of the object and y: -2 to +2
				nodes[i]=minetest.registered_nodes[minetest.get_node({x=ppos.x+self.move.x,y=ppos.y+(i-3.5),z=ppos.z+self.move.z}).name].walkable
			end

 -- jump over 2

			if (nodes[3]==true and nodes[5]==false) or (nodes[3]==false and nodes[4]==true and nodes[5]==false) then
				local pos=self.object:getpos()
				local pos3={x=pos.x,y=pos.y+1,z=pos.z}
				self.move.jump=1
				self.move.jump_timer=1
				self.move.y=3
				self.move.x=self.move.x*2
				self.move.z=self.move.z*2
				self.object:setvelocity({x = self.move.x, y = self.move.y, z =self.move.z})
				self.object:setacceleration({x =0, y = self.move.y, z =0})
			end

 -- if sides passable
			if nodes[3]==true and nodes[5]==true then
			local ispp=self.object:getpos()
			ispp={x=ispp.x+self.move.x,y=ispp.y,z=ispp.z+self.move.z}

			local yaw=self.object:getyaw()
			if yaw ~= yaw then return true end
			local z=math.sin(yaw) * -1
			local x=math.cos(yaw) * 1
			local sidel1={}
			local sidel2={}
			local sidel3={}
			local sider1={}
			local sider2={}
			local sider3={}
			for i=0,10,1 do --starts front of the object and y: -2 to +2
				sidel1[i]=minetest.registered_nodes[minetest.get_node({x=ispp.x+(x*i),y=ispp.y+1,z=ispp.z+(z*i)}).name].walkable
				sidel2[i]=minetest.registered_nodes[minetest.get_node({x=ispp.x+(x*i),y=ispp.y,     z=ispp.z+(z*i)}).name].walkable
				sidel3[i]=minetest.registered_nodes[minetest.get_node({x=ispp.x+(x*i),y=ispp.y-1,  z=ispp.z+(z*i)}).name].walkable
				if (sidel1[i]==false and sidel2[i]==false) or (sidel2[i]==false and sidel3[i]==false) then
					self.status_next=self.status_curr
					self.status_curr="goto"
					self.status_target2_next=self.status_target2
					self.status_target2={x=ispp.x+(x*i),y=ispp.y+1,z=ispp.z+(z*i)}
					hook_extras_serbot_lookat(self)
					break
				end

				sider1[i]=minetest.registered_nodes[minetest.get_node({x=ispp.x+(x*(i*-1)),y=ispp.y+1,z=ispp.z+(z*(i*-1))}).name].walkable
				sider2[i]=minetest.registered_nodes[minetest.get_node({x=ispp.x+(x*(i*-1)),y=ispp.y,     z=ispp.z+(z*(i*-1))}).name].walkable
				sider3[i]=minetest.registered_nodes[minetest.get_node({x=ispp.x+(x*(i*-1)),y=ispp.y-1, z=ispp.z+(z*(i*-1))}).name].walkable
				if (sider1[i]==false and sider2[i]==false) or (sider2[i]==false and sider3[i]==false) then
					self.status_next=self.status_curr
					self.status_curr="goto"
					self.status_target2_next=self.status_target2
					self.status_target2={x=ispp.x+(x*(i*-1)),y=ispp.y,z=ispp.z+(z*(i*-1))}
					hook_extras_serbot_lookat(self)
					break
				end
			end
			self.stuck_path=self.stuck_path+1
			end



 -- jump & attack
			if nodes[1]==false and nodes[2]==false and self.status_curr=="attack" then
				local pos=self.object:getpos()
				if minetest.registered_nodes[minetest.get_node({x=pos.x,y=pos.y-1,z=pos.z}).name].walkable==true then
					self.move.x=self.move.x*2
					self.move.z=self.move.z*2
					self.move.jump=1
					self.move.jump_timer=1
					self.object:setvelocity({x = self.move.x, y = 1, z =self.move.z})
					self.object:setacceleration({x =0, y = 1, z =0})
				end
			end
		end
--falling
		if self.move.jump==0 then
			local pos=self.object:getpos()
			local nnode=minetest.get_node({x=pos.x,y=pos.y-1.5,z=pos.z}).name
			local node=minetest.registered_nodes[nnode]
			if node and node.walkable==false then
				self.move.y=-10
				self.object:setacceleration({x =0, y = self.move.y, z =0})
			end
			if node and node.walkable==true and self.move.y~=0 then
				self.move.y=0
			end
		end
	end

	if self.timer<0.6 then return true end
--Common==========================================
	self.timer=0
	if self.object==nil then return false end
	local pos=self.object:getpos()
	self.timer3=self.timer3+0.5
-- timer3
	if self.timer3>1 then					
		self.timer3=0
-- teleport if too far away
		if self.status_static~="protect" and self.status_static~="folow" and hook_extras_distance(self,self.user:getpos())>17 then
			self.object:moveto(self.user:getpos())
			minetest.sound_play("hook_extras_teleport", {pos = self.object:getpos(), gain = 1.1, max_hear_distance = 5,})
		end
-- protect
		if self.status_static=="protect" then
			if self.status_curr~="attack" and self.status_target3~=nil and (self.status_target3:get_luaentity() or self.status_target3:is_player()) and hook_extras_distance(self,self.status_target3:getpos())>3 then
				self.status_target2=self.status_target3:getpos()
				self.status_curr="goto"
				self.status_next="stay"
				if hook_extras_distance(self,self.status_target3:getpos())>17 then
					local p=self.status_target3:getpos()
					p={x=p.x,y=p.y+1,z=p.z}
					self.object:moveto(p)
					minetest.sound_play("hook_extras_teleport", {pos = self.object:getpos(), gain = 1.1, max_hear_distance = 5,})
				end
			elseif self.status_target3==nil or (self.status_target3:get_luaentity()==nil and self.status_target3:is_player()==false) then
				self.status_curr="protect"
				self.status_target3=self.user
			elseif self.status_curr=="stay" then
				self.status_curr="protect"
			end
		end
--place

		if self.status_curr=="place" and minetest.is_protected(self.status_target3, self.uname)==false then
			local stack=self.user:get_inventory():get_stack("main", self.user:get_wield_index()-1):get_name()
			if minetest.registered_nodes[stack] then
				minetest.set_node(self.status_target3, {name=stack})
				self.user:get_inventory():remove_item("main",stack)
				minetest.sound_play("default_place_node_hard", {pos = self.object:getpos(), gain = 1.1, max_hear_distance = 5,})
				self.status_curr="stay"
			end
		end
--dig

		if self.status_curr=="dig" and minetest.is_protected(self.status_target3, self.uname)==false and hook_extras_is_unbreakable(self.status_target3)==false then
			minetest.node_dig(self.status_target3,{name=self.status_node},self.user)
			minetest.sound_play("default_dig_dig_immediate", {pos = self.object:getpos(), gain = 1.1, max_hear_distance = 5,})
			self.status_curr="stay"
		end
--keepdigging
		if self.status_static=="keepdigging" and (self.status_curr=="stay" or self.status_curr=="keepdigging") then --

			np=minetest.find_node_near(self.object:getpos(), self.distance,self.status_node)
			if np==nil then
				self.status_curr="stay"
			else
				local p={x=np.x,y=np.y+1,z=np.z}
				self.status_target3={x=np.x,y=np.y,z=np.z}
				if minetest.get_node(p).name~="air" then np.y=np.y+1 end
				self.status_target2=np
				self.status_curr="goto"
				self.status_nexr="dig"
			end
		end
--folow
		if self.status_static=="folow" then
			if self.status_target3~=nil and (self.status_target3:get_luaentity() or self.status_target3:is_player()) and hook_extras_distance(self,self.status_target3:getpos())>3 then
				self.status_target2=self.status_target3:getpos()
				self.status_curr="goto"
				self.status_next="stay"
				if hook_extras_distance(self,self.status_target3:getpos())>17 then
					local p=self.status_target3:getpos()
					p={x=p.x,y=p.y+1,z=p.z}
					self.object:moveto(p)
					minetest.sound_play("hook_extras_teleport", {pos = self.object:getpos(), gain = 1.1, max_hear_distance = 5,})
				end
			elseif self.status_target3==nil or (self.status_target3:get_luaentity()==nil and self.status_target3:is_player()==false) then
				self.status_curr="protect"
				self.status_target3=self.user
			end
		if self.object:get_hp()<self.hp_max then self.object:set_hp(self.object:get_hp()+1) end
		end
	end-- end of timer3

	if self.status_curr=="goto" then
		hook_extras_serbot_lookat(self)
	end

	if self.status_curr=="stay" then
		self.stuck_path=0
		setanim(self,"stand")
		self.move.x=0
		self.move.z=0
		self.object:setvelocity({x = self.move.x, y = 0, z =self.move.z})
	end

	if self.status_curr~="protect" then return self end
--attack
		local todmg=1
		for i, ob in pairs(minetest.get_objects_inside_radius(pos, self.distance)) do
			if ((ob:is_player() and ob:get_player_name()~=self.uname) or (ob:get_luaentity() and ob:get_luaentity().team~=self.team and ob:get_luaentity().uname~=self.uname)) and not (ob:get_attach()) then
				if hook_extras_visiable(pos,ob) and ((not ob:get_luaentity()) or (ob:get_luaentity() and (not(self.status_curr=="attack" and ob:get_luaentity().name=="__builtin:item")))) then
					if self.status_static=="protect" and self.status_target3~=nil then

						if self.status_target3:get_luaentity()==nil and self.status_target3:is_player()==nil then
							return self
						end
						local op=ob:getpos()
						local tp=self.status_target3:getpos()
						if tp==nil then
							return self
						end
						if not (op.x==tp.x and op.z==tp.z and ob:get_hp()==self.status_target3:get_hp()) then
							self.status_target1=ob
							self.status_curr="attack"
							break

						end
					else
						self.status_target1=ob
						self.status_curr="attack"
						break
					end
				end
			end
		end


		hook_extras_serbot_lookat(self)
end


function setanim(self,type)
	local curr=self.anim_curr~=type
	if	type=="stand" and curr then self.object:set_animation({ x=  0, y= 79, },30,0)
	elseif	type=="lay" and curr then  self.object:set_animation({ x=162, y=166, },30,0)
	elseif	type=="walk" and curr then  self.object:set_animation({ x=168, y=187, },30,0)
	elseif	type=="mine" and curr then  self.object:set_animation({ x=189, y=198, },30,0)
	elseif	type=="walk_mine" and curr then  self.object:set_animation({ x=200, y=219, },30,0)
	elseif	type=="sit" and curr then  self.object:set_animation({x= 81, y=160, },30,0)
	else return self
	end
	self.anim_curr=type
	return self
end

minetest.register_entity("hook_extras:serbot",{
	hp_max = 35,
	physical = true,
	weight = 5,
	collisionbox = {-0.35,-1.0,-0.35,0.35,0.8,0.35},
	visual = "mesh",
	visual_size ={x=1,y=1},
	mesh = "character.b3d",
	textures = {"hook_extras_bot.png"},
	colors = {},
	spritediv = {x=1, y=1},
	initial_sprite_basepos = {x=0, y=0},
	is_visible = true,
	makes_footstep_sound = true,
	automatic_rotate = false,
on_punch=function(self, puncher, time_from_last_punch, tool_capabilities, dir)
	if dir~=nil then self.object:setvelocity({x = dir.x*3,y = self.object:getvelocity().y,z = dir.z*3}) end
	if puncher:is_player() and (puncher:get_player_name()==self.uname or self.status_static=="folow") then return self end
	local pos=self.object:getpos()
	self.status_target1=puncher
	self.status_curr="attack"
	minetest.sound_play("hook_extras_punch", {pos = pos, gain = 1.1, max_hear_distance = 7})
	hook_extras_serbot_lookat(self)
	end,
on_activate=function(self, staticdata)
		if hook_extras_workrbot_tmp_user~="" then
			self.user=hook_extras_workrbot_tmp_user
			hook_extras_workrbot_tmp_user=""
		else
			self.object:remove()
			return self
		end
		self.uname=self.user:get_player_name()
		if hook_extras_workrbot[self.uname].ob and
		hook_extras_workrbot[self.uname].ob:get_hp() and
		hook_extras_workrbot[self.uname].ob:get_hp()>0 then 
			self.object:remove()
			return self
		end
		self.object:setvelocity({x=0,y=-1,z=0})
		self.object:setacceleration({x=0,y=-1,z=0})
		setanim(self,"stand")
	end,
on_step=hook_extras_serbot,
	anim_curr="",
	status_curr="stay",
	status_static="stay",
	status_next="",
	status_target1={},
	status_target2={},
	status_target2_next={},
	timer=0,
	timer2=0,
	timer3=0,
	move={x=0,y=0,z=0,jump=0,jump_timer=0,speed=3},
	dmg=5,
	team="workrbot",
	type = "npc",
	distance=15,
	stuck_path=0,
})


function hook_extras_workrbotUese(itemstack, user, pointed_thing)
	local item=itemstack:to_table()
	local meta=minetest.deserialize(item["metadata"])
	local mode=0
	local name=user:get_player_name()
	if meta==nil then
		hook_extras_workrbotSetMode(itemstack, user, pointed_thing)
		return itemstack
	end
	mode=(meta.mode)

	if (not hook_extras_workrbot[name]) or hook_extras_workrbot[name].ob:get_hp()<=1 then
		local p=user:getpos()
		p={x=p.x,y=p.y+1,z=p.z}
		hook_extras_workrbot_tmp_user=user
		hook_extras_workrbot[name]={}
		hook_extras_workrbot[name].status="stay"
		hook_extras_workrbot[name].target1={e=1}	--object
		hook_extras_workrbot[name].target2={e=1}	--pos
		hook_extras_workrbot[name].target3={e=1}	--static object
		if hook_extras_workrbot[name].ob and hook_extras_workrbot[name].ob:get_hp()<=1 then --  if has been removed in somehow
			hook_extras_workrbot[name].ob:set_hp(0)
			hook_extras_workrbot[name].ob:punch(hook_extras_workrbot[name].ob,1, "default:bronze_pick", nil)
			minetest.sound_play("hook_extras_punch", {pos = self.object:getpos(), gain = 1.1, max_hear_distance = 7})
		end
			hook_extras_workrbot[name].ob=minetest.env:add_entity({x=p.x,y=p.y+1,z=p.z}, "hook_extras:serbot")
			hook_extras_workrbot[name].ob:set_properties({nametag = name .." (Workrbot)", nametag_color = "#FF0000"})
	end

	if mode==1 then
		if pointed_thing.type=="node" then
			hook_extras_workrbot[name].target2=pointed_thing.above
		elseif pointed_thing.type=="object" then
			hook_extras_workrbot[name].target2=pointed_thing.ref:getpos()
		else
			return itemstack
		end
		hook_extras_workrbot[name].status="walkto"
		hook_extras_workrbot[name].target1={e=1}
		return itemstack
	end
	if mode==2 then
		if pointed_thing.type=="node" then
			hook_extras_workrbot[name].target1={e=1}
			hook_extras_workrbot[name].target2=pointed_thing.above
		elseif pointed_thing.type=="object" then
			hook_extras_workrbot[name].target2={e=1}
			hook_extras_workrbot[name].target1=pointed_thing.ref
		else
			return itemstack
		end
		hook_extras_workrbot[name].status="settarget"
		return itemstack
	end
	if mode==3 then
		if pointed_thing.type=="object" then
			hook_extras_workrbot[name].target3=pointed_thing.ref
			hook_extras_workrbot[name].target2={e=1}
			hook_extras_workrbot[name].target1={e=1}
		else
			hook_extras_workrbot[name].target3=user
			hook_extras_workrbot[name].target2={e=1}
			hook_extras_workrbot[name].target1={e=1}
		end
		hook_extras_workrbot[name].status="protect"
		return itemstack
	end
	if mode==4 then
		if pointed_thing.type=="node" and minetest.is_protected(pointed_thing.above, user:get_player_name())==false then
			hook_extras_workrbot[name].target3=pointed_thing.above
			hook_extras_workrbot[name].target2={e=1}
			hook_extras_workrbot[name].target1={e=1}
			hook_extras_workrbot[name].status="place"
		end
		return itemstack
	end
	if mode==5 then
		if pointed_thing.type=="node" and minetest.is_protected(pointed_thing.under, user:get_player_name())==false then
			hook_extras_workrbot[name].target3=pointed_thing.under
			hook_extras_workrbot[name].target2={e=1}
			hook_extras_workrbot[name].target1={e=1}
			hook_extras_workrbot[name].node=minetest.get_node(pointed_thing.under).name
			hook_extras_workrbot[name].status="dig"
		end
		return itemstack
	end
	if mode==6 then
		if pointed_thing.type=="node" and minetest.is_protected(pointed_thing.under, user:get_player_name())==false then
			hook_extras_workrbot[name].target3=pointed_thing.under
			hook_extras_workrbot[name].target2=pointed_thing.above
			hook_extras_workrbot[name].target1={}
			hook_extras_workrbot[name].node=minetest.get_node(pointed_thing.under).name
			hook_extras_workrbot[name].status="keepdigging"
		end
		return itemstack
	end
	if mode==7 then
		if pointed_thing.type=="object" then
			hook_extras_workrbot[name].target3=pointed_thing.ref
			hook_extras_workrbot[name].target2=pointed_thing.ref:getpos()
			hook_extras_workrbot[name].target1={e=1}
		else
			hook_extras_workrbot[name].target3=user
			hook_extras_workrbot[name].target2=user:getpos()
			hook_extras_workrbot[name].target1={e=1}
		end
		hook_extras_workrbot[name].status="folow"
		return itemstack
	end
	if mode==8 then
		hook_extras_workrbot[name].ob:set_hp(0)
		hook_extras_workrbot[name].ob:punch(hook_extras_workrbot[name].ob,1, "default:bronze_pick", nil)
		hook_extras_workrbot[name]=nil
		return itemstack
	end

	return itemstack
end



function hook_extras_workrbotSetMode(itemstack, user, pointed_thing)
local item=itemstack:to_table()
	local meta=minetest.deserialize(item["metadata"])
	local mode=0
	if meta==nil then
		meta={}
		mode=1 
	else
		mode=mode+1
	end
	if meta.mode==nil then
		meta.mode=1
	else
		meta.mode=meta.mode+1
	end
	mode=(meta.mode)

	if user:get_player_control().sneak then mode=mode-2 end
	if mode<=0 then mode=8 end

	local msg={}
	msg[1]="walk to"
	msg[2]="attack object"
	msg[3]="protect (point a object, or something else to you)"
	msg[4]="place block"
	msg[5]="dig block"
	msg[6]="keep digging"
	msg[7]="folow (point a object, or something else to you)"
	msg[8]="destroy"
	if msg[mode]==nil then mode=1 meta.mode=1 end
	meta.mode=mode
	item.metadata=minetest.serialize(meta)
	itemstack:replace(item)
	minetest.chat_send_player(user:get_player_name(),"workrbot mode" .. mode .. ": " .. msg[mode] )
	return itemstack
end
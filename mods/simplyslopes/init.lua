print ("[MOD] SimplySlopes loading")

simplyslopes = {}
simplyslopes.mod = "original"

	
--= Load functions that creates the differents nodes.
dofile(minetest.get_modpath("simplyslopes").."/functions.lua")

--= Default Minetest
dofile(minetest.get_modpath("simplyslopes").."/default_mod.lua")

--= Lapis Mod
if minetest.get_modpath("candy") then
	dofile(minetest.get_modpath("simplyslopes").."/candy_mod.lua")
end


--= Lapis Mod
if minetest.get_modpath("lapis") then
	dofile(minetest.get_modpath("simplyslopes").."/lapis_mod.lua")
end

--= Baked Clay mod
if minetest.get_modpath("bakedclay") then
	dofile(minetest.get_modpath("simplyslopes").."/bakedclay_mod.lua")
end

--= Wool mod
if minetest.get_modpath("wool") then
	dofile(minetest.get_modpath("simplyslopes").."/wool_mod.lua")
end

--= Farming Mod
if minetest.get_modpath("farming") then
	simplyslopes.register_all2("farming:straw")
end

--= Mobs Mod
if minetest.get_modpath("mobs") and mobs and mobs.mod and mobs.mod == "redo" then
	simplyslopes.register_all2("mobs:cheeseblock")
	simplyslopes.register_all2("mobs:honey_block")
end

--= Castle Mod
if minetest.get_modpath("castle") then
	dofile(minetest.get_modpath("simplyslopes").."/castle_mod.lua")
end


--= Homedecor Mod
if minetest.get_modpath("homedecor") then
	dofile(minetest.get_modpath("simplyslopes").."/homedecor_mod.lua")
end

--= MoreTrees Mod
if minetest.get_modpath("moretrees") then
	dofile(minetest.get_modpath("simplyslopes").."/moretrees_mod.lua")
end


--= Xanadu Mod
--= Never found and tested this mod.
if minetest.get_modpath("xanadu") then
	dofile(minetest.get_modpath("simplyslopes").."/xanadu_mod.lua")
end


--= Ethereal Mod
-- Never managed to make any blocks with this mod.
if minetest.get_modpath("ethereal") then
	dofile(minetest.get_modpath("simplyslopes").."/ethereal_mod.lua")
end



print ("[MOD] SimplySlopes loaded")

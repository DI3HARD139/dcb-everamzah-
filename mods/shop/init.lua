shop = {}

--[[shop.formspec_register = 
	"size[8,8]"..default.gui_bg..default.gui_bg_img..default.gui_slots.. 
	"label[0,0;Register]"..
	"list[current_name;shopregister;0,0.25;8;4]"..
	"list[current_player;main;0,4;8,4;]"--]]

-- Shop Register & Coin
dofile(minetest.get_modpath("shop") .. "/mapgen.lua")
dofile(minetest.get_modpath("shop") .. "/privs_shop.lua")
dofile(minetest.get_modpath("shop") .. "/register.lua")

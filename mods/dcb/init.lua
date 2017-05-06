dcb = {}

local modpath = minetest.get_modpath("dcb")

if minetest.setting_getbool("print_fields") then
	minetest.register_on_player_receive_fields(function(player, formname, fields)
		print(player:get_player_name().." on form \""..formname.."\" sends these fields:\n"..dump(fields))
	end)
end

dofile(modpath.."/book_reader.lua")		-- Send to cbd
--dofile(modpath.."/post_office.lua")		-- Send to cbd
dofile(modpath.."/give_initial_stuff.lua")
dofile(modpath.."/nopvp.lua")
dofile(modpath.."/legacy_replacer.lua")
dofile(modpath.."/crafting.lua")		-- Fence post, send to cbd?
dofile(modpath.."/sethome.lua")
dofile(modpath.."/serveressentials.lua")

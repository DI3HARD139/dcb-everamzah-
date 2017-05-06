armor_stand = {}

-- Ugly workaround !
-- override armor.set_player_armor which is called when placing/removing
-- armor pieces in the inventory. We update the formspec to display the
-- dynamic preview changes if rightclick_flag is set

armor_stand.set_player_armor = armor.set_player_armor
armor.set_player_armor = function(self,player)
	local name = player:get_player_name()
	armor_stand.set_player_armor(self,player)
	if armor_stand[name] ~= nil then
		if armor_stand[name].rightclick_flag == 1 then
			armor_stand.set_formspec(name)
			armor_stand.show_form(name)
		end
	end
end

armor_stand.set_formspec = function(name)
	armor_stand[name].formspec = "size[8,6]" ..
	default.gui_bg ..
	default.gui_bg_img ..
	default.gui_slots ..
	"label[0,0;Armor]" ..
	"list[detached:" .. name .. "_armor;armor;1.5,0.75;5,1]" ..
	"label[1.5,0;Level: " .. armor.def[name].level .. "]" ..
	"label[3.5,0;Heal: " .. armor.def[name].heal .. "]" ..
	"label[5.5,0;Fire: " .. armor.def[name].fire .. "]" ..
	"list[current_player;main;0,2.1;8,1;]" ..
	"list[current_player;main;0,3.35;8,3;8]" ..
	"listring[detached:" .. name .. "_armor;armor]" ..
	"listring[current_player;main]" ..
	default.get_hotbar_bg(0, 2.1)
end

armor_stand.show_form = function(name)
	minetest.show_formspec(name, "armor_stand", armor_stand[name].formspec)
end

minetest.register_node("armor_stand:armor_stand", {
	description = "Armor Stand",
	paramtype2 = "facedir",
	tiles = {
			"wardrobe_wardrobe_topbottom.png^wardrobe_wardrobe_front_overlay.png",
			"wardrobe_wardrobe_topbottom.png^wardrobe_wardrobe_front_overlay.png",
			"wardrobe_wardrobe_sides.png^wardrobe_wardrobe_front_overlay.png",
			"wardrobe_wardrobe_sides.png^wardrobe_wardrobe_front_overlay.png",
			"wardrobe_wardrobe_sides.png^wardrobe_wardrobe_front_overlay.png",
			"default_pine_wood.png^wardrobe_wardrobe_front_overlay.png^shields_inv_shield_wood.png"
		},
	groups = {choppy=2, oddly_breakable_by_hand=2, flammable=3},
	sounds = default.node_sound_wood_defaults(),
	on_construct = function(pos)
        	local meta = minetest.get_meta(pos)
                meta:set_string("infotext", "Armor Stand")
        end,
	on_rightclick = function(pos, node, player, itemstack, pointed_thing)
		local name = player:get_player_name()
		armor_stand[name].rightclick_flag = 1
		armor_stand.set_formspec(name)
		armor_stand.show_form(name)
	end
})

minetest.register_on_player_receive_fields(function(player, formname, fields)
	-- This is only called when the player closes the formsepc
	if formname == "armor_stand" then
		 -- Reset flag
		armor_stand[player:get_player_name()].rightclick_flag = 0
	end
end)

minetest.register_on_joinplayer(function(player)
	local name = player:get_player_name()
	armor_stand[name] = {}
	armor_stand[name].rightclick_flag = 0
end)

minetest.register_on_leaveplayer(function(player)
	local name = player:get_player_name()
	armor_stand[name] = nil -- Free mem
end)

minetest.register_craft({
	output = "armor_stand:armor_stand",
	recipe = {
		{"group:wood", "group:wood", "group:wood"},
		{"group:wood", "group:armor_use", "group:wood"},
		{"group:wood", "group:wood", "group:wood"}
	}
})

minetest.register_alias("armor_stand", "armor_stand:armor_stand")

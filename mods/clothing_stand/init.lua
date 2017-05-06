clothing_stand = {}

clothing_stand.set_player_clothing = clothing.set_player_clothing
clothing.set_player_clothing = function(self, player)
	local name = player:get_player_name()
	clothing_stand.set_player_clothing(self, player)
	if clothing_stand[name] ~= nil then
		if clothing_stand[name].rightclick_flag == 1 then
			clothing_stand.set_formspec(name)
			clothing_stand.show_form(name)
		end
	end
end

clothing_stand.set_formspec = function(name)
	clothing_stand[name].formspec = "size[8,6]" ..
	default.gui_bg ..
	default.gui_bg_img ..
	default.gui_slots ..
	"label[0,0;Clothing]" ..
	"list[detached:" .. name .. "_clothing;clothing;2,0.75;4,1]" ..
	"list[current_player;main;0,2.1;8,1;]" ..
	"list[current_player;main;0,3.35;8,3;8]" ..
	"listring[detached:" .. name .. "_clothing;clothing]" ..
	"listring[current_player;main]" ..
	default.get_hotbar_bg(0,2.1)
end

clothing_stand.show_form = function(name)
	minetest.show_formspec(name, "clothing_stand", clothing_stand[name].formspec)
end

minetest.register_node("clothing_stand:clothing_stand", {
	description = "Clothing Stand",
	paramtype2 = "facedir",
	tiles = {
                        "wardrobe_wardrobe_topbottom.png^wardrobe_wardrobe_front_overlay.png",
                        "wardrobe_wardrobe_topbottom.png^wardrobe_wardrobe_front_overlay.png",
                        "wardrobe_wardrobe_sides.png^wardrobe_wardrobe_front_overlay.png",
                        "wardrobe_wardrobe_sides.png^wardrobe_wardrobe_front_overlay.png",
                        "wardrobe_wardrobe_sides.png^wardrobe_wardrobe_front_overlay.png",
                        "default_pine_wood.png^wardrobe_wardrobe_front_overlay.png^clothing_inv_shirt_red.png"
		},
	groups = {choppy=2, oddly_breakable_by_hand=2, flammable=3},
	sounds = default.node_sound_wood_defaults(),
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", "Clothing Stand")
	end,
	on_rightclick = function(pos, node, player, itemstack, pointed_thing)
		local name = player:get_player_name()
		clothing_stand[name].rightclick_flag = 1
		clothing_stand.set_formspec(name)
		clothing_stand.show_form(name)
	end,
})

minetest.register_on_player_receive_fields(function(player, formname, fields)
	-- this is only called when the player closes the formspec
	if formname == "clothing_stand" then
		clothing_stand[player:get_player_name()].rightclick_flag = 0 -- reset flag
	end
end)

minetest.register_on_joinplayer(function(player)
	local name = player:get_player_name()
	clothing_stand[name] = {}
	clothing_stand[name].rightclick_flag = 0
end)

minetest.register_on_leaveplayer(function(player)
	local name = player:get_player_name()
	clothing_stand[name] = nil --free mem
end)

minetest.register_craft({
	output = "clothing_stand:clothing_stand",
	recipe = {
		{"group:wood", "group:wood", "group:wood"},
		{"group:wood", "group:clothing", "group:wood"},
		{"group:wood", "group:wood", "group:wood"}
	}
})

minetest.register_alias("clothing_stand", "clothing_stand:clothing_stand")

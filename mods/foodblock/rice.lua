-- Onigiri Block
minetest.register_node("foodblock:onigiri", {
	description = "Onigiri Block",
	drawtype = "nodebox",
	paramtype2 = "facedir",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-8/16,-8/16,-8/16, 8/16, 2/16, 8/16},
			{-7/16, 2/16,-8/16, 7/16, 6/16, 8/16},
			{-6/16, 6/16,-8/16, 6/16, 8/16, 8/16},
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-8/16,-8/16,-8/16, 8/16, 8/16, 8/16}, --regular
		}
	},
	tiles = {
		"foodblock_onigiri_t.png","foodblock_onigiri_b.png",
		"foodblock_onigiri_t.png","foodblock_onigiri_t.png",
		"foodblock_onigiri_s.png","foodblock_onigiri_s.png",
	},
	groups = {crumbly=2},
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_craft({
	output = "foodblock:onigiri",
	recipe = {
		{"farming:seed_wheat","farming:seed_wheat"},
		{"farming:seed_wheat","farming:seed_wheat"}
	}
})

--Onigiri Item
minetest.register_node("foodblock:onigiri_item", {
	description = "Onigiri",
	drawtype = "plantlike",
	paramtype = "light",
	tiles = {"foodblock_onigiri_item.png"},
	inventory_image = "foodblock_onigiri_item.png",
	wield_image = "foodblock_onigiri_item.png",
	groups = {dig_immediate=3},
	sounds = default.node_sound_dirt_defaults(),
	on_use = minetest.item_eat(2),
})

minetest.register_craft({
	output = "foodblock:onigiri",
	recipe = {
		{"foodblock:onigiri_item","foodblock:onigiri_item"},
		{"foodblock:onigiri_item","foodblock:onigiri_item"},
	}
})

minetest.register_craft({
	type = "shapeless",
	output = "foodblock:onigiri_item 4",
	recipe = {"foodblock:onigiri"},
})

minetest.register_craft({
	type = "shapeless",
	output = 'farming:seed_wheat 5',
	recipe = {"foodblock:onigiri","farming:seed_wheat"},
})

minetest.register_craft({
	type = "shapeless",
	output = "foodblock:onigiri_item 5",
	recipe = {"foodblock:onigiri","foodblock:onigiri_item"},
})

-- MakiSushi Block
--[[minetest.register_node("foodblock:makisushi", {
	description = "MakiSushi Block",
	paramtype2 = "facedir",
	tiles = {"foodblock_makisushi_t.png","foodblock_makisushi_t.png","foodblock_makisushi_s.png"},
	groups = {crumbly=2},
	sounds = default.node_sound_dirt_defaults(),
	on_place = minetest.rotate_node,
})

minetest.register_craft({
	output = "foodblock:makisushi",
	recipe = {
		{"fishing:sushi","fishing:sushi"},
		{"fishing:sushi","fishing:sushi"}
	}
})

minetest.register_craft({
	output = "fishing:sushi 4",
	recipe = {{"foodblock:makisushi"}},
})


-- NigiriSushi Block
minetest.register_node("foodblock:nigirisushi", {
	description = "NigiriSushi Block",
	drawtype = "nodebox",
	paramtype2 = "facedir",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-8/16, 0/16,-8/16, 8/16, 8/16, 8/16},
			{-6/16,-8/16,-8/16, 6/16, 0/16, 8/16},
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-8/16,-8/16,-8/16, 8/16, 8/16, 8/16}, --regular
		}
	},
	tiles = {
		"foodblock_nigirisushi_t.png","foodblock_nigirisushi_b.png","foodblock_nigirisushi_s.png",
		"foodblock_nigirisushi_s.png^[transformFX","foodblock_nigirisushi_f.png","foodblock_nigirisushi_f.png"
	},
	groups = {crumbly=2},
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_craft({
	output = "foodblock:nigirisushi",
	recipe = {
		{"fishing:fish_raw"},
		{"foodblock:onigiri"},
	}
})

minetest.register_craft({
	output = "foodblock:nigirisushi",
	recipe = {
		{"fishing:pike_raw"},
		{"foodblock:onigiri"},
	}
})

minetest.register_craft({
	output = "foodblock:nigirisushi",
	recipe = {
		{"ethereal:fish_raw"},
		{"foodblock:onigiri"},
	}
})

-- ethereal:sashimi's picture is kind of "makisushi"...
-- but anyway, we can make sushi from sashimi.
minetest.register_craft({
	output = "foodblock:nigirisushi",
	recipe = {
		{"ethereal:sashimi"},
		{"foodblock:onigiri"},
	}
})

--nigirisushi Item
minetest.register_node("foodblock:nigirisushi_item", {
	description = "NigiriSushi",
	drawtype = "plantlike",
	paramtype = "light",
	tiles = {"foodblock_nigirisushi_item.png"},
	inventory_image = "foodblock_nigirisushi_item.png",
	wield_image = "foodblock_nigirisushi_item.png",
	groups = {dig_immediate=3},
	sounds = default.node_sound_dirt_defaults(),
	on_use = minetest.item_eat(4),
})

minetest.register_craft({
	output = "foodblock:nigirisushi",
	recipe = {
		{"foodblock:nigirisushi_item","foodblock:nigirisushi_item"},
		{"foodblock:nigirisushi_item","foodblock:nigirisushi_item"},
	}
})

minetest.register_craft({
	type = "shapeless",
	output = "foodblock:nigirisushi_item 4",
	recipe = {"foodblock:nigirisushi"},
})]]

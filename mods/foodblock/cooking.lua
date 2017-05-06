--Custard Pudding Block
minetest.register_node("foodblock:pudding", {
	description = "Custard Pudding Block",
	paramtype = "light",
	tiles = {"foodblock_pudding_top.png","foodblock_pudding_bottom.png","foodblock_pudding_side.png"},
	groups = {crumbly=2},
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_craft({
	type = "shapeless",
	output = "foodblock:pudding",
	recipe = {"foodblock:eggblock" , "mobs:bucket_milk"},
	replacements = {
		{"mobs:bucket_milk","bucket:bucket_empty"},
	}
})

--Custard Pudding Item
minetest.register_node("foodblock:pudding_item", {
	description = "Custard Pudding",
	drawtype = "plantlike",
	paramtype = "light",
	tiles = {"foodblock_pudding_item.png"},
	inventory_image = "foodblock_pudding_item.png",
	wield_image = "foodblock_pudding_item.png",
	groups = {dig_immediate=3},
	sounds = default.node_sound_dirt_defaults(),
	on_use = minetest.item_eat(5),
})

minetest.register_craft({
	output = "foodblock:pudding_item 4",
	recipe = {{"foodblock:pudding"}},
})

minetest.register_craft({
	output = "foodblock:pudding",
	recipe = {
		{"foodblock:pudding_item","foodblock:pudding_item"},
		{"foodblock:pudding_item","foodblock:pudding_item"},
	},
})

--Apple Pie Block
minetest.register_node("foodblock:applepie", {
	description = "Apple Pie Block",
	drawtype = "nodebox",
	paramtype2 = "facedir",
	paramtype = "light",
	tiles = {"foodblock_applepie_top.png",
		"foodblock_applepie_bottom.png",
		"foodblock_applepie_side.png^[transformFX",
		"foodblock_applepie_side2.png",
		"foodblock_applepie_side2.png",
		"foodblock_applepie_side.png"
	},
	node_box = {
		type = "fixed",
		fixed = {-1/2, -1/2, -1/2, 1/2, 0, 1/2},
	},
	groups = {crumbly=2},
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_craft({
	type = "shapeless",
	output = "foodblock:applepie 2",
	recipe = {"foodblock:appleblock" , "foodblock:breadblock"},
})

minetest.register_craft({
	type = "shapeless",
	output = "foodblock:applepie",
	recipe = {"foodblock:appleblock_slab" , "foodblock:breadblock_slab"},
})

--ApplePie Item
minetest.register_node("foodblock:applepie_item", {
	description = "Apple Pie",
	drawtype = "plantlike",
	paramtype = "light",
	tiles = {"foodblock_applepie_item.png"},
	inventory_image = "foodblock_applepie_item.png",
	wield_image = "foodblock_applepie_item.png",
	groups = {dig_immediate=3},
	sounds = default.node_sound_dirt_defaults(),
	on_use = minetest.item_eat(4),
})


minetest.register_craft({
	output = "foodblock:applepie_item 4",
	recipe = {{"foodblock:applepie"}},
})

minetest.register_craft({
	output = "foodblock:applepie",
	recipe = {
		{"foodblock:applepie_item","foodblock:applepie_item"},
		{"foodblock:applepie_item","foodblock:applepie_item"},
	},
})

--Pancake Block
minetest.register_node("foodblock:pancake_slab", {
	description = "Pancake Block",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {-1/2, -1/2, -1/2, 1/2, 0, 1/2},
	},
	paramtype = "light",
	tiles = {"foodblock_pancake_top.png",
		"foodblock_pancake_bottom.png",
		"foodblock_pancake_side.png"
	},
	groups = {crumbly=2},
	sounds = default.node_sound_dirt_defaults(),
})

--Double Pancake Block
minetest.register_node("foodblock:pancake", {
	description = "Double Pancake Block",
	paramtype = "light",
	tiles = {"foodblock_pancake_top.png",
		"foodblock_pancake_bottom.png",
		"foodblock_pancake_side.png"
	},
	groups = {crumbly=2},
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_craft({
	type = "shapeless",
	output = "foodblock:pancake_slab 2",
	recipe = {"foodblock:eggblock", "foodblock:breadblock", "xdecor:honey"},
})

minetest.register_craft({
	output = "foodblock:pancake",
	recipe = {
		{"foodblock:pancake_slab"},
		{"foodblock:pancake_slab"},
	}
})

minetest.register_craft({
	output = "foodblock:pancake_slab 6",
	recipe = {
		{"foodblock:pancake","foodblock:pancake","foodblock:pancake"},
	}
})

-- Pancake Item
minetest.register_node("foodblock:pancake_item", {
	description = "Pancake",
	drawtype = "plantlike",
	paramtype = "light",
	tiles = {"foodblock_pancake_item.png"},
	inventory_image = "foodblock_pancake_item.png",
	wield_image = "foodblock_pancake_item.png",
	groups = {dig_immediate=3},
	sounds = default.node_sound_dirt_defaults(),
	on_use = minetest.item_eat(5),
})

minetest.register_craft({
	output = "foodblock:pancake_item 4",
	recipe = {{"foodblock:pancake"}},
})

minetest.register_craft({
	output = "foodblock:pancake_item 2",
	recipe = {{"foodblock:pancake_slab"}},
})

minetest.register_craft({
	output = "foodblock:pancake_slab",
	recipe = {
		{"foodblock:pancake_item","foodblock:pancake_item"},
	},
})

minetest.register_craft({
	output = "foodblock:pancake",
	recipe = {
		{"foodblock:pancake_item","foodblock:pancake_item"},
		{"foodblock:pancake_item","foodblock:pancake_item"},
	},
})

-- Hamburger Block
minetest.register_node("foodblock:hamburger", {
	description = "Hamburger Block",
	paramtype = "light",
	tiles = {"foodblock_breadblock_top.png",
		"foodblock_breadblock_bottom.png",
		"foodblock_hamburger_side.png"
	},
	groups = {crumbly=2},
	sounds = default.node_sound_dirt_defaults(),
})

-- Pancake Item
minetest.register_node("foodblock:hamburger_item", {
	description = "Hamburger",
	drawtype = "plantlike",
	paramtype = "light",
	tiles = {"foodblock_hamburger_item.png"},
	inventory_image = "foodblock_hamburger_item.png",
	wield_image = "foodblock_hamburger_item.png",
	groups = {dig_immediate=3},
	sounds = default.node_sound_dirt_defaults(),
	on_use = minetest.item_eat(8),
})

minetest.register_craft({
	type = "shapeless",
	output = "foodblock:hamburger",
	recipe = {"foodblock:breadblock" , "foodblock:meatblockraw" , "foodblock:tomatoblock"},
})

minetest.register_craft({
	output = "foodblock:hamburger_item 4",
	recipe = {
		{"foodblock:hamburger"},
	},
})

minetest.register_craft({
	output = "foodblock:hamburger",
	recipe = {
		{"foodblock:hamburger_item","foodblock:hamburger_item"},
		{"foodblock:hamburger_item","foodblock:hamburger_item"},
	},
})

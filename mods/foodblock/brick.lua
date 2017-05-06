
--Bricks

minetest.register_node("foodblock:breadbrick", {
	description = "Bread Brick",
	tiles = {"foodblock_breadbrick.png"},
	groups = {cracky=2},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	output = "foodblock:breadbrick 4",
	recipe = {
		{"foodblock:breadblock","foodblock:breadblock"},
		{"foodblock:breadblock","foodblock:breadblock"},
	}
})
minetest.register_craft({
	output = "foodblock:breadblock 4",
	recipe = {
		{"foodblock:breadbrick","foodblock:breadbrick"},
		{"foodblock:breadbrick","foodblock:breadbrick"},
	}
})

minetest.register_node("foodblock:applebrick", {
	description = "Apple Brick",
	tiles = {"foodblock_applebrick.png"},
	groups = {cracky=2},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	output = "foodblock:applebrick 4",
	recipe = {
		{"foodblock:appleblock","foodblock:appleblock"},
		{"foodblock:appleblock","foodblock:appleblock"},
	}
})
minetest.register_craft({
	output = "foodblock:appleblock 4",
	recipe = {
		{"foodblock:applebrick","foodblock:applebrick"},
		{"foodblock:applebrick","foodblock:applebrick"},
	}
})

--[[
minetest.register_node("foodblock:strawbrick", {
	description = "Strawberry Brick",
	tiles = {"foodblock_strawbrick.png"},
	groups = {cracky=2},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	output = "foodblock:strawbrick 4",
	recipe = {
		{"foodblock:strawberryblock","foodblock:strawberryblock"},
		{"foodblock:strawberryblock","foodblock:strawberryblock"},
	}
})
minetest.register_craft({
	output = "foodblock:strawberryblock 4",
	recipe = {
		{"foodblock:strawbrick","foodblock:strawbrick"},
		{"foodblock:strawbrick","foodblock:strawbrick"},
	}
})

minetest.register_node("foodblock:raspbrick", {
	description = "Raspberry Brick",
	tiles = {"foodblock_raspbrick.png"},
	groups = {cracky=2},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	output = "foodblock:raspbrick 4",
	recipe = {
		{"foodblock:raspberryblock","foodblock:raspberryblock"},
		{"foodblock:raspberryblock","foodblock:raspberryblock"},
	}
})
minetest.register_craft({
	output = "foodblock:raspberryblock 4",
	recipe = {
		{"foodblock:raspbrick","foodblock:raspbrick"},
		{"foodblock:raspbrick","foodblock:raspbrick"},
	}
})

minetest.register_node("foodblock:bluebrick", {
	description = "Blueberry Brick",
	tiles = {"foodblock_bluebrick.png"},
	groups = {cracky=2},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	output = "foodblock:bluebrick 4",
	recipe = {
		{"foodblock:blueberryblock","foodblock:blueberryblock"},
		{"foodblock:blueberryblock","foodblock:blueberryblock"},
	}
})
minetest.register_craft({
	output = "foodblock:blueberryblock 4",
	recipe = {
		{"foodblock:bluebrick","foodblock:bluebrick"},
		{"foodblock:bluebrick","foodblock:bluebrick"},
	}
})
--]]

minetest.register_node("foodblock:carrotbrick", {
	description = "Carrot Brick",
	tiles = {"foodblock_carrotbrick.png"},
	groups = {cracky=2},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	output = "foodblock:carrotbrick 4",
	recipe = {
		{"foodblock:carrotblock","foodblock:carrotblock"},
		{"foodblock:carrotblock","foodblock:carrotblock"},
	}
})
minetest.register_craft({
	output = "foodblock:carrotblock 4",
	recipe = {
		{"foodblock:carrotbrick","foodblock:carrotbrick"},
		{"foodblock:carrotbrick","foodblock:carrotbrick"},
	}
})


minetest.register_node("foodblock:potatobrick", {
	description = "Potato Brick",
	tiles = {"foodblock_potatobrick.png"},
	groups = {cracky=2},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	output = "foodblock:potatobrick 4",
	recipe = {
		{"foodblock:potatoblock","foodblock:potatoblock"},
		{"foodblock:potatoblock","foodblock:potatoblock"},
	}
})
minetest.register_craft({
	output = "foodblock:potatoblock 4",
	recipe = {
		{"foodblock:potatobrick","foodblock:potatobrick"},
		{"foodblock:potatobrick","foodblock:potatobrick"},
	}
})

minetest.register_node("foodblock:cornbrick", {
	description = "Corn Brick",
	tiles = {"foodblock_cornbrick.png"},
	groups = {cracky=2},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	output = "foodblock:cornbrick 4",
	recipe = {
		{"foodblock:corn","foodblock:corn"},
		{"foodblock:corn","foodblock:corn"},
	}
})
minetest.register_craft({
	output = "foodblock:corn 4",
	recipe = {
		{"foodblock:cornbrick","foodblock:cornbrick"},
		{"foodblock:cornbrick","foodblock:cornbrick"},
	}
})

minetest.register_node("foodblock:meatbrick", {
	description = "Meat Brick",
	tiles = {"foodblock_meatbrick.png"},
	groups = {cracky=2},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	output = "foodblock:meatbrick 4",
	recipe = {
		{"foodblock:meatblockraw","foodblock:meatblockraw"},
		{"foodblock:meatblockraw","foodblock:meatblockraw"},
	}
})
minetest.register_craft({
	output = "foodblock:meatblockraw 4",
	recipe = {
		{"foodblock:meatbrick","foodblock:meatbrick"},
		{"foodblock:meatbrick","foodblock:meatbrick"},
	}
})

--[[
minetest.register_node("foodblock:coffeebrick", {
	description = "Coffee Brick",
	tiles = {"foodblock_coffeebrick.png"},
	groups = {cracky=2},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	output = "foodblock:coffeebrick 4",
	recipe = {
		{"foodblock:coffee","foodblock:coffee"},
		{"foodblock:coffee","foodblock:coffee"},
	}
})
minetest.register_craft({
	output = "foodblock:coffee 4",
	recipe = {
		{"foodblock:coffeebrick","foodblock:coffeebrick"},
		{"foodblock:coffeebrick","foodblock:coffeebrick"},
	}
})
--]]


--[[ BREAD ]]--

minetest.register_node("foodblock:breadblock", {
	description = "Bread Block",
	tiles = {"foodblock_breadblock_top.png",
		"foodblock_breadblock_bottom.png",
		"foodblock_breadblock_side.png"
	},
	groups = {crumbly=2},
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("foodblock:breadblock_slab", {
	description = "Bread Block Half",
	drawtype = "nodebox",
	paramtype = "light",
	tiles = {"foodblock_breadblock_top.png",
		"foodblock_breadblock_bottom.png",
		"foodblock_breadblock_side.png"},
	node_box = {type = "fixed", fixed = {-1/2, -1/2, -1/2, 1/2, 0, 1/2}},
	groups = {crumbly=2},
	sounds = default.node_sound_dirt_defaults()
})

minetest.register_craft({
	output = "foodblock:breadblock",
	recipe = {{"farming:bread","farming:bread"},
		{"farming:bread","farming:bread"}
	}
})

minetest.register_craft({
	type = "shapeless",
	output = 'farming:bread 4',
	recipe = {"foodblock:breadblock"},
})

minetest.register_craft({
	output = 'foodblock:breadblock_slab 6',
	recipe = {
		{"foodblock:breadblock", "foodblock:breadblock", "foodblock:breadblock"}
	}
})

minetest.register_craft({
	output = "foodblock:breadblock",
	recipe = {
		{"foodblock:breadblock_slab"},
		{"foodblock:breadblock_slab"}
	}
})

minetest.register_craft({
	output = 'farming:bread 2',
	recipe = {
		{"foodblock:breadblock_slab"}
	}
})

--[[ APPLE ]]--

minetest.register_node("foodblock:appleblock", {
	description = "Apple Block",
	tiles = {"foodblock_appleblock_top.png","foodblock_appleblock_bottom.png","foodblock_appleblock_side.png"},
	groups = {crumbly=2},
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("foodblock:appleblock_slab", {
	description = "Apple Block Half",
	drawtype = "nodebox",
	paramtype = "light",
	tiles = {"foodblock_appleblock_halftop.png","foodblock_appleblock_bottom.png","foodblock_appleblock_side.png"},
	node_box = {
		type = "fixed",
		fixed = {-1/2, -1/2, -1/2, 1/2, 0, 1/2},
	},
	groups = {crumbly=2},
	sounds = default.node_sound_dirt_defaults()
})

minetest.register_craft({
	output = "foodblock:appleblock",
	recipe = {
		{"default:apple","default:apple"},
		{"default:apple","default:apple"}
	}
})

minetest.register_craft({
	output = 'default:apple 4',
	recipe = {{"foodblock:appleblock"}},
})

minetest.register_craft({
	output = 'foodblock:appleblock_slab 6',
	recipe = {
		{"foodblock:appleblock","foodblock:appleblock","foodblock:appleblock"}
	}
})

minetest.register_craft({
	output = "foodblock:appleblock",
	recipe = {
		{"foodblock:appleblock_slab"},
		{"foodblock:appleblock_slab"}
	}
})

minetest.register_craft({
	output = 'default:apple 2',
	recipe = {{"foodblock:appleblock_slab"}},
})

---- Red Mushroom block ----
minetest.register_node("foodblock:redmushroomblock", {
        description = "Red Mushroom Block",
        drawtype = "nodebox",
        paramtype = "light",
        tiles = {"foodblock_mushroomR_top.png",
		"foodblock_mushroomR_bottom.png",
		"foodblock_mushroomR_side.png"
	},
        node_box = {type = "fixed", fixed = {
		{-1/2, -1/4, -1/2, 1/2, 1/2, 1/2},
                {-1/4, -1/2, -1/4, 1/4, -1/4, 1/4}},
        },
        groups = {crumbly=2},
        sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("foodblock:redmushroomblock_slab", {
        description = "Red Mushroom Block Half",
        drawtype = "nodebox",
        paramtype = "light",
        tiles = {"foodblock_mushroomR_top.png",
		"foodblock_mushroomR_bottom.png",
		"foodblock_mushroomR_hside.png"
	},
        node_box = {
                type = "fixed",
                fixed = {-1/2, -1/2, -1/2, 1/2, 0, 1/2},
        },
        groups = {crumbly=2},
        sounds = default.node_sound_dirt_defaults()
})

minetest.register_craft({
        output = 'foodblock:redmushroomblock_slab 6',
        recipe = {
                {"foodblock:redmushroomblock","foodblock:redmushroomblock","foodblock:redmushroomblock"}
        }
})

minetest.register_craft({
        output = "foodblock:redmushroomblock",
        recipe = {
                {"foodblock:redmushroomblock_slab"},
                {"foodblock:redmushroomblock_slab"}
        }
})

minetest.register_craft({
        output = "foodblock:redmushroomblock",
        recipe = {
                {"flowers:mushroom_red","flowers:mushroom_red"},
                {"flowers:mushroom_red","flowers:mushroom_red"},
        }
})

minetest.register_craft({
        output = "flowers:mushroom_red 4",
        recipe = {{"foodblock:redmushroomblock"}},
})

minetest.register_craft({
        output = "flowers:mushroom_red 2",
        recipe = {{"foodblock:redmushroomblock_slab"}},
})

minetest.register_craft({
        type = "shapeless",
        output = "flowers:mushroom_red 5",
        recipe = {"foodblock:redmushroomblock","flowers:mushroom_red"},
})

minetest.register_craft({
        type = "shapeless",
        output = "flowers:mushroom_red 3",
        recipe = {"foodblock:redmushroomblock_slab","flowers:mushroom_red"},
})

---- Brown Mushroom block ----
minetest.register_node("foodblock:brownmushroomblock", {
        description = "Brown Mushroom Block",
        drawtype = "nodebox",
        paramtype = "light",
        tiles = {"foodblock_mushroomB_top.png","foodblock_mushroomB_bottom.png","foodblock_mushroomB_side.png"},
        node_box = {
                type = "fixed",
                fixed = {
                        {-1/2, -1/4, -1/2, 1/2, 1/2, 1/2},
                        {-1/4, -1/2, -1/4, 1/4, -1/4, 1/4},
                },
        },

        groups = {crumbly=2},
        sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("foodblock:brownmushroomblock_slab", {
        description = "Brown Mushrioom Block Half",
        drawtype = "nodebox",
        paramtype = "light",
        tiles = {"foodblock_mushroomB_top.png","foodblock_mushroomB_bottom.png","foodblock_mushroomB_hside.png"},
        node_box = {
                type = "fixed",
                fixed = {-1/2, -1/2, -1/2, 1/2, 0, 1/2},
        },
        groups = {crumbly=2},
        sounds = default.node_sound_dirt_defaults()
})

minetest.register_craft({
        output = 'foodblock:brownmushroomblock_slab 6',
        recipe = {
                {"foodblock:brownmushroomblock","foodblock:brownmushroomblock","foodblock:brownmushroomblock"}
        }
})

minetest.register_craft({
        output = "foodblock:brownmushroomblock",
        recipe = {
                {"foodblock:brownmushroomblock_slab"},
                {"foodblock:brownmushroomblock_slab"}
        }
})
minetest.register_craft({
        output = "foodblock:brownmushroomblock",
        recipe = {
                {"flowers:mushroom_brown","flowers:mushroom_brown"},
                {"flowers:mushroom_brown","flowers:mushroom_brown"},
        }
})

minetest.register_craft({
        output = "flowers:mushroom_brown 4",
        recipe = {{"foodblock:brownmushroomblock"}},
})

minetest.register_craft({
        output = "flowers:mushroom_brown 2",
        recipe = {{"foodblock:brownmushroomblock_slab"}},
})

minetest.register_craft({
        type = "shapeless",
        output = "flowers:mushroom_brown 5",
        recipe = {"foodblock:brownmushroomblock","flowers:mushroom_brown"},
})

minetest.register_craft({
        type = "shapeless",
        output = "flowers:mushroom_brown 3",
        recipe = {"foodblock:brownmushroomblock_slab","flowers:mushroom_brown"},
})

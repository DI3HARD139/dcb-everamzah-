---- Corn block ----

minetest.register_node("foodblock:corn", {
        description = "Corn Block",
        tiles = {"foodblock_corn_top.png",
		"foodblock_corn_bottom.png",
		"foodblock_corn_side.png"
	},
        groups = {crumbly=2},
        sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("foodblock:corn_slab", {
        description = "Corn Block Half",
        drawtype = "nodebox",
        paramtype = "light",
        tiles = {"foodblock_corn_top.png",
		"foodblock_corn_bottom.png",
		"foodblock_corn_side.png"
	},
        node_box = {type = "fixed", fixed = {-1/2, -1/2, -1/2, 1/2, 0, 1/2}},
        groups = {crumbly=2},
        sounds = default.node_sound_dirt_defaults()
})

minetest.register_craft({
        output = "foodblock:corn",
        recipe = {
                {"crops:corn_on_the_cob", "crops:corn_on_the_cob"},
                {"crops:corn_on_the_cob", "crops:corn_on_the_cob"}
        }
})

minetest.register_craft({
        output = 'foodblock:corn_slab 6',
        recipe = {
                {"foodblock:corn", "foodblock:corn", "foodblock:corn"}
        }
})

minetest.register_craft({
        output = "foodblock:corn",
        recipe = {
                {"foodblock:corn_slab"},
                {"foodblock:corn_slab"}
        }
})

minetest.register_craft({
        output = "crops:corn_on_the_cob 4",
        recipe = {{"foodblock:corn"}}
})

minetest.register_craft({
        output = "crops:corn_on_the_cob 2",
        recipe = {{"foodblock:corn_slab"}}
})


---- Tomato Block ----
minetest.register_node("foodblock:tomatoblock", {
	description = "Tomato Block",
	tiles = {"foodblock_tomatoblock_top.png",
		"foodblock_tomatoblock_bottom.png",
		"foodblock_tomatoblock_side.png"
	},
	groups = {crumbly=2},
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("foodblock:tomatoblock_slab", {
	description = "Tomato Block Half",
	drawtype = "nodebox",
	paramtype = "light",
	tiles = {"foodblock_tomato_htop.png",
		"foodblock_appleblock_bottom.png",
		"foodblock_appleblock_side.png"
	},
	node_box = {
		type = "fixed",
		fixed = {-1/2, -1/2, -1/2, 1/2, 0, 1/2},
	},
	groups = {crumbly=2},
	sounds = default.node_sound_dirt_defaults()
})

minetest.register_craft({
	output = 'foodblock:tomatoblock_slab 6',
	recipe = {{"foodblock:tomatoblock",
		"foodblock:tomatoblock",
		"foodblock:tomatoblock"}}
})

minetest.register_craft({
	output = "foodblock:tomatoblock",
	recipe = {
		{"foodblock:tomatoblock_slab"},
		{"foodblock:tomatoblock_slab"}
	}
})

minetest.register_craft({
	output = "foodblock:tomatoblock",
	recipe = {
		{"crops:tomato", "crops:tomato"},
		{"crops:tomato", "crops:tomato"},
	}
})

--Uncraft Tomatoblock
minetest.register_craft({
	output = 'crops:tomato 4',
	recipe = {{"foodblock:tomatoblock"}},
})

minetest.register_craft({
	output = 'crops:tomato 2',
	recipe = {{"foodblock:tomatoblock_slab"}},
})

-- Specified Uncraft
minetest.register_craft({
	type = "shapeless",
	output = "crops:tomato 5",
	recipe = {"foodblock:tomatoblock", "crops:tomato"},
})

minetest.register_craft({
	type = "shapeless",
	output = "crops:tomato 3",
	recipe = {"foodblock:tomatoblock_slab", "crops:tomato"},
})

--- Carrot block ----

minetest.register_node("foodblock:carrotblock", {
	description = "Carrot Block",
	tiles = {"foodblock_carrot_top.png",
		"foodblock_carrot_bottom.png",
		"foodblock_carrot_side.png"
	},
	groups = {crumbly=2},
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("foodblock:carrotblock_slab", {
	description = "Carrot Block Half",
	drawtype = "nodebox",
	paramtype = "light",
	tiles = {"foodblock_carrot_htop.png",
		"foodblock_carrot_bottom.png",
		"foodblock_carrot_side.png"
	},
	node_box = {type = "fixed", fixed = {-1/2, -1/2, -1/2, 1/2, 0, 1/2}},
	groups = {crumbly=2},
	sounds = default.node_sound_dirt_defaults()
})

minetest.register_craft({
	output = 'foodblock:carrotblock_slab 6',
	recipe = {{"foodblock:carrotblock", "foodblock:carrotblock", "foodblock:carrotblock"}}
})

minetest.register_craft({
	output = "foodblock:carrotblock",
	recipe = {{"foodblock:carrotblock_slab"}, {"foodblock:carrotblock_slab"}}
})

minetest.register_craft({
	output = "foodblock:carrotblock",
	recipe = {
		{"crops:carrot","crops:carrot"},
		{"crops:carrot","crops:carrot"}
	}
})

-- Uncraft Potatoblock
minetest.register_craft({
	output = 'crops:carrot 4',
	recipe = {{"foodblock:carrotblock"}},
})

minetest.register_craft({
	output = 'crops:carrot 2',
	recipe = {{"foodblock:carrotblock_slab"}},
})

-- Specified Uncraft
minetest.register_craft({
	type = "shapeless",
	output = "crops:carrot 5",
	recipe = {"foodblock:carrotblock", "crops:carrot"}
})

minetest.register_craft({
	type = "shapeless",
	output = "crops:carrot 3",
	recipe = {"foodblock:carrotblock_slab" , "crops:carrot"},
})

--- Potato Block ---

minetest.register_node("foodblock:potatoblock", {
	description = "Potato Block",
	tiles = {"foodblock_potato.png",
		"foodblock_potato.png",
		"foodblock_potato.png"
	},
	groups = {crumbly=2},
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("foodblock:potatoblock_slab", {
	description = "Potato Block Half",
	drawtype = "nodebox",
	paramtype = "light",
	tiles = {"foodblock_potato_htop.png",
		"foodblock_potato.png",
		"foodblock_potato.png"
	},
	node_box = {type = "fixed", fixed = {-1/2, -1/2, -1/2, 1/2, 0, 1/2}},
	groups = {crumbly=2},
	sounds = default.node_sound_dirt_defaults()
})

minetest.register_craft({
	output = 'foodblock:potatoblock_slab 6',
	recipe = {
		{"foodblock:potatoblock", "foodblock:potatoblock", "foodblock:potatoblock"}
	}
})

minetest.register_craft({
	output = "foodblock:potatoblock",
	recipe = {
		{"foodblock:potatoblock_slab"},
		{"foodblock:potatoblock_slab"}
	}
})

minetest.register_craft({
	output = "foodblock:potatoblock",
	recipe = {
		{"crops:potato","crops:potato"},
		{"crops:potato","crops:potato"}
	}
})

--Uncraft Potato Block
minetest.register_craft({
	output = 'crops:potato 4',
	recipe = {{"foodblock:potatoblock"}},
})

minetest.register_craft({
	output = 'crops:potato 2',
	recipe = {{"foodblock:potatoblock_slab"}},
})

-- Specified Uncraft
minetest.register_craft({
	type = "shapeless",
	output = "crops:potato 5",
	recipe = {"foodblock:potatoblock", "crops:potato"},
})

minetest.register_craft({
	type = "shapeless",
	output = "crops:potato 3",
	recipe = {"foodblock:potatoblock_slab", "crops:potato"},
})

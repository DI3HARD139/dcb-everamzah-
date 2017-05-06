--Raw Meat Block
minetest.register_node("foodblock:meatblockraw", {
	description = "Raw Meat Block",
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-3/16, -3/16, 7/16, 3/16, 3/16, 8/16}, --bone
			{-1/2, -1/2, -7/16, 1/2, 1/2, 7/16},  --meat
			{-3/16, -3/16, -7/16, 3/16, 3/16, -8/16}, --bone
		}
	},
	tiles = {
		"foodblock_meat_top.png","foodblock_meat_top.png","foodblock_meat_side.png",
		"foodblock_meat_side.png","foodblock_meat_front.png","foodblock_meat_front.png",
	},
	groups = {crumbly=2},
})

minetest.register_craft({
	output = "foodblock:meatblockraw",
	recipe = {
		{"mobs:meat_raw","mobs:meat_raw"},
		{"mobs:meat_raw","mobs:meat_raw"},
	}
})

--[[minetest.register_craft({
	output = "foodblock:meatblockraw",
	recipe = {
		{"creatures:flesh","creatures:flesh"},
		{"creatures:flesh","creatures:flesh"},
	}
})
minetest.register_craft({
	output = "foodblock:meatblockraw",
	recipe = {
		{"ccmobs:meat_raw","ccmobs:meat_raw"},
		{"ccmobs:meat_raw","ccmobs:meat_raw"},
	}
})
minetest.register_craft({
	output = "foodblock:meatblockraw",
	recipe = {
		{"spidermob:meat_raw","spidermob:meat_raw"},
		{"spidermob:meat_raw","spidermob:meat_raw"},
	}
})--]]

--Uncraft meatblock
if minetest.get_modpath("mobs") then
	minetest.register_craft({
		output = "mobs:meat_raw 4",
		recipe = {
			{"foodblock:meatblockraw"},
		},
	})
--[[
elseif minetest.get_modpath("creatures") then
	minetest.register_craft({
		output = "creatures:flesh 4",
		recipe = {
			{"foodblock:meatblockraw"},
		},
	})
elseif minetest.get_modpath("ccmobs") then
	minetest.register_craft({
		output = "ccmobs:meat_raw 4",
		recipe = {
			{"foodblock:meatblockraw"},
		},
	})
elseif minetest.get_modpath("spidermob") then
	minetest.register_craft({
		output = "spidermob:meat_raw 4",
		recipe = {
			{"foodblock:meatblockraw"},
		},
	})--]]
end

-- Specified Uncraft
minetest.register_craft({
	type = "shapeless",
	output = "mobs:meat_raw 5",
	recipe = {"foodblock:meatblockraw" , "mobs:meat_raw"},
})

--[[
minetest.register_craft({
	type = "shapeless",
	output = "creatures:flesh 5",
	recipe = {"foodblock:meatblockraw" , "creatures:flesh"},
})

minetest.register_craft({
	type = "shapeless",
	output = "ccmobs:meat_raw 5",
	recipe = {"foodblock:meatblockraw" , "ccmobs:meat_raw"},
})

minetest.register_craft({
	type = "shapeless",
	output = "spidermob:meat_raw 5",
	recipe = {"foodblock:meatblockraw" , "spidermob:meat_raw"},
})--]]


--MilkBlock
minetest.register_node("foodblock:milkblock", {
	description = "Milk Block",
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-6/16, 6/16, -6/16, 6/16, 1/2, 6/16}, --cap
			{-1/2, -1/2, -1/2, 1/2, 6/16, 1/2}, 
		}
	},
	tiles = {"foodblock_milk_top.png","foodblock_milk_bottom.png","foodblock_milk_side.png"},
	groups = {crumbly=2},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_craft({
	output = "foodblock:milkblock",
	recipe = {
		{"","mobs:bucket_milk",""},
		{"mobs:bucket_milk","vessels:glass_bottle","mobs:bucket_milk"},
		{"","mobs:bucket_milk",""},
	},
	replacements = {
		{"mobs:bucket_milk","bucket:bucket_empty"},
		{"mobs:bucket_milk","bucket:bucket_empty"},
		{"mobs:bucket_milk","bucket:bucket_empty"},
		{"mobs:bucket_milk","bucket:bucket_empty"},
	}
})

--[[
minetest.register_craft({
	output = "foodblock:milkblock",
	recipe = {
		{"","ccmobs:bucket_milk",""},
		{"ccmobs:bucket_milk","vessels:glass_bottle","ccmobs:bucket_milk"},
		{"","ccmobs:bucket_milk",""},
	},
	replacements = {
		{"ccmobs:bucket_milk","bucket:bucket_empty"},
		{"ccmobs:bucket_milk","bucket:bucket_empty"},
		{"ccmobs:bucket_milk","bucket:bucket_empty"},
		{"ccmobs:bucket_milk","bucket:bucket_empty"},
	}
})--]]

--Uncraft MilkBlock
if minetest.get_modpath("mobs") then
	minetest.register_craft({
		output = "vessels:glass_bottle",
		recipe = {
			{"","bucket:bucket_empty",""},
			{"bucket:bucket_empty","foodblock:milkblock","bucket:bucket_empty"},
			{"","bucket:bucket_empty",""},
		},
		replacements = {
			{"bucket:bucket_empty","mobs:bucket_milk"},
			{"bucket:bucket_empty","mobs:bucket_milk"},
			{"bucket:bucket_empty","mobs:bucket_milk"},
			{"bucket:bucket_empty","mobs:bucket_milk"},
		},
	})
--[[
elseif minetest.get_modpath("ccmobs") then
	minetest.register_craft({
		output = "vessels:glass_bottle",
		recipe = {
			{"","bucket:bucket_empty",""},
			{"bucket:bucket_empty","foodblock:milkblock","bucket:bucket_empty"},
			{"","bucket:bucket_empty",""},
		},
		replacements = {
			{"bucket:bucket_empty","ccmobs:bucket_milk"},
			{"bucket:bucket_empty","ccmobs:bucket_milk"},
			{"bucket:bucket_empty","ccmobs:bucket_milk"},
			{"bucket:bucket_empty","ccmobs:bucket_milk"},
		},
	})--]]
end

-- Specified Uncraft
minetest.register_craft({
	output = "vessels:glass_bottle",
	recipe = {
		{"mobs:bucket_milk","bucket:bucket_empty",""},
		{"bucket:bucket_empty","foodblock:milkblock","bucket:bucket_empty"},
		{"","bucket:bucket_empty",""},
	},
	replacements = {
		{"mobs:bucket_milk","mobs:bucket_milk"},
		{"bucket:bucket_empty","mobs:bucket_milk"},
		{"bucket:bucket_empty","mobs:bucket_milk"},
		{"bucket:bucket_empty","mobs:bucket_milk"},
		{"bucket:bucket_empty","mobs:bucket_milk"},
	},
})
--[[
minetest.register_craft({
	output = "vessels:glass_bottle",
	recipe = {
		{"ccmobs:bucket_milk","bucket:bucket_empty",""},
		{"bucket:bucket_empty","foodblock:milkblock","bucket:bucket_empty"},
		{"","bucket:bucket_empty",""},
	},
	replacements = {
		{"ccmobs:bucket_milk","ccmobs:bucket_milk"},
		{"bucket:bucket_empty","ccmobs:bucket_milk"},
		{"bucket:bucket_empty","ccmobs:bucket_milk"},
		{"bucket:bucket_empty","ccmobs:bucket_milk"},
		{"bucket:bucket_empty","ccmobs:bucket_milk"},
	},
})--]]

-- Egg block

--- egg block ----
minetest.register_node("foodblock:eggblock", {
	description = "Egg Block",
	tiles = {"foodblock_egg_top.png","foodblock_egg_bottom.png","foodblock_egg_side.png"},
	paramtype = "light",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-7/16, 5/16,-7/16, 7/16, 8/16, 7/16}, --cap
			{ -1/2,-7/16, -1/2,  1/2, 5/16,  1/2}, 
			{-7/16,-8/16,-7/16, 7/16,-7/16, 7/16}, 
		}
	},
	groups = {crumbly=2},
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_craft({
	output = "foodblock:eggblock",
	recipe = {
		{"mobs:egg","mobs:egg"},
		{"mobs:egg","mobs:egg"}
	}
})

--[[
minetest.register_craft({
	output = "foodblock:eggblock",
	recipe = {
		{"ccmobs:egg","ccmobs:egg"},
		{"ccmobs:egg","ccmobs:egg"}
	}
})--]]

minetest.register_node("foodblock:eggblock_slab", {
	description = "Egg Block Half",
	drawtype = "nodebox",
	paramtype = "light",
	tiles = {"foodblock_egg_htop.png","foodblock_egg_bottom.png","foodblock_egg_side.png"},
	node_box = {
		type = "fixed",
		fixed = {
			{-1/2, -7/16, -1/2, 1/2, 0, 1/2},
			{-7/16, -1/2,-7/16, 7/16,-7/16, 7/16}, 
		}
	},
	groups = {crumbly=2},
	sounds = default.node_sound_dirt_defaults()
})

minetest.register_craft({
	output = 'foodblock:eggblock_slab 6',
	recipe = {
		{"foodblock:eggblock","foodblock:eggblock","foodblock:eggblock"}
	}
})

minetest.register_craft({
	output = "foodblock:eggblock",
	recipe = {
		{"foodblock:eggblock_slab"},
		{"foodblock:eggblock_slab"}
	}
})


--Uncraft Eggblock
if minetest.get_modpath("mobs") then
	minetest.register_craft({
		output = "mobs:egg 4",
		recipe = {{"foodblock:eggblock"}},
	})
	minetest.register_craft({
		output = "mobs:egg 2",
		recipe = {{"foodblock:eggblock_slab"}},
	})
--[[
elseif minetest.get_modpath("ccmobs") then
	minetest.register_craft({
		output = "ccmobs:egg 4",
		recipe = {{"foodblock:eggblock"}},
	})
	minetest.register_craft({
		output = "ccmobs:egg 2",
		recipe = {{"foodblock:eggblock_slab"}},
	})--]]
end

-- Specified Uncraft
minetest.register_craft({
	type = "shapeless",
	output = "mobs:egg 5",
	recipe = {"foodblock:eggblock" , "mobs:egg"},
})

minetest.register_craft({
	type = "shapeless",
	output = "mobs:egg:3",
	recipe = {"foodblock:eggblock_slab" , "mobs:egg"},
})

--[[
minetest.register_craft({
	type = "shapeless",
	output = "ccmobs:egg 5",
	recipe = {"foodblock:eggblock" , "ccmobs:egg"},
})

minetest.register_craft({
	type = "shapeless",
	output = "ccmobs:egg 3",
	recipe = {"foodblock:eggblock_slab" , "ccmobs:egg"},
})--]]


xdecor.register("cardboard_box", {
	description = "Cardboard Box",
	inventory = {size=8},
	infotext = "Cardboard Box",
	groups = {snappy=3, flammable=3},
	tiles = {"xdecor_cardbox_top.png", "xdecor_cardbox_top.png", 
		"xdecor_cardbox_sides.png"},
	node_box = {
		type = "fixed", fixed = {{-0.3125, -0.5, -0.3125, 0.3125, 0, 0.3125}}
	}
})

minetest.register_craft({
	output = "xdecor:cardboard_box",
	recipe = {
		{"default:paper", "default:paper", "default:paper"},
		{"default:paper", "default:paper", "default:paper"}
	}
})

xdecor.register("chandelier", {
	description = "Chandelier",
	drawtype = "plantlike",
	walkable = false,
	inventory_image = "xdecor_chandelier.png",
	tiles = {"xdecor_chandelier.png"},
	groups = {dig_immediate=3},
	light_source = 14,
	selection_box = xdecor.nodebox.slab_y(0.5, 0.5)
})

minetest.register_craft({
	output = "xdecor:chandelier",
	recipe = {
		{"default:gold_ingot", "default:gold_ingot", "default:gold_ingot"},
		{"default:torch", "default:torch", "default:torch"}
	}
})

xdecor.register("crate", {
	description = "Crate",
	inventory = {size=24},
	infotext = "Crate",
	tiles = {"xdecor_crate.png"},
	groups = {choppy=2, oddly_breakable_by_hand=1, flammable=3},
	sounds = default.node_sound_wood_defaults()
})

minetest.register_craft({
	output = "xdecor:crate",
	recipe = {
		{"group:wood", "group:wood", "group:stick"},
		{"group:wood", "group:stick", "group:wood"},
		{"group:stick", "group:wood", "group:wood"}
	}
})

xdecor.register("plant_pot", {
	description = "Plant Pot",
	drawtype = "plantlike",
	inventory_image = "xdecor_plant_pot.png",
	wield_image = "xdecor_plant_pot.png",
	groups = {snappy=3},
	tiles = {"xdecor_plant_pot.png"},
	sounds = default.node_sound_stone_defaults()
})

xdecor.register("metal_cabinet", {
	description = "Metal Cabinet",
	inventory = {size=24},
	groups = {cracky=2},
	infotext = "Metal Cabinet",
	tiles = {
		"xdecor_metal_cabinet_sides.png", "xdecor_metal_cabinet_sides.png",
		"xdecor_metal_cabinet_sides.png", "xdecor_metal_cabinet_sides.png",
		"xdecor_metal_cabinet_sides.png", "xdecor_metal_cabinet_front.png"
	}
})

minetest.register_craft({
	output = "xdecor:metal_cabinet",
	recipe = {
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
		{"default:paper", "default:paper", "default:paper"},
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"}
	}
})

xdecor.register("stereo", {
	description = "Stereo",
	groups = {snappy=3},
	tiles = {
		"xdecor_stereo_top.png", "xdecor_stereo_bottom.png",
		"xdecor_stereo_left.png^[transformFX", "xdecor_stereo_left.png",
		"xdecor_stereo_back.png", "xdecor_stereo_front.png"
	}
})

xdecor.register("trash_can", {
	description = "Trash Can",
	tiles = {"xdecor_wood.png"},
   	groups = {choppy=3, flammable=3},
   	sunlight_propagates = true,
   	sounds = default.node_sound_wood_defaults(),
   	node_box = {
		type = "fixed",
		fixed = {
			{-0.3125, -0.5, 0.3125, 0.3125, 0.5, 0.375},
			{0.3125, -0.5, -0.375, 0.375, 0.5, 0.375},
			{-0.3125, -0.5, -0.375, 0.3125, 0.5, -0.3125},
			{-0.375, -0.5, -0.375, -0.3125, 0.5, 0.375},
			{-0.3125, -0.5, -0.3125, 0.3125, -0.4375, 0.3125}
		}
	},
	collision_box = {
		type = "fixed",
		fixed = {
			{-0.375, -0.5, -0.375, 0.375, 0.19, 0.375}
		}
	},
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", "Trash Can - throw your waste here.")
	end
})

-- Thanks to Evergreen for this code.
local old_on_step = minetest.registered_entities["__builtin:item"].on_step
minetest.registered_entities["__builtin:item"].on_step = function(self, dtime)
	if minetest.get_node(self.object:getpos()).name == "xdecor:trash_can" then
		self.object:remove()
		return
	end
	old_on_step(self, dtime)
end

xconnected.register_fence("xdecor:fence_wrought_iron", "xdecor_wrought_iron.png", nil, {
	description = "Wrought Iron Fence",
	drawtype = "fencelike",
	groups = {cracky=2},
	tiles = {"xdecor_wrought_iron.png"},
	selection_box = {
		type = "fixed",
		fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7}
	},
	inventory_image = "default_fence_overlay.png^xdecor_wrought_iron.png^default_fence_overlay.png^[makealpha:255,126,126"
})

minetest.register_craft({
	output = "xdecor:fence_wrought_iron_c4 2",
	recipe = {
		{"default:iron_lump", "default:iron_lump", "default:iron_lump"},
		{"default:iron_lump", "default:iron_lump", "default:iron_lump"}
	}
})


-----------------------------------------------------------------------
-- xconnected.lua contains the actual code and api for xconnected nodes
-----------------------------------------------------------------------
dofile(minetest.get_modpath("xconnected") .. "/xconnected.lua");



-- XPane Steel Bar
xconnected.register_pane("xconnected:bar", "xconnected_bar.png", nil, {
	description = "Steel Bar",
	tiles = {"xconnected_bar.png"},
	drawtype = "airlike",
	paramtype = "light",
	inventory_image = "xconnected_bar.png",
	wield_image = "xconnected_bar.png",
	groups = {cracky=2, oddly_breakable_by_hand=1, pane=1},
	sounds = default.node_sound_stone_defaults()
})
minetest.register_craft({
	output = "xconnected:bar_c4 16",
	recipe = {
		{"default:steel_ingot", "", "default:steel_ingot"},
		{"default:steel_ingot", "", "default:steel_ingot"},
		{"default:steel_ingot", "", "default:steel_ingot"}
	}
})

-- XPane Glass Pines
xconnected.register_pane("xconnected:pane_glass_white", "default_glass.png")
minetest.register_craft({
	output = "xconnected:pane_glass_white_c4 16",
	recipe = {
		{"default:glass", "default:glass", "default:glass"},
		{"default:glass", "default:glass", "default:glass"}
	}
})

xconnected.register_pane("xconnected:pane_glass_gray", "default_glass.png^[colorize:gray:191")
minetest.register_craft({
	output = "xconnected:pane_glass_gray_c4 16",
	recipe = {
		{"dye:grey", "dye:grey", "dye:grey"},
		{"default:glass", "default:glass", "default:glass"},
		{"default:glass", "default:glass", "default:glass"}
	}
})

xconnected.register_pane("xconnected:pane_glass_darkgray", "default_glass.png^[colorize:darkgray:191")
minetest.register_craft({
	output = "xconnected:pane_glass_darkgray_c4 16",
	recipe = {
		{"dye:dark_grey", "dye:dark_grey", "dye:dark_grey"},
		{"default:glass", "default:glass", "default:glass"},
		{"default:glass", "default:glass", "default:glass"}
	}
})

xconnected.register_pane("xconnected:pane_glass_black", "default_glass.png^[colorize:black:191")
minetest.register_craft({
	output = "xconnected:pane_glass_black_c4 16",
	recipe = {
		{"dye:black", "dye:black", "dye:black"},
		{"default:glass", "default:glass", "default:glass"},
		{"default:glass", "default:glass", "default:glass"}
	}
})

xconnected.register_pane("xconnected:pane_glass_violet", "default_glass.png^[colorize:violet:191")
minetest.register_craft({
	output = "xconnected:pane_glass_violet_c4 16",
	recipe = {
		{"dye:violet", "dye:violet", "dye:violet"},
		{"default:glass", "default:glass", "default:glass"},
		{"default:glass", "default:glass", "default:glass"}
	}
})

xconnected.register_pane("xconnected:pane_glass_blue", "default_glass.png^[colorize:blue:191")
minetest.register_craft({
	output = "xconnected:pane_glass_blue_c4 16",
	recipe = {
		{"dye:blue", "dye:blue", "dye:blue"},
		{"default:glass", "default:glass", "default:glass"},
		{"default:glass", "default:glass", "default:glass"}
	}
})

xconnected.register_pane("xconnected:pane_glass_cyan", "default_glass.png^[colorize:cyan:191")
minetest.register_craft({
	output = "xconnected:pane_glass_cyan_c4 16",
	recipe = {
		{"dye:cyan", "dye:cyan", "dye:cyan"},
		{"default:glass", "default:glass", "default:glass"},
		{"default:glass", "default:glass", "default:glass"}
	}
})

xconnected.register_pane("xconnected:pane_glass_darkgreen", "default_glass.png^[colorize:darkgreen:191")
minetest.register_craft({
	output = "xconnected:pane_glass_darkgreen_c4 16",
	recipe = {
		{"dye:dark_green", "dye:dark_green", "dye:dark_green"},
		{"default:glass", "default:glass", "default:glass"},
		{"default:glass", "default:glass", "default:glass"}
	}
})

xconnected.register_pane("xconnected:pane_glass_green", "default_glass.png^[colorize:green:191")
minetest.register_craft({
	output = "xconnected:pane_glass_green_c4 16",
	recipe = {
		{"dye:green", "dye:green", "dye:green"},
		{"default:glass", "default:glass", "default:glass"},
		{"default:glass", "default:glass", "default:glass"}
	}
})

xconnected.register_pane("xconnected:pane_glass_yellow", "default_glass.png^[colorize:yellow:191")
minetest.register_craft({
	output = "xconnected:pane_glass_yellow_c4 16",
	recipe = {
		{"dye:yellow", "dye:yellow", "dye:yellow"},
		{"default:glass", "default:glass", "default:glass"},
		{"default:glass", "default:glass", "default:glass"}
	}
})

xconnected.register_pane("xconnected:pane_glass_brown", "default_glass.png^[colorize:brown:191")
minetest.register_craft({
	output = "xconnected:pane_glass_brown_c4 16",
	recipe = {
		{"dye:brown", "dye:brown", "dye:brown"},
		{"default:glass", "default:glass", "default:glass"},
		{"default:glass", "default:glass", "default:glass"}
	}
})

xconnected.register_pane("xconnected:pane_glass_orange", "default_glass.png^[colorize:orange:191")
minetest.register_craft({
	output = "xconnected:pane_glass_orange_c4 16",
	recipe = {
		{"dye:orange", "dye:orange", "dye:orange"},
		{"default:glass", "default:glass", "default:glass"},
		{"default:glass", "default:glass", "default:glass"}
	}
})

xconnected.register_pane("xconnected:pane_glass_red", "default_glass.png^[colorize:red:191")
minetest.register_craft({
	output = "xconnected:pane_glass_red_c4 16",
	recipe = {
		{"dye:red", "dye:red", "dye:red"},
		{"default:glass", "default:glass", "default:glass"},
		{"default:glass", "default:glass", "default:glass"}
	}
})

xconnected.register_pane("xconnected:pane_glass_magenta", "default_glass.png^[colorize:magenta:191")
minetest.register_craft({
	output = "xconnected:pane_glass_magenta_c4 16",
	recipe = {
		{"dye:magenta", "dye:magenta", "dye:magenta"},
		{"default:glass", "default:glass", "default:glass"},
		{"default:glass", "default:glass", "default:glass"}
	}
})

xconnected.register_pane("xconnected:pane_glass_pink", "default_glass.png^[colorize:pink:191")
minetest.register_craft({
	output = "xconnected:pane_glass_pink_c4 16",
	recipe = {
		{"dye:pink", "dye:pink", "dye:pink"},
		{"default:glass", "default:glass", "default:glass"},
		{"default:glass", "default:glass", "default:glass"}
	}
})

-- XConnected Walls
xconnected.register_wall("xconnected:wall_tree", "default_tree.png", "default:tree")
xconnected.register_wall("xconnected:wall_wood", "default_wood.png", "default:wood")
xconnected.register_wall("xconnected:wall_stone", "default_stone.png", "default:stone")
xconnected.register_wall("xconnected:wall_cobble", "default_cobble.png", "default:cobble")
xconnected.register_wall("xconnected:wall_mossycobble", "default_mossycobble.png", "default:mossycobble")
xconnected.register_wall("xconnected:wall_brick", "default_brick.png", "default:brick")
xconnected.register_wall("xconnected:wall_stone_brick", "default_stone_brick.png", "default:stonebrick")
xconnected.register_wall("xconnected:wall_sandstone_brick", "default_sandstone_brick.png", "default:sandstonebrick")
xconnected.register_wall("xconnected:wall_desert_stone_brick", "default_desert_stone_brick.png", "default:desert_stonebrick")
xconnected.register_wall("xconnected:wall_obsidian_brick", "default_obsidian_brick.png", "default:obsidianbrick")
xconnected.register_wall("xconnected:wall_hedge", "default_leaves.png", "group:leaves")
xconnected.register_wall("xconnected:wall_clay", "default_clay.png", "default:clay")
xconnected.register_wall("xconnected:wall_coal_block", "default_coal_block.png", "default:coalblock")

-- Fences
xconnected.register_fence("xconnected:fence", "default_wood.png", nil, {
	description = "Wood Fence",
	tiles = {"default_wood.png"},
	is_ground_content = false,
	sunlight_propagates = true,
	sounds = default.node_sound_wood_defaults(),
	inventory_image = "default_fence_overlay.png^default_wood.png^default_fence_overlay.png^[makealpha:255,126,126",
	wield_image = "default_fence_overlay.png^default_wood.png^default_fence_overlay.png^[makealpha:255,126,126",
	groups = {
		choppy = 2,
		oddly_breakable_by_hand = 2,
		pane = 1,
		flammable = 2
	}
})
minetest.register_craft({
	output = "xconnected:fence_c4 6",
	recipe = {
		{"default:wood", "dcb:fence_post", "default:wood"},
		{"default:wood", "dcb:fence_post", "default:wood"}
	}
})

xconnected.register_fence("xconnected:fence_pine", "default_pine_wood.png", nil, {
	description = "Pine Wood Fence",
	tiles = {"default_pine_wood.png"},
	is_ground_content = false,
	sunlight_propagates = true,
	sounds = default.node_sound_wood_defaults(),
	inventory_image = "default_fence_overlay.png^default_pine_wood.png^default_fence_overlay.png^[makealpha:255,126,126",
	wield_image = "default_fence_overlay.png^default_pine_wood.png^default_fence_overlay.png^[makealpha:255,126,126",
	groups = {
		choppy = 2,
		oddly_breakable_by_hand = 2,
		pane = 1,
		flammable = 2
	}
})
minetest.register_craft({
	output = "xconnected:fence_pine_c4 6",
	recipe = {
		{"default:pine_wood", "dcb:fence_post", "default:pine_wood"},
		{"default:pine_wood", "dcb:fence_post", "default:pine_wood"}
	}
})

xconnected.register_fence("xconnected:fence_jungle", "default_junglewood.png", nil, {
	description = "Jungle Wood Fence",
	tiles = {"default_junglewood.png"},
	is_ground_content = false,
	sunlight_propagates = true,
	sounds = default.node_sound_wood_defaults(),
	inventory_image = "default_fence_overlay.png^default_junglewood.png^default_fence_overlay.png^[makealpha:255,126,126",
	wield_image = "default_fence_overlay.png^default_junglewood.png^default_fence_overlay.png^[makealpha:255,126,126",
	groups = {
		choppy = 2,
		oddly_breakable_by_hand = 2,
		pane = 1,
		flammable = 2
	}
})
minetest.register_craft({
	output = "xconnected:fence_jungle_c4 6",
	recipe = {
		{"default:junglewood", "dcb:fence_post", "default:junglewood"},
		{"default:junglewood", "dcb:fence_post", "default:junglewood"}
	}
})

xconnected.register_fence("xconnected:fence_acacia", "default_acacia_wood.png", nil, {
	description = "Acacia Wood Fence",
	tiles = {"default_acacia_wood.png"},
	is_ground_content = false,
	sunlight_propagates = true,
	sounds = default.node_sound_wood_defaults(),
	inventory_image = "default_fence_overlay.png^default_acacia_wood.png^default_fence_overlay.png^[makealpha:255,126,126",
	wield_image = "default_fence_overlay.png^default_acacia_wood.png^default_fence_overlay.png^[makealpha:255,126,126",
	groups = {
		choppy = 2,
		oddly_breakable_by_hand = 2,
		pane = 1,
		flammable = 2
	}
})
minetest.register_craft({
	output = "xconnected:fence_acacia_c4 6",
	recipe = {
		{"default:acacia_wood", "dcb:fence_post", "default:acacia_wood"},
		{"default:acacia_wood", "dcb:fence_post", "default:acacia_wood"}
	}
})

xconnected.register_fence("xconnected:fence_aspen", "default_aspen_wood.png", nil, {
	description = "Aspen Wood Fence",
	tiles = {"default_aspen_wood.png"},
	is_ground_content = false,
	sunlight_propagates = true,
	sounds = default.node_sound_wood_defaults(),
	inventory_image = "default_fence_overlay.png^default_aspen_wood.png^default_fence_overlay.png^[makealpha:255,126,126",
	wield_image = "default_fence_overlay.png^default_aspen_wood.png^default_fence_overlay.png^[makealpha:255,126,126",
	groups = {
		choppy = 2,
		oddly_breakable_by_hand = 2,
		pane = 1,
		flammable = 2
	}
})
minetest.register_craft({
	output = "xconnected:fence_aspen_c4 6",
	recipe = {
		{"default:aspen_wood", "dcb:fence_post", "default:aspen_wood"},
		{"default:aspen_wood", "dcb:fence_post", "default:aspen_wood"}
	}
})

-- XPanes aliases
minetest.register_alias("xpanes:pane", "xconnected:pane_glass_white_c4")
minetest.register_alias("xpanes:pane_gray", "xconnected:pane_glass_gray_c4")
minetest.register_alias("xpanes:pane_darkgray", "xconnected:pane_glass_darkgray_c4")
minetest.register_alias("xpanes:pane_black", "xconnected:pane_glass_black_c4")
minetest.register_alias("xpanes:pane_violet", "xconnected:pane_glass_violet_c4")
minetest.register_alias("xpanes:pane_blue", "xconnected:pane_glass_blue_c4")
minetest.register_alias("xpanes:pane_cyan", "xconnected:pane_glass_cyan_c4")
minetest.register_alias("xpanes:pane_darkgreen", "xconnected:pane_glass_darkgreen_c4")
minetest.register_alias("xpanes:pane_green", "xconnected:pane_glass_green_c4")
minetest.register_alias("xpanes:pane_yellow", "xconnected:pane_glass_yellow_c4")
minetest.register_alias("xpanes:pane_brown", "xconnected:pane_glass_brown_c4")
minetest.register_alias("xpanes:pane_orange", "xconnected:pane_glass_orange_c4")
minetest.register_alias("xpanes:pane_red", "xconnected:pane_glass_red_c4")
minetest.register_alias("xpanes:pane_magenta", "xconnected:pane_glass_magenta_c4")
minetest.register_alias("xpanes:pane_pink", "xconnected:pane_glass_pink_c4")

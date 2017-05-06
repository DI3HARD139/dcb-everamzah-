minetest.register_craftitem("dcb:fence_post", {
	description = "Fence Post",
	inventory_image = "dcb_fence_post.png",
})

minetest.register_craft({
	output = "dcb:fence_post 2",
	recipe = {{"group:stick", "group:stick", "group:stick"}, {"group:stick", "group:stick", "group:stick"}}
})

minetest.register_craft({
	type = "shapeless",
	output = "default:dirt_with_dry_grass",
	recipe = {"default:dirt", "default:dry_grass_1"}
})

minetest.register_craft({
	type = "shapeless",
	output = "default:dirt_with_grass",
	recipe = {"default:dirt", "default:grass_1"}
})

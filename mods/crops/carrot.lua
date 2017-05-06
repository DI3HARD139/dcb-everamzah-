
--[[

Copyright (C) 2015 - Auke Kok <sofar@foo-projects.org>

"crops" is free software; you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as
published by the Free Software Foundation; either version 2.1
of the license, or (at your option) any later version.

--]]

minetest.register_node("crops:carrot_seeds", {
	description = "Carrot Seeds",
	inventory_image = "crops_carrot_seeds.png",
	wield_image = "crops_carrot_seeds.png",
	tiles = { "crops_carrot_plant_1.png" },
	drawtype = "plantlike",
	waving = 1,
	sunlight_propagates = false,
	use_texture_alpha = true,
	walkable = false,
	paramtype = "light",
	groups = { snappy=3,flammable=3,flora=1,attached_node=1 },

	on_place = function(itemstack, placer, pointed_thing)
		local under = minetest.get_node(pointed_thing.under)
		if minetest.get_item_group(under.name, "soil") <= 1 then
			return
		end
		crops.plant(pointed_thing.above, {name="crops:carrot_plant_1"})
		if not minetest.setting_getbool("creative_mode") then
			itemstack:take_item()
		end
		return itemstack
	end
})

for stage = 1, 5 do
minetest.register_node("crops:carrot_plant_" .. stage , {
	description = "Carrot Plant",
	tiles = { "crops_carrot_plant_" .. stage .. ".png" },
	drawtype = "plantlike",
	waving = 1,
	sunlight_propagates = true,
	use_texture_alpha = true,
	walkable = false,
	paramtype = "light",
	groups = { snappy=3, flammable=3, flora=1, attached_node=1, not_in_creative_inventory=1 },
	drop = {},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5,  0.5, -0.5 + (((math.min(stage, 4)) + 1) / 5), 0.5}
	}
})
end

minetest.register_craftitem("crops:carrot", {
	description = "Carrot",
	inventory_image = "crops_carrot.png",
	on_use = minetest.item_eat(1)
})

minetest.register_craft({
	type = "shapeless",
	output = "crops:carrot_seeds",
	recipe = { "crops:carrot" }
})

--
-- the carrots "block"
--
minetest.register_node("crops:soil_with_carrots", {
	description = "Soil with Carrots",
	tiles = { "default_dirt.png^crops_carrot_soil.png", "default_dirt.png" },
	sunlight_propagates = false,
	use_texture_alpha = false,
	walkable = true,
	groups = { snappy=3, flammable=3, oddly_breakable_by_hand=2, soil=1 },
	paramtype2 = "facedir",
	drop = {max_items = 5, items = {
		{ items = {'crops:carrot'}, rarity = 1 },
		{ items = {'crops:carrot'}, rarity = 1 },
		{ items = {'crops:carrot'}, rarity = 1 },
		{ items = {'crops:carrot'}, rarity = 2 },
		{ items = {'crops:carrot'}, rarity = 5 },
	}},
	sounds = default.node_sound_dirt_defaults(),
	on_dig = function(pos, node, digger)
		local drops = {}
		-- damage 0   = drops 3-5
		-- damage 50  = drops 1-3
		-- damage 100 = drops 0-1
		local meta = minetest.get_meta(pos)
		local damage = meta:get_int("crops_damage")
		for i = 1, math.random(3 - (3 * damage / 100), 5 - (4 * (damage / 100))) do
			table.insert(drops, "crops:carrot")
		end
		core.handle_node_drops(pos, drops, digger)
		minetest.set_node(pos, { name = "farming:soil" })
		local above = { x = pos.x, y = pos.y + 1, z = pos.z }
		if minetest.get_node(above).name == "crops:carrot_plant_4" then
			minetest.set_node(above, { name = "air" })
		end
	end
})

--
-- grows a plant to mature size
--
minetest.register_abm({
	nodenames = { "crops:carrot_plant_1", "crops:carrot_plant_2", "crops:carrot_plant_3" },
	neighbors = { "group:soil" },
	interval = crops.settings.interval,
	chance = crops.settings.chance,
	action = function(pos, node, active_object_count, active_object_count_wider)
		if not crops.can_grow(pos) then
			return
		end
		local below = { x = pos.x, y = pos.y - 1, z = pos.z }
		if not minetest.registered_nodes[minetest.get_node(below).name].groups.soil then
			return
		end
		local meta = minetest.get_meta(pos)
		local damage = meta:get_int("crops_damage")
		if damage == 100 then
			minetest.set_node(pos, { name = "crops:carrot_plant_5" })
			return
		end
		local n = string.gsub(node.name, "3", "4")
		n = string.gsub(n, "2", "3")
		n = string.gsub(n, "1", "2")
		minetest.swap_node(pos, { name = n })
	end
})

--
-- grows the final carrots in the soil beneath
--
minetest.register_abm({
	nodenames = { "crops:carrot_plant_4" },
	neighbors = { "group:soil" },
	interval = crops.settings.interval,
	chance = crops.settings.chance,
	action = function(pos, node, active_object_count, active_object_count_wider)
		if not crops.can_grow(pos) then
			return
		end
		local below = { x = pos.x, y = pos.y - 1, z = pos.z }
		if not minetest.registered_nodes[minetest.get_node(below).name].groups.soil then
			return
		end
		local meta = minetest.get_meta(pos)
		local water = meta:get_int("crops_water")
		local damage = meta:get_int("crops_damage")
		local below = { x = pos.x, y = pos.y - 1, z = pos.z}
		minetest.set_node(below, { name = "crops:soil_with_carrots" })
		local meta = minetest.get_meta(below)
		meta:set_int("crops_damage", damage)
	end
})

crops.carrot_die = function(pos)
	minetest.set_node(pos, { name = "crops:carrot_plant_5" })
	local below = { x = pos.x, y = pos.y - 1, z = pos.z }
	local node = minetest.get_node(below)
	if node.name == "crops:soil_with_carrots" then
		local meta = minetest.get_meta(below)
		meta:set_int("crops_damage", 100)
	end
end

local properties = {
	die = crops.carrot_die,
	waterstart = 30,
	wateruse = 1,
	night = 5,
	soak = 80,
	soak_damage = 90,
	wither = 20,
	wither_damage = 10,
}

crops.register({ name = "crops:carrot_plant_1", properties = properties })
crops.register({ name = "crops:carrot_plant_2", properties = properties })
crops.register({ name = "crops:carrot_plant_3", properties = properties })
crops.register({ name = "crops:carrot_plant_4", properties = properties })

-- Bee by KrupnoPavel

mobs:register_mob("mobs:bee", {
	type = "animal",
	passive = true,
	hp_min = 1,
	hp_max = 2,
	armor = 200,
	collisionbox = {-0.2, -0.01, -0.2, 0.2, 0.2, 0.2},
	visual = "mesh",
	mesh = "mobs_bee.x",
	textures = {
		{"mobs_bee.png"},
	},
	makes_footstep_sound = false,
	sounds = {
		random = "mobs_bee",
	},	
	walk_velocity = 1,
	jump = true,
	drops = {
		{name = "xdecor:honey", chance = 2, min = 1, max = 2},
	},
	water_damage = 2,
	lava_damage = 2,
	light_damage = 0,
	fall_damage = 0,
	fall_speed = -3,
	animation = {
		speed_normal = 15,
		stand_start = 0,
		stand_end = 30,
		walk_start = 35,
		walk_end = 65,
	},
	on_rightclick = function(self, clicker)
		mobs:capture_mob(self, clicker, 25, 80, 0, true, nil)
	end
})

--[[
mobs:register_spawn("mobs:bee", {"group:flower", "xdecor:hive"}, 20, 10, 9000, 2, 31000, true)
--]]

mobs:register_egg("mobs:bee", "Bee", "mobs_bee_inv.png", 0)

-- Honey block
minetest.register_node("mobs:honey_block", {
	description = "Honey Block",
	tiles = {"mobs_honey_block.png"},
	groups = {snappy=3, flammable=2},
	sounds = default.node_sound_dirt_defaults()
})

minetest.register_craft({
	output = "mobs:honey_block",
	recipe = {
		{"xdecor:honey", "xdecor:honey", "xdecor:honey"},
		{"xdecor:honey", "xdecor:honey", "xdecor:honey"},
		{"xdecor:honey", "xdecor:honey", "xdecor:honey"}
	}
})

minetest.register_craft({
	output = "xdecor:honey 9",
	recipe = {
		{"mobs:honey_block"}
	}
})

minetest.register_node("dcb:backpack", {
	description = "Backpack",
	inventory_image = "dcb_backpack.png",
	tiles = {"default_wood.png^dcb_backpack.png"},
	groups = {choppy=1, cracky=1, oddly_breakable_by_hand=3},
	stack_max = 1,
})

local time = 0

local function backpack_inventory(player, state)
	player:set_inventory_formspec(dcb.get_formspec(player, state))
end

minetest.register_on_joinplayer(function(player)
	local inv = player:get_inventory()
	inv:set_size("backpack", 8*3)
	inv:set_size("modifiers", 1)
	inv:set_size("main", 8)
end)

minetest.register_globalstep(function(dtime)
	time = time + dtime
	if time > 2 then
		for _, player in ipairs(minetest.get_connected_players()) do
			if player:get_inventory():contains_item("modifiers", {name="dcb:backpack"}) then
				backpack_inventory(player, true)
			else
				backpack_inventory(player, false)
			end
		end
	end
end)

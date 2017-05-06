local clothes = {
	["shirt"] = {"clothing:shirt_red", "clothing:shirt_magenta"},
	["pants"] = {"clothing:pants_blue", "clothing:pants_cyan"}
}

minetest.register_on_newplayer(function(player)
	if minetest.setting_getbool("give_initial_stuff") then
		local name = player:get_player_name()
		local player_inv = player:get_inventory()
		minetest.log("action", "Giving initial stuff to player " .. name)

		player_inv:add_item("main", "default:pick_steel")
		player_inv:add_item("main", "default:sword_steel")
		player_inv:add_item("main", "default:axe_steel")
		player_inv:add_item("main", "default:shovel_steel")
		player_inv:add_item("main", "wool:red")
		player_inv:add_item("main", "wool:green")
		player_inv:add_item("main", "wool:blue")
		player_inv:add_item("main", "default:goldblock")

		-- Give new players some clothes
		-- TODO: Make a separate setting for clothing
		local shirt = clothes.shirt[math.random(1, #clothes.shirt)]
		local pants = clothes.pants[math.random(1, #clothes.pants)]
		minetest.after(0.1, function()
			local clothing_inv = minetest.get_inventory({type = "detached", name = name .. "_clothing"})
			if clothing_inv then
				clothing_inv:add_item("clothing", shirt)
				clothing_inv:add_item("clothing", pants)

				player_inv:add_item("clothing", shirt)
				player_inv:add_item("clothing", pants)
			else
				minetest.log("action", name .. " may be missing initial clothing.")
			end
		end)
	end
end)

hunger = {}
hunger.food = {}
hunger.players = {}

HUNGER_TICK = 300		-- time in seconds after that 1 hunger point is taken
HUNGER_HEALTH_TICK = 5		-- time in seconds after player gets healed/damaged
HUNGER_MOVE_TICK = 5		-- time in seconds after the movement is checked

HUNGER_EXHAUST_DIG = 0.5	-- exhaustion increased this value after digged node
HUNGER_EXHAUST_PLACE = 0.25	-- exhaustion increased this value after placed
HUNGER_EXHAUST_MOVE = 0.1 	-- exhaustion increased this value if player movement detected
HUNGER_EXHAUST_LVL = 25 	-- at what exhaustion player saturation gets lowered

HUNGER_HEAL = 0			-- number of HP player gets healed after HUNGER_HEALTH_TICK
HUNGER_HEAL_LVL = 1		-- lower level of saturation needed to get healed
HUNGER_STARVE = 0.25		-- number of HP player gets damaged by hunger after HUNGER_HEALTH_TICK
HUNGER_STARVE_LVL = 1		-- level of staturation that causes starving

HUNGER_MAX = 20			-- maximum level of stamina


local modpath = minetest.get_modpath("hunger")

dofile(modpath.."/functions.lua")
dofile(modpath.."/food.lua")
dofile(modpath.."/legacy.lua")

-- Callbacks
if minetest.setting_getbool("enable_damage") then
    minetest.register_on_joinplayer(function(player)
	local inv = player:get_inventory()
	inv:set_size("hunger", 1)

	local name = player:get_player_name()
	hunger[name] = {}
	if hunger.read(player) > player:get_hp() and player:get_hp() >= 0.5 then
		hunger[name].lvl = player:get_hp()
	else
		hunger[name].lvl = hunger.read(player)
	end

	hunger[name].exhaus = 0
	local lvl = hunger[name].lvl
	if lvl > 20 then
		lvl = 20
	end

	minetest.after(0.8, function()
		--hud.swap_statbar(player, "hunger", "air")
		hud.change_item(player, "hunger", {number = lvl, max = 20})
	end)

	hunger.players[name] = {
		sprinting = false,
		stamina = hunger[name].lvl,
		shouldSprint = false
	}
    end)

    minetest.register_on_leaveplayer(function(player)
	local name = player:get_player_name()
	hunger.players[name] = nil
    end)

    -- for exhaustion
    minetest.register_on_placenode(hunger.handle_node_actions)
    minetest.register_on_dignode(hunger.handle_node_actions)
    minetest.register_on_respawnplayer(function(player)
	hunger.update_hunger(player, 20)
    end)
end

local function top_face(pointed_thing)
	if not pointed_thing then return end
	return pointed_thing.above.y > pointed_thing.under.y
end

function xdecor.sit(pos, node, clicker, pointed_thing)
	if not top_face(pointed_thing) then return end
	local player_name = clicker:get_player_name()
	local objs = minetest.get_objects_inside_radius(pos, 0.1)
	local vel = clicker:get_player_velocity()
	local ctrl = clicker:get_player_control()

	for _, obj in pairs(objs) do
		if obj:is_player() and obj:get_player_name() ~= player_name then
			return
		end
	end

	if default.player_attached[player_name] then
		pos.y = pos.y - 0.5
		clicker:setpos(pos)
		clicker:set_eye_offset({x=0, y=0, z=0}, {x=0, y=0, z=0})
		clicker:set_physics_override(1, 1, 1)
		default.player_attached[player_name] = false
		default.player_set_animation(clicker, "stand", 30)

	elseif not default.player_attached[player_name] and node.param2 <= 3 and not
			ctrl.sneak and vel.x == 0 and vel.y == 0 and vel.z == 0 then

		clicker:set_eye_offset({x=0, y=-7, z=2}, {x=0, y=0, z=0})
		clicker:set_physics_override(0, 0, 0)
		clicker:setpos(pos)
		default.player_attached[player_name] = true
		default.player_set_animation(clicker, "sit", 30)

		if     node.param2 == 0 then clicker:set_look_yaw(3.15)
		elseif node.param2 == 1 then clicker:set_look_yaw(7.9)
		elseif node.param2 == 2 then clicker:set_look_yaw(6.28)
		elseif node.param2 == 3 then clicker:set_look_yaw(4.75) end
	end
end

function xdecor.sit_dig(pos, player)
	local pname = player:get_player_name()
	local objs = minetest.get_objects_inside_radius(pos, 0.1)

	for _, p in pairs(objs) do
		if not player or not player:is_player() or p:get_player_name() or
				default.player_attached[pname] then
			return false
		end
	end
	return true
end

minetest.register_globalstep(function(dtime)
	local players = minetest.get_connected_players()
	for i=1, #players do
		local name = players[i]:get_player_name()
		if default.player_attached[name] and not players[i]:get_attach() and
				(players[i]:get_player_control().up == true or
				players[i]:get_player_control().down == true or
				players[i]:get_player_control().left == true or
				players[i]:get_player_control().right == true or
				players[i]:get_player_control().jump == true) then
			--print("Attachment moved")
			--print(dump(players[i]:get_attach()))
			players[i]:set_eye_offset({x=0, y=0, z=0}, {x=0, y=0, z=0})
			players[i]:set_physics_override(1, 1, 1)
			default.player_attached[name] = false
			default.player_set_animation(players[i], "stand", 30)
		end
	end
end)

minetest.register_chatcommand("sit", {
	func = function(name)
		local player = minetest.get_player_by_name(name)
		if default.player_attached[name] then
			player:set_eye_offset({x=0, y=0, z=0}, {x=0, y=0, z=0})
			player:set_physics_override(1, 1, 1)
			default.player_attached[name] = false
			default.player_set_animation(player, "stand", 30)
		else
			player:set_eye_offset({x=0, y=-7, z=2}, {x=0, y=0, z=0})
			player:set_physics_override(0, 0, 0)
			default.player_attached[name] = true
			default.player_set_animation(player, "sit", 30)
		end
	end
})

minetest.register_chatcommand("lay", {
	func = function(name)
		local player = minetest.get_player_by_name(name)
		if default.player_attached[name] then
			player:set_eye_offset({x=0, y=0, z=0}, {x=0, y=0, z=0})
			player:set_physics_override(1, 1, 1)
			default.player_attached[name] = false
			default.player_set_animation(player, "stand", 30)
		else
			player:set_eye_offset({x=0, y=-13, z=0}, {x=0, y=0, z=0})
			player:set_physics_override(0, 0, 0)
			default.player_attached[name] = true
			default.player_set_animation(player, "lay", 0)
		end
	end
})

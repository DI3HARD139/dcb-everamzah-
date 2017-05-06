local homes_file = minetest.get_worldpath() .. "/homes"
local homepos = {}

dcb.globalhomepos = {} -- Used in beds mod.

local function loadhomes()
    local input = io.open(homes_file, "r")
    if input then
                repeat
            local x = input:read("*n")
            if x == nil then
                break
            end
            local y = input:read("*n")
            local z = input:read("*n")
            local name = input:read("*l")
            homepos[name:sub(2)] = {x = x, y = y, z = z}
        until input:read(0) == nil
        io.close(input)
    else
        homepos = {}
    end
    dcb.globalhomepos = homepos
end

loadhomes()

minetest.register_privilege("home", "Can use /sethome and /home")

local changed = false

minetest.register_chatcommand("home", {
    description = "Go to your home",
    params = "<name>",
    privs = {home=true},
    func = function(name, param)
        local player = minetest.get_player_by_name(name)
        if player == nil then
            return false
        end

	if param ~= "" and minetest.check_player_privs(name, {teleport=true}) then
	    if homepos[param] then
		player:setpos(homepos[param])
		cmsg.push_message_player(player, "Teleported to "..param.."'s home")
	        return true --, "Teleported to "..param.."'s home."
	    else
		cmsg.push_message_player(player, param.." has no home set.")
		return false --, param.." has no home set."
	    end
	else
            if homepos[player:get_player_name()] then
	        player:setpos(homepos[player:get_player_name()])
		cmsg.push_message_player(player, "Teleported to home!")
		return true --, "Teleported to home!"
	    else
		cmsg.push_message_player(player, "Set a home using /sethome")
		return false
	    end
	end
    end,
})

dcb.sethome = function(player)
	local name = player:get_player_name()
	if not minetest.check_player_privs(name, {home = true}) then
		cmsg.push_message_player(player, "You lack the home priv!")
		return
	end
	local pos = player:getpos()
	homepos[name] = pos
	cmsg.push_message_player(player, "Home set!")
	changed = true
	if changed then
		local output = io.open(homes_file, "w")
	    for i, v in pairs(homepos) do
		output:write(v.x.." "..v.y.." "..v.z.." "..i.."\n")
	    end
	    io.close(output)
	    changed = false
	end
end

minetest.register_chatcommand("sethome", {
    description = "Set your home",
    privs = {home = true},
    func = function(name)
        local player = minetest.get_player_by_name(name)
	dcb.sethome(player)
        --[[local pos = player:getpos()
        homepos[player:get_player_name()] = pos
        --minetest.chat_send_player(name, "Home set!")
        changed = true
        if changed then
                local output = io.open(homes_file, "w")
            for i, v in pairs(homepos) do
                output:write(v.x.." "..v.y.." "..v.z.." "..i.."\n")
            end
            io.close(output)
            changed = false
        end--]]
    end
})

dcb.get_formspec = function(player)
	local formspec = "size[8,8.5]" ..
		default.gui_bg ..
		default.gui_bg_img ..
		default.gui_slots ..
		"button_exit[0.25,0.6;1.5,3;home;Home]" ..
		"button_exit[0.25,1.6;1.5,3;spawn;Spawn]" ..
		"list[current_player;main;0,4.25;8,1;]" ..
		"list[current_player;main;0,5.5;8,3;8]" ..
		"list[current_player;craft;2,0.5;3,3;]" ..
		"list[current_player;craftpreview;6,1.5;1,1;]" ..
		"image[5,1.5;1,1;gui_furnace_arrow_bg.png^[transformR270]" ..
		"listring[current_player;main]" ..
		"listring[current_player;craft]" ..
		default.get_hotbar_bg(0,4.25)
	return formspec
end

minetest.register_on_joinplayer(function(player)
	player:set_inventory_formspec(dcb.get_formspec(player))
end)

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "" then return end
	local player_name = player:get_player_name()
	if fields.home then
		if not minetest.check_player_privs(
				player_name, {home=true}) then
			--[[minetest.chat_send_player(player_name,
				"You lack the necessary privilege: home")--]]
			cmsg.push_message_player(player, "You lack the necessary privilege: home")
			return
		end
		if homepos[player_name] then
			player:setpos(homepos[player_name])
			--[[minetest.chat_send_player(
				player_name, "Teleported to home!")--]]
			cmsg.push_message_player(player, "Teleported to home!")
		else
			local pos = player:getpos()
			homepos[player_name] = pos
			--[[minetest.chat_send_player(
				player_name,
				"Home set!  Use /sethome to set a new one.")--]]
			cmsg.push_message_player(player, "Home set! Use /sethome again to change location")
			changed = true
			if changed then
				local output = io.open(homes_file, "w")
			    for i, v in pairs(homepos) do
				output:write(
					v.x.." "..v.y.." "..v.z.." "..i.."\n")
			    end
			    io.close(output)
			    changed = false
			end
		end
        end
	if fields.spawn then
		if not minetest.check_player_privs(
				player_name, {spawn = true}) then
			--[[minetest.chat_send_player(player_name,
				"You lack the necessary privilege: spawn")--]]
			cmsg.push_message_player(player, "You lack the necessary privilege: spawn")
			return
		end
		local spawnpos = minetest.setting_get_pos("static_spawnpoint") or {x = 0, y = 0, z = 0}
		if not spawnpos then return end
		player:setpos(spawnpos)
		--minetest.chat_send_player(player_name, "Teleported to spawn!")
		cmsg.push_message_player(player, "Teleported to spawn!")
	end
end)

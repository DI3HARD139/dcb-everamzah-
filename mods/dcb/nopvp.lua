local nopvp = AreaStore()
local nopvp_areas = {}
local mark_file = minetest.get_worldpath() .. "/mark"

local input = io.open(mark_file, "r")
if input then
	nopvp_areas = minetest.deserialize(input:read())
	io.close(input)
	for _, v in pairs(nopvp_areas) do
		nopvp:insert_area(nopvp_areas[_][1], nopvp_areas[_][2], "nopvp")
	end
end

local nopvp_mark_p1 = {}
local nopvp_mark_p2 = {}

minetest.register_chatcommand("mark", {
	description = "Mark an area for disabling of PVP", -- Make general for other purposes
	privs = {server=true},
	params = "[p1] [p2] [list] [del]",
	func = function(name, params)
		local player = minetest.get_player_by_name(name)
		local pos = player:getpos()
		local spos = {x=math.floor(pos.x), y=math.floor(pos.y), z=math.floor(pos.z)}

		if params == "p1" then
			nopvp_mark_p1[name] = spos
			minetest.chat_send_player(name,
				spos.x..","..spos.y..","..spos.z.." marked as position 1.")
		elseif params == "p2" and nopvp_mark_p1[name] then
			nopvp_mark_p2[name] = spos
			if nopvp_mark_p1[name] and nopvp_mark_p2[name] then
				nopvp:insert_area(nopvp_mark_p1[name], nopvp_mark_p2[name], "nopvp")
				table.insert(nopvp_areas, {nopvp_mark_p1[name], nopvp_mark_p2[name]})
				local changed = true
			        if changed then
			                local output = io.open(mark_file, "w")
					output:write(minetest.serialize(nopvp_areas))
				       	io.close(output)
					changed = false
				end

				nopvp_mark_p1[name] = {}
				nopvp_mark_p2[name] = {}

				minetest.chat_send_player(name,
					spos.x..","..spos.y..","..spos.z.." marked as position 2.")
			end
		elseif params == "list" then
			--minetest.chat_send_player(name, "Info sent to stdout, sorry to disappoint!")
			print("Size of nopvp_areas table: "..#nopvp_areas)
			print("Contents of nopvp:get_areas_for_pos():\n"..dump(nopvp:get_areas_for_pos(pos)))
			print("Size of nopvp:get_areas_for_pos():")
			print(#nopvp:get_areas_for_pos(pos))
			print("For i in #nopvp_areas do print dump nopvp:get_areas_for_pos(pos)[i]:\n")
			for i=1, #nopvp_areas do
				local gotten_areas = nopvp:get_areas_for_pos(pos)
				if gotten_areas[i] and gotten_areas[i].min then
					print(dump(gotten_areas[i]))
					minetest.chat_send_player(name, "["..i.."]: "..
						"("..gotten_areas[i].min.x..", "..
						gotten_areas[i].min.y..", "..
						gotten_areas[i].min.z..") "..
						"("..gotten_areas[i].max.x..", "..
						gotten_areas[i].max.y..", "..
						gotten_areas[i].max.z..")")
				end
			end
		elseif params == "del" then
			minetest.chat_send_player(name, "This function isn't implemented yet.")
		else
			minetest.chat_send_player(name, "Start with /mark p1, then create a NOPVP zone with /mark p2.")
		end
	end
})


minetest.register_on_punchplayer(function(player, hitter, time_from_last_punch, tool_capabilities, dir, damage)
	if damage > 0 then
		local pos = player:getpos()
		local gotten_areas = nopvp:get_areas_for_pos(pos)

		for i=1, #nopvp_areas do
			if gotten_areas[i] and gotten_areas[i].min then
				return true
			end
		end
	end
end)

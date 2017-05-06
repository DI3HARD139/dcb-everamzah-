-- Post Office

--[[

* Textlist of mailbox owners
* Itemstack automatically sends on put
* Add button checks for homepos
	Scans for mailbox within 5 node radius
	Add coords if found, update textlist

--]]

local player_index = 1
local revPlayers = {}
local receiver = ""

local post_listing = ""
local post_registry = {}


local postoffice_formspec = function(pos, player)
	local spos = pos.x..","..pos.y..","..pos.z
	local formspec = "size[8,9]"..default.gui_bg..default.gui_bg_img..default.gui_slots..
	"textlist[0,0;6.825,5;index;"..post_listing..";1]"..
	"label[7,0;Send]"..
	"button_exit[7,4.25;1,1;add;Add]"..
	"list[nodemeta:"..spos..";send;7,0.5;1,1;]"..
	"list[current_player;main;0,5.25;8,4;]"..
	"listring[]"
	minetest.show_formspec(player, "dcb:post_office", formspec)
end

minetest.register_node("dcb:post_office", {
	description = "Post Office",
	tiles = {"default_chest_top.png^default_sign.png"},
	groups = {choppy=3, snappy=2, cracky=2, oddly_breakable_by_hand=1},
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", "Post Office")
	end,
	after_place_node = function(pos, placer)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		inv:set_size("send", 1)
	end,
	on_rightclick = function(pos, node, clicker, itemstack)
		postoffice_formspec(pos, clicker:get_player_name())
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		if post_listing ~= "" then
			return -1
		else
			return 0
		end
	end,
	on_metadata_inventory_put = function(pos, listname, index, stack, player)
		if receiver == "" then return end
		local dest = post_registry[revPlayers[player_index]]
		local mailbox = dest.mailbox
		local mmeta = minetest.get_meta(minetest.string_to_pos(mailbox))
		local minv = mmeta:get_inventory()
		if minv:room_for_item("main", stack) then
			minv:add_item("main", stack)
		end
		print(dump(minetest.get_node(minetest.string_to_pos(mailbox))))
	end,
})

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "dcb:post_office" then
		return
	end
	if fields.add then
		local p = player:get_player_name()
		if not post_registry[p] then post_registry[p] = {["home"]="", ["mailbox"]=""} end
		if sethome.globalhomepos[p] then
			local home = sethome.globalhomepos[p]
			local x = math.floor(home.x)
			local y = math.floor(home.y)
			local z = math.floor(home.z)
			local home_string = x..","..y..","..z
			if post_registry[p]["home"] == home_string then print("already added") return 0 end
			post_registry[p]["home"] = home_string

			local positions = minetest.find_nodes_in_area(
				{x=x-5, y=y-5, z=z-5},
				{x=x+5, y=y+5, z=z+5},
				{"xdecor:mailbox"})
			if (positions[1]) then
				post_registry[p]["mailbox"] = positions[1].x..","..positions[1].y..","..positions[1].z
				local itr = ""
				for n, c in pairs(post_registry) do
					itr = itr..tostring(n)..","
				end
				post_listing = string.sub(itr, 0, -2)

				revPlayers = {}
				for i, v in pairs(post_registry) do
					table.insert(revPlayers, i)
				end
				receiver = revPlayers[player_index]
				minetest.chat_send_player(p, "Mailbox found and added.")
			end
		end
	end
	if fields.index then
		player_index = minetest.explode_textlist_event(fields.index)["index"]
		receiver = revPlayers[player_index]
		print(revPlayers[player_index])
	end
end)

minetest.register_privilege("delprotect", "Ignore player protection")

protector = {}
protector.mod = "redo"
protector.radius = (tonumber(minetest.setting_get("protector_radius")) or 5)

protector.get_member_list = function(meta)

	return meta:get_string("members"):split(" ")
end

protector.set_member_list = function(meta, list)

	meta:set_string("members", table.concat(list, " "))
end

protector.is_member = function (meta, name)

	for _, n in pairs(protector.get_member_list(meta)) do

		if n == name then
			return true
		end
	end

	return false
end

protector.add_member = function(meta, name)

	if protector.is_member(meta, name) then
		return
	end

	local list = protector.get_member_list(meta)

	table.insert(list, name)

	protector.set_member_list(meta, list)
end

protector.del_member = function(meta, name)

	local list = protector.get_member_list(meta)

	for i, n in pairs(list) do

		if n == name then
			table.remove(list, i)
			break
		end
	end

	protector.set_member_list(meta, list)
end

-- Protector Interface

protector.generate_formspec = function(pos)
	local spos = pos.x..","..pos.y..","..pos.z
	local formspec = "size[8,9]"..
		default.gui_bg..default.gui_bg_img..default.gui_slots..
		--"label[0,-0.1;Lease:]"..
		"item_image[0,0;1,1;cbd:lease_written]"..
		"list[nodemeta:"..spos..";main;0,0;1,1;]"..
		"label[0,1.25;Members:]"..
		"list[current_player;main;0,5;8,4;]"

	local meta = minetest.get_meta(pos)
	local members = protector.get_member_list(meta)
	local npp = 12 -- max users added onto protector list
	local i = 0

	for _, member in pairs(members) do
			if i < npp then
				formspec = formspec .. "button["..(i%4*2)..","
				..math.floor(i/4+2)..";1.5,.5;protector_member;"..member.."]"
				formspec = formspec .. "button["..(i%4*2+1.25)..","
				..math.floor(i/4+2)..";.75,.5;protector_del_member_"..member..";X]"
			end
			i = i + 1
	end
	
	if i < npp then
		formspec = formspec
		.."field["..(i%4*2+1/3)..","..(math.floor(i/4+2)+1/3)..";1.433,.5;protector_add_member;;]"
		formspec = formspec
		.."button["..(i%4*2+1/3+0.9)..","..(math.floor(i/4+2))..";0.75,0.5;close_me;+]"
	end

	return formspec
end

-- Infolevel:
-- 0 for no info
-- 1 for "This area is owned by <owner> !" if you can't dig
-- 2 for "This area is owned by <owner>.
-- 3 for checking protector overlaps

protector.can_dig = function(r, pos, digger, onlyowner, infolevel)

	if not digger
	or not pos then
		return false
	end

	-- Delprotect privileged users can override protections

	if minetest.check_player_privs(digger, {delprotect = true})
	and infolevel == 1 then
		return true
	end

	if infolevel == 3 then infolevel = 1 end

	-- Find the protector nodes

	local positions = minetest.find_nodes_in_area(
		{x = pos.x - r, y = pos.y - r, z = pos.z - r},
		{x = pos.x + r, y = pos.y + r, z = pos.z + r},
		{"protector:protect", "protector:protect2"})

	local meta, owner, members

	for _, pos in pairs(positions) do

		meta = minetest.get_meta(pos)
		owner = meta:get_string("owner")
		members = meta:get_string("members")

		if owner ~= digger then 

			if onlyowner
			or not protector.is_member(meta, digger) then

				if infolevel == 1 then

					cmsg.push_message_player(minetest.get_player_by_name(digger),
						"This area is owned by " .. owner .. "!")

				elseif infolevel == 2 then

					cmsg.push_message_player(minetest.get_player_by_name(digger),
						"This area is owned by " .. owner .. ".")

					minetest.chat_send_player(digger,
						"Protected by " .. owner .. " at: " .. minetest.pos_to_string(pos))

					if members ~= "" then

						minetest.chat_send_player(digger,
							"Members: " .. members .. ".")
					end
				end

				return false
			end
		end

		if infolevel == 2 then

			cmsg.push_message_player(minetest.get_player_by_name(digger),
				"This area is owned by " .. owner .. ".")

			minetest.chat_send_player(digger,
				"Protected by " .. owner .. " at: " .. minetest.pos_to_string(pos))

			if members ~= "" then

				minetest.chat_send_player(digger,
					"Members: " .. members .. ".")
			end

			return false
		end

	end

	if infolevel == 2 then
		if #positions < 1 then
			cmsg.push_message_player(minetest.get_player_by_name(digger),
				"This area is not protected.")
		end

		cmsg.push_message_player(minetest.get_player_by_name(digger),
			"You can build here.")
	end

	return true
end

-- Can node be added or removed, if so return node else true (for protected)

protector.old_is_protected = minetest.is_protected
minetest.is_protected = function(pos, digger)

	if protector.can_dig(protector.radius, pos, digger, false, 1) then
		return protector.old_is_protected(pos, digger)
	else
		return true
	end
end

-- Make sure protection block doesn't overlap another protector's area
function protector.check_overlap(itemstack, placer, pointed_thing)

	if pointed_thing.type ~= "node" then
		return itemstack
	end

	if not protector.can_dig(protector.radius * 2, pointed_thing.above,
	placer:get_player_name(), true, 3) then

		cmsg.push_message_player(placer,
			"Overlaps into a protected area.")

		return
	end

	return minetest.item_place(itemstack, placer, pointed_thing)

end

local function after_place_node(pos, placer)
	local meta = minetest.get_meta(pos)
	meta:set_string("owner", placer:get_player_name() or "")
	meta:set_string("infotext", "Protection owned by "..meta:get_string("owner"))
	meta:set_string("members", "")
	meta:set_string("property", "")
	meta:set_string("tenant", "")
	local inv = meta:get_inventory()
	inv:set_size("main", 1)
end

local function on_use(itemstack, user, pointed_thing)
	if pointed_thing.type ~= "node" then return end
	protector.can_dig(protector.radius, pointed_thing.under, user:get_player_name(), false, 2)
end

local function on_rightclick(pos, node, clicker, itemstack)
	if protector.can_dig(1, pos, clicker:get_player_name(), true, 1) then
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		if inv:is_empty("main") then
			inv:set_size("main", 1)
		end
		minetest.show_formspec(clicker:get_player_name(), 
		"protector:node_"..minetest.pos_to_string(pos), protector.generate_formspec(pos))
	else
		if clicker:get_wielded_item():get_name() == "cbd:lease_written" then
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			local player_name = clicker:get_player_name()
			local data = minetest.deserialize(itemstack:get_metadata())
			if data.property == meta:get_string("property") and
			    meta:get_string("tenant") == "" then
				meta:set_string("tenant", player_name)
				protector.add_member(meta, player_name)
				itemstack:clear()
			end
		end
	end
end

local function on_punch(pos, node, puncher)
	if not protector.can_dig(1, pos, puncher:get_player_name(), true, 1) then
		return
	end
	minetest.add_entity(pos, "protector:display")
end

local function can_dig(pos, player)
	return protector.can_dig(1, pos, player:get_player_name(), true, 1)
end

local function on_metadata_inventory_put(pos, listname, index, stack, player)
	local player_name = player:get_player_name()
	local data = minetest.deserialize(stack:get_metadata())
	local property, tenant, owner = "", "", player_name
	if data then
		property, tenant, owner = data.property, data.tenant, data.owner
	end
	local meta = minetest.get_meta(pos)
	meta:set_string("property", property)
	meta:set_string("infotext", property.."\nOwned by "..player_name)
	if tenant then
		meta:set_string("tenant", tenant)
		protector.add_member(meta, tenant)
	end
	minetest.show_formspec(player_name, "protector:node_"..minetest.pos_to_string(pos), protector.generate_formspec(pos))
end

local function on_metadata_inventory_take(pos, listname, index, stack, player)
	local player_name = player:get_player_name()
	local data = minetest.deserialize(stack:get_metadata())
	local property, tenant, owner = "", "", player_name
	if data then
		property, tenant, owner = data.property, data.tenant, data.owner
	end
	local meta = minetest.get_meta(pos)
	meta:set_string("property", "")
	meta:set_string("infotext", "Protection owned by "..player_name)
	if tenant then
		meta:set_string("tenant", "")
		protector.del_member(meta, tenant)
	end
	minetest.show_formspec(player_name, "protector:node_"..minetest.pos_to_string(pos), protector.generate_formspec(pos))
end

local function allow_metadata_inventory_put(pos, listname, index, stack, player)
	if stack:get_name() == "cbd:lease_written" then
		return 1
	end
	return 0
end

minetest.register_node("protector:protect", {
	description = "Protection Block",
	tiles = {"xdecor_stone_rune.png","xdecor_stone_rune.png","xdecor_stone_rune.png^protector_logo.png"},
	sounds = default.node_sound_stone_defaults(),
	groups = {dig_immediate=2,unbreakable=1},
	drawtype = "nodebox",
	node_box = {
		type="fixed",
		fixed = { -0.5, -0.5, -0.5, 0.5, 0.5, 0.5 },
	},
	selection_box = { type="regular" },
	paramtype = "light",
	light_source = 2,

	on_place = protector.check_overlap,
	after_place_node = after_place_node,
	on_use = on_use,
	on_rightclick = on_rightclick,
	on_punch = on_punch,
	can_dig = can_dig,
	on_metadata_inventory_put = on_metadata_inventory_put,
	on_metadata_inventory_take = on_metadata_inventory_take,
	allow_metadata_inventory_put = allow_metadata_inventory_put
})

minetest.register_node("protector:protect2", {
	description = "Protection Logo",
	tiles = {"protector_logo.png"},
	wield_image = "protector_logo.png",
	inventory_image = "protector_logo.png",
	sounds = default.node_sound_stone_defaults(),
	groups = {dig_immediate = 2, unbreakable = 1},
	paramtype = 'light',
	paramtype2 = "wallmounted",
	light_source = 2,
	drawtype = "nodebox",
	sunlight_propagates = true,
	walkable = true,
	node_box = {
		type = "wallmounted",
		wall_top    = {-0.375, 0.4375, -0.5, 0.375, 0.5, 0.5},
		wall_bottom = {-0.375, -0.5, -0.5, 0.375, -0.4375, 0.5},
		wall_side   = {-0.5, -0.5, -0.375, -0.4375, 0.5, 0.375},
	},
	selection_box = {type = "wallmounted"},
	on_place = protector.check_overlap,
	after_place_node = after_place_node,
	on_use = on_use,
	on_rightclick = on_rightclick,
	on_punch = on_punch,
	can_dig = can_dig,
	on_metadata_inventory_put = on_metadata_inventory_put,
	on_metadata_inventory_take = on_metadata_inventory_take,
	allow_metadata_inventory_put = allow_metadata_inventory_put
})

minetest.register_craft({
	output = "protector:protect 4",
	recipe = {
		{"default:stone","default:stone","default:stone"},
		{"default:stone","default:steel_ingot","default:stone"},
		{"default:stone","default:stone","default:stone"},
	}
})

minetest.register_craft({
	output = "protector:protect2 4",
	recipe = {
		{"default:stone", "default:stone", "default:stone"},
		{"default:stone", "default:copper_ingot", "default:stone"},
		{"default:stone", "default:stone", "default:stone"},
	}
})

minetest.register_on_player_receive_fields(function(player, formname, fields)

	if string.sub(formname, 0, string.len("protector:node_")) == "protector:node_" then

		local pos_s = string.sub(formname, string.len("protector:node_") + 1)
		local pos = minetest.string_to_pos(pos_s)
		local meta = minetest.get_meta(pos)

		if not protector.can_dig(1, pos, player:get_player_name(), true, 1) then
			return
		end

		if fields.protector_add_member then
			for _, i in ipairs(fields.protector_add_member:split(" ")) do
				protector.add_member(meta,i)
			end
			minetest.show_formspec(player:get_player_name(), formname, protector.generate_formspec(pos))
		end

		for field, value in pairs(fields) do
			if string.sub(field, 0, string.len("protector_del_member_")) == "protector_del_member_" then
				meta:set_string("tenant", "")
				protector.del_member(meta, string.sub(field, string.len("protector_del_member_") + 1))
				local inv = meta:get_inventory()
				local stack = inv:get_stack("main", 1)
				if not stack:is_empty() then
					if minetest.deserialize(stack:get_metadata()).tenant == string.sub(field, string.len("protector_del_member_") + 1) then
						--print(dump(stack:get_metadata()))
						inv:remove_item("main", stack)
						minetest.add_item(pos, stack)
						meta:set_string("infotext", "Protection owned by "..player:get_player_name())
					end
				end
			end
		end
		if fields.quit then 	
			return
		else
			minetest.show_formspec(player:get_player_name(), formname, protector.generate_formspec(pos))
		end
	end

end)

minetest.register_entity("protector:display", {
	physical = false,
	collisionbox = {0, 0, 0, 0, 0, 0},
	visual = "wielditem",
	-- wielditem seems to be scaled to 1.5 times original node size
	visual_size = {x = 1.0 / 1.5, y = 1.0 / 1.5},
	textures = {"protector:display_node"},
	on_step = function(self, dtime)
		self.timer = (self.timer or 0) + dtime
		if self.timer > 10 then
			self.object:remove()
		end
	end,
})

-- Display-zone node, Do NOT place the display as a node,
-- it is made to be used as an entity (see above)
local x = protector.radius
minetest.register_node("protector:display_node", {
	tiles = {"protector_display.png"},
	use_texture_alpha = true,
	walkable = false,
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- sides
			{-(x+.55), -(x+.55), -(x+.55), -(x+.45), (x+.55), (x+.55)},
			{-(x+.55), -(x+.55), (x+.45), (x+.55), (x+.55), (x+.55)},
			{(x+.45), -(x+.55), -(x+.55), (x+.55), (x+.55), (x+.55)},
			{-(x+.55), -(x+.55), -(x+.55), (x+.55), (x+.55), -(x+.45)},
			-- top
			{-(x+.55), (x+.45), -(x+.55), (x+.55), (x+.55), (x+.55)},
			-- bottom
			{-(x+.55), -(x+.55), -(x+.55), (x+.55), -(x+.45), (x+.55)},
			-- middle (surround protector)
			{-.55,-.55,-.55, .55,.55,.55},
		},
	},
	selection_box = {
		type = "regular",
	},
	paramtype = "light",
	groups = {dig_immediate = 3, not_in_creative_inventory = 1},
	drop = "",
})

-- Register Protected Doors

--[[
local function on_rightclick(pos, dir, check_name, replace, replace_dir, params)
	pos.y = pos.y+dir
	if not minetest.get_node(pos).name == check_name then
		return
	end
	local p2 = minetest.get_node(pos).param2
	p2 = params[p2+1]
		
	minetest.swap_node(pos, {name=replace_dir, param2=p2})
		
	pos.y = pos.y-dir
	minetest.swap_node(pos, {name=replace, param2=p2})

	local snd_1 = "doors_door_close"
	local snd_2 = "doors_door_open" 
	if params[1] == 3 then
		snd_1 = "doors_door_open"
		snd_2 = "doors_door_close"
	end

	if minetest.get_meta(pos):get_int("right") ~= 0 then
		minetest.sound_play(snd_1, {pos = pos, gain = 0.3, max_hear_distance = 10})
	else
		minetest.sound_play(snd_2, {pos = pos, gain = 0.3, max_hear_distance = 10})
	end
end
--]]

-- Protected Wooden Door

local name = "door_wood"

doors.register("protector:" .. name, {
	description = "Protected Wooden Door",
	inventory_image = "doors_item_wood.png^protector_logo.png",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, door = 1},
	tiles = {{name = "protector_door_wood.png", backface_culling = true}},
	sounds = default.node_sound_wood_defaults(),
	sunlight = false,
})

---[[
minetest.override_item("protector:" .. name .. "_a", {
	on_rightclick = function(pos, node, clicker, itemstack)
		local on_rightclick = minetest.registered_nodes["doors:door_wood_a"].on_rightclick
		if minetest.is_protected(pos, clicker:get_player_name()) then
			return
		end
		return on_rightclick(pos, node, clicker, itemstack)
	end,
})

minetest.override_item("protector:" .. name .. "_b", {
	on_rightclick = function(pos, node, clicker, itemstack)
		local on_rightclick = minetest.registered_nodes["doors:door_wood_b"].on_rightclick
		if minetest.is_protected(pos, clicker:get_player_name()) then
			return
		end
		return on_rightclick(pos, node, clicker, itemstack)
	end,
})
--]]

--[[
minetest.override_item(name.."_b_2", {
	on_rightclick = function(pos, node, clicker)
		if not minetest.is_protected(pos, clicker:get_player_name()) then
			on_rightclick(pos, 1, name.."_t_2", name.."_b_1", name.."_t_1", {3,0,1,2})
		end
	end,
})

minetest.override_item(name.."_t_2", {
	on_rightclick = function(pos, node, clicker)
		if not minetest.is_protected(pos, clicker:get_player_name()) then
			on_rightclick(pos, -1, name.."_b_2", name.."_t_1", name.."_b_1", {3,0,1,2})
		end
	end,
})
--]]

minetest.register_craft({
	output = name,
	recipe = {
		{"group:wood", "group:wood"},
		{"group:wood", "default:copper_ingot"},
		{"group:wood", "group:wood"}
	}
})

minetest.register_craft({
	output = name,
	recipe = {
		{"doors:door_wood", "default:copper_ingot"}
	}
})

-- Protected Steel Door

local name = "door_steel"

doors.register("protector:" .. name, {
	description = "Protected Steel Door",
	inventory_image = "doors_item_steel.png^protector_logo.png",
	groups = {cracky = 1, level = 2, door = 1},
	tiles = {{name = "protector_door_steel.png", backface_culling = true}},
	sounds = default.node_sound_wood_defaults(),
	sunlight = false,
})

---[[
minetest.override_item("protector:" .. name .. "_a", {
	on_rightclick = function(pos, node, clicker, itemstack)
		local on_rightclick = minetest.registered_nodes["doors:door_steel_a"].on_rightclick
		if minetest.is_protected(pos, clicker:get_player_name()) then
			return
		end
		return on_rightclick(pos, node, clicker, itemstack)
	end,
})

minetest.override_item("protector:" .. name .. "_b", {
	on_rightclick = function(pos, node, clicker, itemstack)
		local on_rightclick = minetest.registered_nodes["doors:door_steel_b"].on_rightclick
		if minetest.is_protected(pos, clicker:get_player_name()) then
			return
		end
		return on_rightclick(pos, node, clicker, itemstack)
	end,
})
--]]

--[[
minetest.override_item(name.."_b_2", {
	on_rightclick = function(pos, node, clicker)
		if not minetest.is_protected(pos, clicker:get_player_name()) then
			on_rightclick(pos, 1, name.."_t_2", name.."_b_1", name.."_t_1", {3,0,1,2})
		end
	end,
})

minetest.override_item(name.."_t_2", {
	on_rightclick = function(pos, node, clicker)
		if not minetest.is_protected(pos, clicker:get_player_name()) then
			on_rightclick(pos, -1, name.."_b_2", name.."_t_1", name.."_b_1", {3,0,1,2})
		end
	end,
})
--]]

minetest.register_craft({
	output = name,
	recipe = {
		{"default:steel_ingot", "default:steel_ingot"},
		{"default:steel_ingot", "default:copper_ingot"},
		{"default:steel_ingot", "default:steel_ingot"}
	}
})

minetest.register_craft({
	output = name,
	recipe = {
		{"doors:door_steel", "default:copper_ingot"}
	}
})

-- Protected Chest

minetest.register_node("protector:chest", {
	description = "Protected Chest",
	tiles = {"default_chest_top.png", "default_chest_top.png", "default_chest_side.png",
		"default_chest_side.png", "default_chest_side.png", "default_chest_front.png^protector_logo.png"},
	paramtype2 = "facedir",
	groups = {choppy=2,oddly_breakable_by_hand=2,unbreakable=1},
	legacy_facedir_simple = true,
	is_ground_content = false,
	sounds = default.node_sound_wood_defaults(),
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", "Protected Chest")
		meta:set_string("name", "")
		local inv = meta:get_inventory()
		inv:set_size("main", 8*4)
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		if inv:is_empty("main") then
			if not minetest.is_protected(pos, player:get_player_name()) then
				return true
			end
		end
	end,
	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		return count
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		return stack:get_count()
	end,
	allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		return stack:get_count()
	end,
	on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff to protected chest at "..minetest.pos_to_string(pos))
	end,
	on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" takes stuff from protected chest at "..minetest.pos_to_string(pos))
	end,
	on_rightclick = function(pos, node, clicker)
		local meta = minetest.get_meta(pos)
		if not minetest.is_protected(pos, clicker:get_player_name()) then

		local spos = pos.x .. "," .. pos.y .. "," ..pos.z
		local formspec = "size[8,9]"..
			default.gui_bg..default.gui_bg_img..default.gui_slots..
			"list[nodemeta:".. spos .. ";main;0,0.3;8,4;]"..
			"button[0,4.5;2,0.25;toup;To Chest]"..
			"field[2.3,4.8;4,0.25;chestname;;"..meta:get_string("name").."]"..
			"button[6,4.5;2,0.25;todn;To Inventory]"..
			"list[current_player;main;0,5;8,1;]"..
			"list[current_player;main;0,6.08;8,3;8]"..
			"listring[nodemeta:".. spos .. ";main]"..
			--"listring[current_name;main]"..
			--"listring[context;main]"..
			"listring[current_player;main]"..
			default.get_hotbar_bg(0,5)

			minetest.show_formspec(
				clicker:get_player_name(),
				"protector:chest_"..minetest.pos_to_string(pos),
				formspec
			)
		end
	end,
})

-- Protected Chest formspec buttons

minetest.register_on_player_receive_fields(function(player,formname,fields)

	if string.sub(formname,0,string.len("protector:chest_")) == "protector:chest_" then

		local pos_s = string.sub(formname,string.len("protector:chest_")+1)
		local pos = minetest.string_to_pos(pos_s)
		local meta = minetest.get_meta(pos)

		local chest_inv = meta:get_inventory()
		local player_inv = player:get_inventory()

		if fields.toup then

			-- copy contents of players inventory to chest
			for i,v in ipairs( player_inv:get_list( "main" ) or {}) do
				if( chest_inv and chest_inv:room_for_item('main', v)) then
					local leftover = chest_inv:add_item( 'main', v )
					player_inv:remove_item( "main", v )
					if( leftover and not( leftover:is_empty() )) then
						player_inv:add_item( "main", v )
					end
				end
			end
	
		elseif fields.todn then

			-- copy contents of chest to players inventory
			for i,v in ipairs( chest_inv:get_list( 'main' ) or {}) do
				if( player_inv:room_for_item( "main", v)) then
					local leftover = player_inv:add_item( "main", v )
					chest_inv:remove_item( 'main', v )
					if( leftover and not( leftover:is_empty() )) then
						chest_inv:add_item( 'main', v )
					end
				end
			end

		elseif fields.chestname then

			-- change chest infotext to display name
			if fields.chestname ~= "" then
				meta:set_string("name", fields.chestname)
				meta:set_string("infotext", "Protected Chest ("..fields.chestname..")")
			else
				meta:set_string("infotext", "Protected Chest")
			end

		end
	end

end)

-- Protected Chest recipe

minetest.register_craft({
	output = 'protector:chest',
	recipe = {
		{'group:wood', 'group:wood', 'group:wood'},
		{'group:wood', 'default:copper_ingot', 'group:wood'},
		{'group:wood', 'group:wood', 'group:wood'},
	}
})

minetest.register_craft({
	output = 'protector:chest',
	recipe = {
		{'default:chest', 'default:copper_ingot', ''},
	}
})

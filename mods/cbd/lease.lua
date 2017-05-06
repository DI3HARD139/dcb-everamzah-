-- This file contains the lease, lease_written, and lease_register items.

local formspec_lease_register =
	"size[8,9]"..default.gui_bg..default.gui_bg_img..default.gui_slots..
	"label[0,0;Register]"..
	"list[current_name;register;0,0.75;8,4;]"..
	"list[current_player;main;0,5.25;8,4;]"..
	"listring[]"

local formspec_lease_stock =
	"size[8,9]"..default.gui_bg..default.gui_bg_img..default.gui_slots..
	"label[0,0;Blank Leases]"..
	"list[current_name;stock;0,0.75;8,4;]"..
	"list[current_player;main;0,5.25;8,4;]"..
	"listring[]"

--local maxleases = 0

local function get_register_formspec(pos)
	local meta = minetest.get_meta(pos)
	local maxleases = meta:get_int("maxleases")
	local spos = pos.x..","..pos.y..","..pos.z
	local formspec =
		"size[8,6.5]"..default.gui_bg..default.gui_bg_img..default.gui_slots..
		"label[2,0;Lease]"..
		"label[4,0;Price]"..
		"label[0,0;Limit]"..
		"field[0.25,1;1,0.35;numtenant;;"..maxleases.."]"..
		"label[0,1.25;Per Player]"..
		"button[6.2,0;1.75,1;stock;Leases]"..
		"button[6.2,0.75;1.75,1;register;Register]".. -- 6.25, 1.5
		"button[6.2,1.5;1.75,1;purchase;Purchase]"..
		"list[nodemeta:"..spos..";sell;2,0.5;1,1;]"..
		"list[nodemeta:"..spos..";buy;4,0.5;1,1;]"..
		"list[current_player;main;0,2.75;8,4;]"
	return formspec
end

local function lease_on_use(itemstack, user, pointed_thing)
        local player_name = user:get_player_name()
        local data = minetest.deserialize(itemstack:get_metadata())
        local property, tenant, owner = "", "", player_name
        if data then
                property, tenant, owner = data.property, data.tenant, data.owner
        end
        local formspec
        if owner == player_name then
                formspec = "size[3.25,4]"..default.gui_bg..default.gui_bg_img..default.gui_slots..
                        "field[0.3,1;3.25,0;property;Property:;"..
                                minetest.formspec_escape(property).."]"..
                        "field[0.3,2.25;3.25,0;tenant;Tenant:;"..
                                minetest.formspec_escape(tenant).."]"..
                        "button_exit[1.75,3.5;1.5,1;save;Save]"
        else
                formspec = "size[8,8]"..default.gui_bg..
                        "label[0.5,0;"..owner.."]"..
                        "label[0.5,1;"..minetest.formspec_escape(property).."]"..
                        "label[0.5,2;"..minetest.formspec_escape(tenant).."]"
        end
        minetest.show_formspec(user:get_player_name(), "cbd:lease", formspec)
end

minetest.register_node("cbd:lease_register", {
	description = "Lease Register",
	tiles = {"xdecor_barrel_top.png^cbd_lease_written.png",
		"xdecor_barrel_top.png",
		"xdecor_barrel_top.png^cbd_lease_written.png",
		"xdecor_barrel_top.png^cbd_lease_written.png",
		"xdecor_barrel_top.png^cbd_lease_written.png",
		"xdecor_barrel_top.png^cbd_lease_written.png"},
	groups = {cracky=2, choppy=3, oddly_breakable_by_hand=1},
	paramtype2 = "facedir",
	after_place_node = function(pos, placer, itemstack, pointed_thing)
		local meta = minetest.get_meta(pos)
		local owner = placer:get_player_name()

		meta:set_string("owner", owner)
		meta:set_string("infotext", "Lease Shop\nOwned by "..owner)
		meta:set_int("maxleases", 1) -- Default maximum number of leases per player.
		meta:set_string("formspec", get_register_formspec(pos))

		local inv = meta:get_inventory()
		inv:set_size("buy", 1)
		inv:set_size("sell", 1)
		inv:set_size("stock", 8*4)
		inv:set_size("register", 8*4)
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		local meta = minetest.get_meta(pos)
		local owner = meta:get_string("owner")
		local player = sender:get_player_name()
		local inv = meta:get_inventory()
		local s = inv:get_list("sell")
		local b = inv:get_list("buy")
		local stk = inv:get_list("stock")
		--local reg = inv:get_list("register")
		local pinv = sender:get_inventory()
		if fields.numtenant and player == owner then
			--print(fields.numtenant)
			meta:set_int("maxleases", math.abs(tonumber(fields.numtenant) or 0))
			meta:set_string("formspec", get_register_formspec(pos))
		end
		if fields.register then
			--print("reg")
			if player ~= owner and (not minetest.check_player_privs(player, {server=true})) then
				minetest.chat_send_player(player, "Only the property owner can open the register.")
				return
			else
				minetest.show_formspec(player, "cbd:lease_register", formspec_lease_register)
				return
			end
		end
		if fields.stock then
			--print("stock")
			minetest.show_formspec(player, "cbd:lease_register", formspec_lease_stock)
			return
		end
		if fields.purchase and s[1] then
			local numpurchases = meta:get_int("player_"..player) or 0
			local maxleases = meta:get_int("maxleases")
			if maxleases > 0 and numpurchases < maxleases then
				if pinv:contains_item("main", b[1]) and
				    (not inv:is_empty("sell")) and
				    inv:contains_item("stock", "cbd:lease") and
				    inv:room_for_item("register", b[1]) then
					pinv:remove_item("main", b[1])
					inv:add_item("register", b[1])
					meta:set_int("player_"..player, numpurchases + 1)
					local old_stack = inv:get_stack("sell", 1)
					local lease = minetest.deserialize(old_stack:get_metadata())
					lease.tenant = player
					lease = minetest.serialize(lease)
					local new_stack = ItemStack("cbd:lease_written")
					new_stack:set_metadata(lease)
					inv:remove_item("stock", "cbd:lease")
					pinv:add_item("main", new_stack)
				else
					minetest.chat_send_player(player, "Lease shop closed for maintenance.")
				end
			else
				minetest.chat_send_player(player, "Maximum allotment filled.")
			end
			return
		end
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		local owner = meta:get_string("owner")
		local inv = meta:get_inventory()
		local s = inv:get_list("sell")
		local n = stack:get_name()
		local playername = player:get_player_name()
		if playername ~= owner and (not minetest.check_player_privs(playername, {server=true})) then
			return 0
		elseif listname ~= "stock" and listname ~= "sell" then
			return 99
		elseif listname == "stock" and stack:get_name() == "cbd:lease" then
			return 99
		elseif listname == "sell" and stack:get_name() == "cbd:lease_written" then
			return 1
		else
			return 0
		end
	end,
	allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		local owner = meta:get_string("owner")
		local playername = player:get_player_name()
		if playername ~= owner and (not minetest.check_player_privs(playername, {server=true}))then
			return 0
		else
			return 99
		end
	end,
	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		local meta = minetest.get_meta(pos)
		local owner = meta:get_string("owner")
		local playername = player:get_player_name()
		if playername ~= owner and (not minetest.check_player_privs(playername, {server=true}))then
			return 0
		else
			return 99
		end
	end,
	can_dig = function(pos, player) 
                local meta = minetest.get_meta(pos) 
                local owner = meta:get_string("owner") 
                local inv = meta:get_inventory() 
                return player:get_player_name() == owner and inv:is_empty("register") and inv:is_empty("stock") and inv:is_empty("buy") and inv:is_empty("sell")
	end,

})

minetest.register_on_player_receive_fields(function(player, form_name, fields)
        if form_name ~= "cbd:lease" or not fields.save or
                        fields.property == "" then
                return
        end
        local inv = player:get_inventory()
        local stack = player:get_wielded_item()
        local new_stack, data
        if stack:get_name() ~= "cbd:lease_written" then
                local count = stack:get_count()
                if count == 1 then
                        stack:set_name("cbd:lease_written")
                else
                        stack:set_count(count - 1)
                        new_stack = ItemStack("cbd:lease_written")
                end
        else
                data = minetest.deserialize(stack:get_metadata())
        end
        if not data then data = {} end
        data.property = fields.property
        data.tenant = fields.tenant
        data.owner = player:get_player_name()
        local data_str = minetest.serialize(data)
        if new_stack then
                new_stack:set_metadata(data_str)
                if inv:room_for_item("main", new_stack) then
                        inv:add_item("main", new_stack)
                else
                        minetest.add_item(player:getpos(), new_stack)
                end
        else
                stack:set_metadata(data_str)
        end
        player:set_wielded_item(stack)
end)

minetest.register_craftitem("cbd:lease", {
        description = "Lease",
        inventory_image = "cbd_lease.png",
        groups = {lease=1},
        on_use = lease_on_use,
})

minetest.register_craftitem("cbd:lease_written", {
        description = "Signed Lease",
        inventory_image = "cbd_lease_written.png",
        groups = {lease=1, not_in_creative_inventory=1},
        stack_max = 1,
        on_use = lease_on_use,
})

minetest.register_craft({
	output = "cbd:lease_register",
	recipe = {
		{"group:wood", "dye:black", "group:wood"},
		{"cbd:lease", "default:goldblock", "cbd:lease"},
		{"group:wood", "dye:black", "group:wood"}
	}
})

minetest.register_craft({
	type = "shapeless",
	output = "cbd:lease",
	recipe = {"default:paper", "dye:black"}
})

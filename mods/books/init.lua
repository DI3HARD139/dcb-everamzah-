--[[ Placeable Books by everamzah
	Copyright (C) 2016 James Stevenson
	LGPLv2.1+
	See LICENSE for more information ]]



local lpp = 14 -- Lines per book's page

local function on_place(itemstack, placer, pointed_thing)
	if minetest.is_protected(pointed_thing.above, placer:get_player_name()) then
		-- TODO: record_protection_violation()
		return itemstack
	end

	local meta = itemstack:get_metadata()
	local data = minetest.deserialize(meta)
	local stack = ItemStack({name = "default:book_closed"})
	if data and data.owner then
		stack:set_metadata(meta)
	end

	local _, placed = minetest.item_place(stack, placer, pointed_thing)
	if placed then
		itemstack:take_item()
	end
	return itemstack
end

local function after_place_node(pos, placer, itemstack, pointed_thing)
	local data = minetest.deserialize(itemstack:get_metadata())
	if data then
		local meta = minetest.get_meta(pos)
		meta:set_string("title", data.title)
		meta:set_string("text", data.text)
		meta:set_string("owner", data.owner)
		meta:set_string("text_len", data.text_len)
		meta:set_string("page", data.page)
		meta:set_string("page_max", data.page_max)
		meta:set_string("infotext", data.title .. "\n\n" ..
				"by " .. data.owner)
	end
end

local function formspec_display(meta, player_name, pos)
	-- Courtesy of minetest_game/mods/default/craftitems.lua
	local title, text, owner = "", "", player_name
	local page, page_max, lines, string = 1, 1, {}, ""

	if meta:to_table().fields.owner then
		title = meta:get_string("title")
		text = meta:get_string("text")
		owner = meta:get_string("owner")

		for str in (text .. "\n"):gmatch("([^\n]*)[\n]") do
			lines[#lines+1] = str
		end

		if meta:to_table().fields.page then
			page = meta:to_table().fields.page
			page_max = meta:to_table().fields.page_max

			for i = ((lpp * page) - lpp) + 1, lpp * page do
				if not lines[i] then break end
				string = string .. lines[i] .. "\n"
			end
		end
	end

	local formspec
	if owner == player_name then
		formspec = "size[8,8]" ..
			default.gui_bg ..
			default.gui_bg_img ..
			"field[0.5,1;7.5,0;title;Title:;" ..
				minetest.formspec_escape(title) .. "]" ..
			"textarea[0.5,1.5;7.5,7;text;Contents:;" ..
				minetest.formspec_escape(text) .. "]" ..
			"button_exit[2.5,7.5;3,1;save;Save]"
	else
		formspec = "size[8,8]" ..
			default.gui_bg ..
			default.gui_bg_img ..
			"label[0.5,0.5;by " .. owner .. "]" ..
			"tablecolumns[color;text]" ..
			"tableoptions[background=#00000000;highlight=#00000000;border=false]" ..
			"table[0.4,0;7,0.5;title;#FFFF00," .. minetest.formspec_escape(title) .. "]" ..
			"textarea[0.5,1.5;7.5,7;;" ..
				minetest.formspec_escape(string ~= "" and string or text) .. ";]" ..
			"button[2.4,7.6;0.8,0.8;book_prev;<]" ..
			"label[3.2,7.7;Page " .. page .. " of " .. page_max .. "]" ..
			"button[4.9,7.6;0.8,0.8;book_next;>]"
	end

	minetest.show_formspec(player_name,
			"default:book_" .. minetest.pos_to_string(pos), formspec)
end

local function on_rightclick(pos, node, clicker, itemstack, pointed_thing)
	if node.name == "default:book_closed" then
		node.name = "default:book_open"
		minetest.swap_node(pos, node)
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext",
				meta:get_string("text"))
	elseif node.name == "default:book_open" then
		local player_name = clicker:get_player_name()
		local meta = minetest.get_meta(pos)
		formspec_display(meta, player_name, pos)
	end
end

local function on_punch(pos, node, puncher, pointed_thing)
	if node.name == "default:book_open" then
		node.name = "default:book_closed"
		minetest.swap_node(pos, node)
		local meta = minetest.get_meta(pos)
		if meta:get_string("owner") ~= "" then
			meta:set_string("infotext",
					meta:get_string("title") .. "\n\n" ..
					"by " .. meta:get_string("owner"))
		end
	end
end

local function on_dig(pos, node, digger)
	if minetest.is_protected(pos, digger:get_player_name()) then
		-- TODO: record_protection_violation()
		return false
	end

	local meta = minetest.get_meta(pos)
	local data = {
		title = meta:get_string("title"),
		text = meta:get_string("text"),
		owner = meta:get_string("owner"),
		text_len = meta:get_int("text_len"),
		page = meta:get_int("page"),
		page_max = meta:get_int("page_max"),
	}

	local stack
	if data.owner ~= "" then
		stack = ItemStack({name = "default:book_written"})
		stack:set_metadata(minetest.serialize(data))
	else
		stack = ItemStack({name = "default:book"})
	end

	local adder = digger:get_inventory():add_item("main", stack)
	if adder then
		minetest.item_drop(adder, digger, digger:getpos())
	end
	minetest.remove_node(pos)
end



minetest.override_item("default:book", {on_place = on_place})

minetest.override_item("default:book_written", {on_place = on_place})

-- TODO: for book_open, book_written_open
minetest.register_node(":default:book_open", {
	description = "Book Open (you hacker you!)",
	inventory_image = "default_book.png",
	tiles = {
		"books_book_open_top.png",	-- Top
		"books_book_open_bottom.png",	-- Bottom
		"books_book_open_side.png",	-- Right
		"books_book_open_side.png",	-- Left
		"books_book_open_front.png",	-- Back
		"books_book_open_front.png"	-- Front
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.375, -0.47, -0.282, 0.375, -0.4125, 0.282}, -- Top
			{-0.4375, -0.5, -0.3125, 0.4375, -0.47, 0.3125},
		}
	},
	--groups = {attached_node = 1}, -- FIXME
	on_punch = on_punch,
	on_rightclick = on_rightclick,
})

-- TODO: for book_closed, book_written_closed
minetest.register_node(":default:book_closed", {
	description = "Book Closed (you hacker you!)",
	inventory_image = "default_book.png",
	tiles = {
		"books_book_closed_topbottom.png",	-- Top
		"books_book_closed_topbottom.png",	-- Bottom
		"books_book_closed_right.png",	-- Right
		"books_book_closed_left.png",	-- Left
		"books_book_closed_front.png^[transformFX",	-- Back
		"books_book_closed_front.png"	-- Front
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.25, -0.5, -0.3125, 0.25, -0.35, 0.3125},
		}
	},
	groups = {oddly_breakable_by_hand = 3, dig_immediate = 2}, --, attached_node = 1}, -- FIXME
	on_dig = on_dig,
	on_rightclick = on_rightclick,
	after_place_node = after_place_node,
})

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname:sub(1, 13) ~= "default:book_" then
		return
	end

	if fields.save and fields.title ~= "" and fields.text ~= "" then
		local pos = minetest.string_to_pos(formname:sub(14))
		local node = minetest.get_node(pos)
		local meta = minetest.get_meta(pos)

		meta:set_string("title", fields.title)
		meta:set_string("text", fields.text)
		meta:set_string("owner", player:get_player_name())
		meta:set_string("infotext", fields.text)
		meta:set_int("text_len", fields.text:len())
		meta:set_int("page", 1)
		meta:set_int("page_max", math.ceil((fields.text:gsub("[^\n]", ""):len() + 1) / lpp))
	elseif fields.book_next or fields.book_prev then
		local pos = minetest.string_to_pos(formname:sub(14))
		local node = minetest.get_node(pos)
		local meta = minetest.get_meta(pos)

		if fields.book_next then
			meta:set_int("page", meta:get_int("page") + 1)
			if meta:get_int("page") > meta:get_int("page_max") then
				meta:set_int("page", 1)
			end
		elseif fields.book_prev then
			meta:set_int("page", meta:get_int("page") - 1)
			if meta:get_int("page") == 0 then
				meta:set_int("page", meta:get_int("page_max"))
			end
		end

		formspec_display(meta, player:get_player_name(), pos)
	end
end)

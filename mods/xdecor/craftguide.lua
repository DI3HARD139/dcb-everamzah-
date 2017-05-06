local craftguide = {}
screwdriver = screwdriver or {}

function craftguide.get_recipe(item)
	if item:find("^group:") then
		if item:find("wool$") or item:find("dye$") then
			item = item:sub(7)..":white"
		elseif minetest.registered_items["default:"..item:sub(7)] then
			item = item:gsub("group:", "default:")
		else
			for node, def in pairs(minetest.registered_items) do
				if def.groups[item:match("[^,:]+$")] then
					item = node
				end
			end
		end
	end
	return item
end

function craftguide.craftguide_formspec(meta, pagenum, item, recipe_num, filter, tab_id)
	local inv_size = meta:get_int("inv_size")
	local npp, i, s = 8*3, 0, 0
	local pagemax = math.floor((inv_size - 1) / npp + 1)

	if pagenum > pagemax then
		pagenum = 1
	elseif pagenum == 0 then
		pagenum = pagemax
	end

	local formspec = [[ size[8,6.6;]
			tablecolumns[color;text;color;text]
			tableoptions[background=#00000000;highlight=#00000000;border=false]
			button[5.5,0;0.7,1;prev;<]
			button[7.3,0;0.7,1;next;>]
			button[4,0.2;0.7,0.5;search;?]
			button[4.6,0.2;0.7,0.5;clearfilter;X]
			tooltip[search;Search]
			tooltip[clearfilter;Reset] ]]
			.."tabheader[0,0;tabs;All,Nodes,Tools,Items;"..tostring(tab_id)..";true;false]"..
			"table[6.1,0.2;1.1,0.5;pagenum;#FFFF00,"..tostring(pagenum)..
			",#FFFFFF,/ "..tostring(pagemax).."]"..
			"field[1.8,0.32;2.6,1;filter;;"..filter.."]"..xbg

	for _, name in pairs(craftguide.craftguide_main_list(meta, filter, tab_id)) do
		if s < (pagenum - 1) * npp then
			s = s + 1
		else
			if i >= npp then break end
			formspec = formspec.."item_image_button["..(i%8)..","..
					(math.floor(i/8)+1)..";1,1;"..name..";"..name..";]"
			i = i + 1
		end
	end

	if item and minetest.registered_items[item] then
		--print(dump(minetest.get_all_craft_recipes(item)))
		local items_num = #minetest.get_all_craft_recipes(item)
		if recipe_num > items_num then recipe_num = 1 end

		if items_num > 1 then
			formspec = formspec.."button[0,6;1.6,1;alternate;Alternate]"..
					"label[0,5.5;Recipe "..recipe_num.." of "..items_num.."]"
		end
		
		local type = minetest.get_all_craft_recipes(item)[recipe_num].type
		if type == "cooking" then
			formspec = formspec.."image[3.75,4.6;0.5,0.5;default_furnace_fire_fg.png]"
		end

		local items = minetest.get_all_craft_recipes(item)[recipe_num].items
		local width = minetest.get_all_craft_recipes(item)[recipe_num].width
		local yield = minetest.get_all_craft_recipes(item)[recipe_num].output:match("%s(%d+)") or ""
		if width == 0 then width = math.min(3, #items) end
		local rows = math.ceil(table.maxn(items) / width)

		local function is_group(item)
			if item:find("^group:") then return "G" end
			return ""
		end

		for i, v in pairs(items) do
			formspec = formspec.."item_image_button["..((i-1) % width + 4.5)..","..
				(math.floor((i-1) / width + (6 - math.min(2, rows))))..";1,1;"..
				craftguide.get_recipe(v)..";"..craftguide.get_recipe(v)..";"..is_group(v).."]"
		end

		formspec = formspec.."item_image_button[2.5,5;1,1;"..item..";"..item..";"..yield.."]"..
				"image[3.5,5;1,1;gui_furnace_arrow_bg.png^[transformR90]"
	end

	meta:set_string("formspec", formspec)
end

local function tab_category(tab_id)
	local id_category = {
		minetest.registered_items,
		minetest.registered_nodes,
		minetest.registered_tools,
		minetest.registered_craftitems
	}

	return id_category[tab_id] or id_category[1]
end

function craftguide.craftguide_main_list(meta, filter, tab_id)
	local items_list = {}
	for name, def in pairs(tab_category(tab_id)) do
		if not (def.groups.not_in_creative_inventory == 1) and
				minetest.get_craft_recipe(name).items and
				def.description and def.description ~= "" and
				(not filter or def.name:find(filter, 1, true)) then
			items_list[#items_list+1] = name
		end
	end

	meta:set_int("inv_size", #items_list)
	table.sort(items_list)
	return items_list
end

function craftguide.construct(pos)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()

	inv:set_size("forms", 4*3)
	meta:set_string("infotext", "Craft Guide")

	craftguide.craftguide_main_list(meta, nil, 1)
	craftguide.craftguide_formspec(meta, 1, nil, 1, "", 1)

end

function craftguide.fields(pos, _, fields)
	if fields.quit then return end
	local meta = minetest.get_meta(pos)
	local formspec = meta:to_table().fields.formspec
	local filter = formspec:match("filter;;([%w_:]+)") or ""
	local pagenum = tonumber(formspec:match("#FFFF00,(%d+)")) or 1
	local tab_id = tonumber(formspec:match("tabheader%[.*;(%d+)%;.*%]")) or 1

	if fields.clearfilter then
		craftguide.craftguide_main_list(meta, nil, tab_id)
		craftguide.craftguide_formspec(meta, 1, nil, 1, "", tab_id)
	elseif fields.alternate then
		local item = formspec:match("item_image_button%[.*;([%w_:]+);.*%]") or ""
		local recipe_num = tonumber(formspec:match("Recipe%s(%d+)")) or 1
		recipe_num = recipe_num + 1
		craftguide.craftguide_formspec(meta, pagenum, item, recipe_num, filter, tab_id)
	elseif fields.search then
		craftguide.craftguide_main_list(meta, fields.filter:lower(), tab_id)
		craftguide.craftguide_formspec(meta, 1, nil, 1, fields.filter:lower(), tab_id)
	elseif fields.tabs then
		craftguide.craftguide_main_list(meta, filter, tonumber(fields.tabs))
		craftguide.craftguide_formspec(meta, 1, nil, 1, filter, tonumber(fields.tabs))
	elseif fields.prev or fields.next then
		if fields.prev then
			pagenum = pagenum - 1
		else
			pagenum = pagenum + 1
		end
		craftguide.craftguide_formspec(meta, pagenum, nil, 1, filter, tab_id)
	else
		for item in pairs(fields) do
			if item:match(".-:") and minetest.get_craft_recipe(item).items then
				craftguide.craftguide_formspec(meta, pagenum, item, 1, filter, tab_id)
			end
		end
	end
end

function craftguide.take(_, listname, _, stack, player)
	if listname == "forms" then
		local inv = player:get_inventory()
		if inv:room_for_item("main", stack:get_name()) then
			return -1
		end
		return 0
	end
	return stack:get_count()
end

function craftguide.move(pos, _, _, to_list, _, count)
	if to_list == "storage" then
		return count
	elseif to_list == "trash" then
		trash_delete(pos)
		return count
	end
	return 0
end

function craftguide.get_output(inv, input, name)
	if inv:is_empty("input") then
		inv:set_list("forms", {})
		return
	end

	local output = {}
	for _, n in pairs(craftguide.defs) do
		local count = math.min(n[2] * input:get_count(), input:get_stack_max())
		local item = name.."_"..n[1]
		if not n[3] then item = "stairs:"..n[1].."_"..name:match(":(.*)") end

		output[#output+1] = item.." "..count
	end

	inv:set_list("forms", output)
end

function craftguide.on_put(pos, listname, _, stack)
	if listname == "input" then
		local inv = minetest.get_meta(pos):get_inventory()
		local input = inv:get_stack("input", 1)
		craftguide.get_output(inv, input, stack:get_name())
	end
end

function craftguide.on_take(pos, listname, index, stack)
	local inv = minetest.get_meta(pos):get_inventory()
	local input = inv:get_stack("input", 1)

	if listname == "input" then
		if stack:get_name() == input:get_name() then
			craftguide.get_output(inv, input, stack:get_name())
		else
			inv:set_list("forms", {})
		end
	elseif listname == "forms" then
		input:take_item(math.ceil(stack:get_count() / craftguide.defs[index][2]))
		inv:set_stack("input", 1, input)
		craftguide.get_output(inv, input, input:get_name())
	end
end

minetest.register_alias("craft_guide:sign_wall", "xdecor:craftguide")
minetest.register_alias("craft_guide:lcd_pc", "xdecor:craftguide_pc")

xdecor.register("craftguide", {
	description = "Craft Guide (Sign)",
	drawtype = "nodebox",
	groups = {cracky=1, choppy=1, oddly_breakable_by_hand=1, attached_node=1},
	sounds = default.node_sound_wood_defaults(),
	tiles = {"xdecor_craftguide_sign.png"},
	inventory_image = "xdecor_craftguide_sign_wall.png",
	wield_image = "xdecor_craftguide_sign_wall.png",
	walkable = false,
	sunlight_propagates = true,
	paramtype = "light",
	paramtype2 = "wallmounted",
        node_box = {
                type = "wallmounted",
                wall_top = {-0.4375, 0.4375, -0.3125, 0.4375, 0.5, 0.3125},
                wall_bottom = {-0.4375, -0.5, -0.3125, 0.4375, -0.4375, 0.3125},
                wall_side = {-0.5, -0.3125, -0.4375, -0.4375, 0.3125, 0.4375},
        },
	on_rotate = screwdriver.rotate_simple,
	on_construct = craftguide.construct,
	on_receive_fields = craftguide.fields,
	on_metadata_inventory_put = craftguide.on_put,
	on_metadata_inventory_take = craftguide.on_take,
	allow_metadata_inventory_put = craftguide.put,
	allow_metadata_inventory_take = craftguide.take,
	allow_metadata_inventory_move = craftguide.move
})

xdecor.register("craftguide_pc", {
	description = "Craft Guide (PC)",
	drawtype = "nodebox",
	tiles = {
                "xdecor_craftguide_pc_grey.png",
                "xdecor_craftguide_pc_grey.png",
                "xdecor_craftguide_pc_grey.png",
                "xdecor_craftguide_pc_grey.png",
                "xdecor_craftguide_pc_black.png",
                "[combine:16x16:0,0=xdecor_craftguide_pc_grey.png:0,0=xdecor_craftguide_pc_screen.png",
	},
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	walkable = false,
	groups = {cracky=2, choppy=2, oddly_breakable_by_hand=1},
	selection_box = {type="regular"},
	node_box = {
		type = "fixed",
		fixed = {
		    {-1.0000000e-1,-0.45259861,2.5136044e-2, 0.10000000,-2.5986075e-3,-2.4863956e-2},
		    {-0.40006064,-0.25615262,-0.13023723, -0.37006064,0.26767738,-0.16023723},      
		    {0.37054221,-0.25615274,-0.13023723, 0.40054221,0.26767750,-0.16023723},
		    {-0.40000000,-0.30600000,-0.13023723, 0.40000000,-0.25600000,-0.16023723},
		    {-0.40000000,0.26433021,-0.12945597, 0.40000000,0.29433021,-0.15945597},        
		    {-0.35000000,-0.25514168,-2.9045502e-2, 0.35000000,0.24485832,-7.9045502e-2},
		    {-0.40000000,-0.30617002,-8.0237234e-2, 0.40000000,0.29382998,-0.13023723},
		    {-0.25000000,-0.50000000,0.25000000, 0.25000000,-0.45000000,-0.25000000}
		},
	},
	on_rotate = screwdriver.rotate_simple,
	on_construct = craftguide.construct,
	on_receive_fields = craftguide.fields,
	on_metadata_inventory_put = craftguide.on_put,
	on_metadata_inventory_take = craftguide.on_take,
	allow_metadata_inventory_put = craftguide.put,
	allow_metadata_inventory_take = craftguide.take,
	allow_metadata_inventory_move = craftguide.move
})

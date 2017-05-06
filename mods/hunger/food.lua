local register_food = hunger.register_food

register_food("default:apple", 2)

if minetest.get_modpath("farming") ~= nil then
	register_food("farming:bread", 4)
end

if minetest.get_modpath("foodblock") ~= nil then
	register_food("foodblock:pudding_item", 5)
	register_food("foodblock:applepie_item", 4)
	register_food("foodblock:pancake_item", 5)
	register_food("foodblock:hambuger_item", 8)
end

if minetest.get_modpath("mobs") ~= nil then
	if mobs.mod ~= nil and mobs.mod == "redo" then
		register_food("mobs:cheese", 4)
		register_food("mobs:meat", 8)
		register_food("mobs:meat_raw", 4)
		register_food("mobs:rat_cooked", 4)
		register_food("mobs:pork_raw", 3, "", 3)
		register_food("mobs:pork_cooked", 8)
		register_food("mobs:chicken_cooked", 6)
		register_food("mobs:chicken_raw", 2, "", 3)
		register_food("mobs:chicken_egg_fried", 2)
		if minetest.get_modpath("bucket") then 
			register_food("mobs:bucket_milk", 3, "bucket:bucket_empty")
		end
		register_food("mobs:rotten_flesh", 0, "bones:bone", 5)
	else
		register_food("mobs:meat", 6)
		register_food("mobs:meat_raw", 3)
		register_food("mobs:rat_cooked", 5)
	end
end

if minetest.get_modpath("xdecor") ~= nil then
	register_food("xdecor:honey", 2)
end

if minetest.get_modpath("oresplus") ~= nil then
	register_food("oresplus:golden_apple", 20)
end

if minetest.get_modpath("crops") ~= nil then
	register_food("crops:melon_slice", 3)
	register_food("crops:roasted_pumpkin", 3)
	register_food("crops:potato", 6)
	register_food("crops:carrot", 4)
	register_food("crops:tomato", 5)
	register_food("crops:green_bean", 2)
	register_food("crops:corn_on_the_cob", 5)
	register_food("crops:vegetable_stew", 10, "crops:clay_bowl")
	register_food("crops:uncooked_vegetable_stew", 5, "crops:clay_bowl")
end

local MOD_NAME = minetest.get_current_modname();
local MOD_PATH = minetest.get_modpath(MOD_NAME);
local WORLD_PATH = minetest.get_worldpath();

if MOD_NAME ~= "wardrobe" then
   error("mod directory must be named 'wardrobe'");
end
wardrobe = {};

local initSkin, changeSkin, updateSkin = dofile(MOD_PATH.."/skinMethods.lua");
dofile(MOD_PATH.."/storage.lua");
dofile(MOD_PATH.."/wardrobe.lua");


-- API

--- Updates the visual appearance of a player's skin according to whatever skin
 -- has been set for the player.
 --
 -- @param player
 --    The Player object for the player.
 --
wardrobe.updatePlayerSkin = updateSkin;

--- Compatibility method.
 --
 -- Identical to wardrobe.updatePlayerSkin(player).
 --
wardrobe.setPlayerSkin = updateSkin;

--- Changes the skin set for a named player.
 --
 -- Player need not be logged in.  Automatically updates the player's visual
 -- appearance accordingly if they ARE logged in.
 --
 -- @param playerName
 --    Name of the player.
 -- @param skin
 --    Name of the skin.
 --
function wardrobe.changePlayerSkin(playerName, skin)
   changeSkin(playerName, skin);

   local player = minetest.get_player_by_name(playerName);
   if player then updateSkin(player); end;
end


wardrobe.storage.loadSkins();
wardrobe.storage.loadPlayerSkins();

minetest.register_on_newplayer(function(player)
	minetest.after(0.1, function()
		local birthdaysuit = {"character0.png", "character1.png", "alien0.png", "alien1.png"}
		wardrobe.changePlayerSkin(player:get_player_name(), birthdaysuit[math.random(1,4)])
	end)
end)

if initSkin then
   minetest.register_on_joinplayer(
      function(player)
         minetest.after(1, initSkin, player)
      end);
end;

if not changeSkin then
   error("No wardrobe skin change method registered.  Check skinMethods.lua.");
end;
if not updateSkin then
   error("No wardrobe skin update method registered.  Check skinMethods.lua.");
end;
--[[
minetest.register_chatcommand("skin", {
	description = "Set public or unique skin. Shows list when run without params.",
	privs = {},
	params = "[<skin>|<unique>]",
	func = function(player, skin)
		if skin == "unique" then
			for _,v in pairs(wardrobe.skins) do
				if v == "player_"..player..".png" then
					wardrobe.changePlayerSkin(player, "player_"..player..".png")
					break
				end
			end
		elseif skin ~= "" then
			for _,v in pairs(wardrobe.skins) do
				if not string.match(v, "player_") and v == skin then
					wardrobe.changePlayerSkin(player, skin)
					break
				end
			end
		elseif skin == "" then
			for i=1, #wardrobe.skins do
				if not string.match(wardrobe.skins[i], "player_") then
					minetest.chat_send_player(player, wardrobe.skins[i])
				end
			end
		end
	end,
})
--]]

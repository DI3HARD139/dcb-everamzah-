
minetest.register_on_prejoinplayer(function(name)
  if math.random(8) ~= 1 then	-- in 11 of 12 loginattempts, username gets checked for 3 digits at end. if true, and has no interact (new player) then boot him before he can join
    if string.match(name,".*%a%d%d%d$") then
      local privs = minetest.get_player_privs(name)
        if not privs.interact then
          --minetest.chat_send_all(name.." has been blocked.")
        return("This server is flooded with\n generic name users, please choose\n a username with another amount of digits to\n play normally. thank you :)")
      end
    end
  end
end)

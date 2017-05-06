-- Displays a message in chat upon connection to server.
minetest.register_on_prejoinplayer(function(name, ip)
    minetest.chat_send_all("*** "..name.." is connecting")
end)

-- Displays a message in chat upon player join.--
--minetest.register_on_joinplayer(function(player)
--      minetest.chat_send_all("[Server] Welcome "..player:get_player_name().."!")
--end)

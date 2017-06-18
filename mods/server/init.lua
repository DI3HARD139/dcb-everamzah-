local path = minetest.get_modpath("server")

print ("[Server Maintenance]")

dofile(path .. "/nightlyreboot.lua") --DI3HARD139
--dofile(path .. "/namerestrictions.lua") -- ShadowNinja
dofile(path .. "/namesperip.lua") -- Krock
dofile(path .. "/mapfix.lua") -- Gael-de-Sailly
dofile(path .. "/clearobjects.lua") -- DI3HARD139/red-001
dofile(path .. "/chat.lua") -- DI3HARD139
dofile(path .. "/sneak.lua") -- PilzAdam

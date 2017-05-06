local path = minetest.get_modpath("mobs")

dofile(path .. "/api.lua")
dofile(path .. "/crafts.lua")
--dofile(path .. "/spawner.lua")
dofile(path .. "/traps.lua")

-- Animals
dofile(path .. "/chicken.lua") -- JKmurray
dofile(path .. "/cow.lua") -- KrupnoPavel
dofile(path .. "/rat.lua") -- PilzAdam
dofile(path .. "/sheep.lua") -- PilzAdam
dofile(path .. "/warthog.lua") -- KrupnoPavel
dofile(path .. "/bee.lua") -- KrupnoPavel
dofile(path .. "/bunny.lua") -- ExeterDad
dofile(path .. "/kitten.lua") -- Jordach/BFD

-- Monsters
dofile(path .. "/dungeonmaster.lua")
dofile(path .. "/goblins.lua") -- FeelsLikeGNU
dofile(path .. "/zombie.lua") -- BlockMen
dofile(path .. "/slimes.lua") -- TomasJLuis

-- NPCs
dofile(path .. "/npc.lua") -- TenPlus1

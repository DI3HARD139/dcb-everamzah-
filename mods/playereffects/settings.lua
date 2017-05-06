--[[
	Settings for Player Effects
]]

-- Wheather to use the HUD to expose the active effects to players (true or false)
playereffects.use_hud = true

-- Wheather to use autosave (true or false)
playereffects.use_autosave = minetest.is_yes(minetest.setting_get("playereffects_autosave")) --true

-- The time interval between autosaves, in seconds (only used when use_autosave is true)
playereffects.autosave_time = tonumber(minetest.setting_get("playereffects_autosave")) or 20

-- If true, this loads some examples from example.lua.
playereffects.use_examples = false

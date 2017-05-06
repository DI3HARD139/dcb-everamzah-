	local function func()
	    minetest.chat_send_all("")
	    params = "quick"
	    local options = {}
	    options.mode = "quick"
	    core.clear_objects(options)
	    core.after(3600, func)
	end

	core.after(3600, func)

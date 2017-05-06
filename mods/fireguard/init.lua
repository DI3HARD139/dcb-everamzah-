check_protection = function(pos, name, text)
	if minetest.is_protected(pos, name) then
		minetest.log("action", (name ~= "" and name or "A mod")
			.. " tried to " .. text
			.. " at protected position "
			.. minetest.pos_to_string(pos)
			.. " with a bucket")
		minetest.record_protection_violation(pos, name)
		return true
	end
	return false
end

-- [fire_restricted]
minetest.register_privilege("fgfire", "Player can place fire")

--[[
minetest.override_item("fire:basic_flame", {
        on_construct = nil,
        on_place = function(itemstack, placer, pointed_thing)
                -- The standard fire behaviour is not altered
                -- Only privilefed players can place fire
                local name = placer:get_player_name()
                local pos = minetest.get_pointed_thing_position(pointed_thing, true)

                if minetest.check_player_privs(name, {fgfire=true}) then
                        minetest.set_node(pos, {name="fire:basic_flame"})
                        fire.update_sounds_around(pos)
                else
                        minetest.remove_node(pos)
                        minetest.log("info", name ..
					" tried to place fire at " ..
					minetest.pos_to_string(pos))
                        --minetest.chat_send_player(name, "You lack required priv: fgfire")
			cmsg.push_message_player(placer, "You need the fgfire priv to place fire")
                end
        end,
        -- Normal players can now only get fire:basic_flame via a giveme
        groups = {igniter=2, dig_immediate=3, not_in_creative_inventory=1},
})
--]]

-- [lava_restricted]
minetest.register_privilege("fglava", "Player can use lava bucket")

-- Normal players can now only get lava_source via a giveme
minetest.override_item("default:lava_source", {
        groups = {lava=3, liquid=2, hot=3, igniter=1, not_in_creative_inventory=1},
})


local lava_requires_priv = minetest.is_yes(minetest.setting_get("lava_requires_priv"))

minetest.override_item("bucket:bucket_lava",{
        on_place = function(itemstack, placer, pointed_thing)
                local name = placer:get_player_name()
                local pos = minetest.get_pointed_thing_position(pointed_thing, true)
                local source = "default:lava_source"
                local flowing = "default:lava_flowing"
                
                if lava_requires_priv and not minetest.check_player_privs(name, {fglava=true}) then
                        minetest.remove_node(pos)
                        minetest.log("info", name .. " tried to place lava at " .. minetest.pos_to_string(pos))
                        --minetest.chat_send_player(name, "You lack the required priv: fglava")
			cmsg.push_message_player(placer, "You need the fglava priv to place lava")
                        return {name="bucket:bucket_lava"}
		end

		-- Must be pointing to node
		if pointed_thing.type ~= "node" then
			return
		end
		
		local node = minetest.get_node_or_nil(pointed_thing.under)
		local ndef
		if node then
			ndef = minetest.registered_nodes[node.name]
		end
		-- Call on_rightclick if the pointed node defines it
		if ndef and ndef.on_rightclick
				and placer and not placer:get_player_control().sneak then
			return ndef.on_rightclick(
					pointed_thing.under, node, placer, itemstack)
					or itemstack
		end

		local giving_back = "bucket:bucket_empty"
		local place_liquid = function(pos, node, source, flowing)
			if check_protection(pos, placer
					and placer:get_player_name()
					or "", "place " .. source) then
				giving_back = "bucket:bucket_lava"
				return
			end
			minetest.add_node(pos, {name=source})
		end

		-- Check if pointing to a buildable node
		if ndef and ndef.buildable_to then
			-- Buildable; replace the node
			place_liquid(pointed_thing.under, node,	source, flowing)
		else
			-- Not buildable to; place the liquid above
			-- Check if the node above can be replaced
			local node = minetest.get_node_or_nil(pointed_thing.above)
			if node and minetest.registered_nodes[node.name].buildable_to then
				place_liquid(pointed_thing.above, node, source,	flowing)
			else
				-- Do not remove the bucket with the liquid
				return
			end
		end
		return {name=giving_back}
        end,
})

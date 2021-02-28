dragon_tracker_category = menu:add_category("dragon tracker")
dragon_tracker_enabled = menu:add_checkbox("enabled", dragon_tracker_category, 1)
is_dragon_attacked = false
last_baron_attacked_time = 0

local function on_draw()
	if menu:get_value(dragon_tracker_enabled) == 1 then
		if is_dragon_attacked then
			screen_size = game:get_screen_size()

			renderer:draw_text_centered(screen_size:width() / 2, 150, "Dragon is being attacked!")
		end

		if last_baron_attacked_time ~= 0 and game:get_gametime() < last_baron_attacked_time + 3.5 then
			screen_size = game:get_screen_size()
			
			renderer:draw_text_centered(screen_size:width() / 2, 170, "Baron is being attacked!")
		end
	end
end

local function on_object_created(object_id, obj_name)
	if obj_name == "SRU_Dragon_Spawn_Praxis.troy" then
		is_dragon_attacked = true
	end
	
	if obj_name == "SRU_Dragon_idle1_landing_sound.troy" then
		is_dragon_attacked = false
	end

	if obj_name == "SRU_Dragon_Elder_death_sound.troy" then
		is_dragon_attacked = false
	end

	if string.find(obj_name, "Dragon_death_sound") then
		is_dragon_attacked = false
	end

	if string.find(obj_name, "Dragon_Death") then
		is_dragon_attacked = false
	end

	if obj_name == "SRU_Baron_Base_BA1_tar.troy" then
		last_baron_attacked_time = game:get_gametime()
	end
end

client:set_event_callback("on_object_created", on_object_created)
client:set_event_callback("on_draw", on_draw)
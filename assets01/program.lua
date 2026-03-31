function engine.on_keyboard(buffer)
	if buffer == 'q' then
		engine.requestshutdown()
	end
end

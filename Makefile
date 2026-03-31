
default: run


lint:
	luacheck assets/

clean:
	@rm -rf build

build: clean
	@mkdir -p build
	@tar xvf `ls sol*player*` -C build

run:
	../engine/install/player/bin/player --premount ../engine/install/player/share/assets00.zip --premount ./assets01

gdb:
	gdb --args ../engine/install/player/bin/player --premount ../engine/install/player/share/assets00.zip --premount ./assets01

atlas:
	~/usr/bin/TexturePacker assets/The_Boy/The_Boy.tps

screenshot:
	@../engine/install/player/bin/player --premount ../engine/install/player/share/assets00.zip --premount ./assets01 & \
	PID=$$!; \
	sleep 3; \
	WID=$$(xdotool search --pid $$PID 2>/dev/null | head -1); \
	if [ -n "$$WID" ]; then \
		xdotool windowactivate --sync $$WID; \
		sleep 0.5; \
		import -window $$WID screenshot.png && echo "Saved screenshot.png"; \
	else \
		gnome-screenshot -f screenshot.png && echo "Saved screenshot.png (fallback)"; \
	fi; \
	kill $$PID 2>/dev/null || true

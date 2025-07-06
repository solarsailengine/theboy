
default: run

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

path = ~/.lexaloffle/pico-8/carts/feed-the-queen/

all: test install

test:
	# test lua files for errors
	@lua tests.lua

install:
	# copy new game files
	@mkdir -p ${path}
	@cp "game.p8" ./*.lua "spritesheet.png" ${path}

clean:
	# remove old files
	@rm -r ${path}

reinstall: install clean
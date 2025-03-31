path = ~/.lexaloffle/pico-8/carts/feed-the-queen/

all: install

install:
	# copy new game files
	@mkdir -p ${path}
	@cp "game.p8" ./*.lua ${path}

clean:
	# remove old files
	@rm -r ${path}

reinstall: install clean
SHELL = bash

all: work/block/Blockfile.json
	cd work/block && $(MAKE)
	source work/block/script/profile && block cibuild

work/block/Blockfile.json:
	git clone git@github.com:defn/block work/block


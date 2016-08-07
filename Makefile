SHELL = bash

all:
	@rm -f .bashrc.cache
	@script/cibuild ~

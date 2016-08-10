SHELL = bash

all:
	@rm -f .bashrc.cache
	@script/cibuild ~

cache:
	@rm -f .bashrc.cache
	@bash .bashrc
	@bash .bashrc

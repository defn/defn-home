SHELL = bash

all:
	@script/cibuild ~
	@facts cache

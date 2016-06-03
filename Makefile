SHELL = bash

all:
	@script/cibuild git@github.com:defn/defn-config git@github.com:defn/cache ~

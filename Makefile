SHELL = bash

ifeq (block,$(firstword $(MAKECMDGOALS)))
BLOCKS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
$(eval $(BLOCKS):;@:)
endif

block:
	@echo "$(BLOCKS)"

all:
	@rm -f .bashrc.cache
	@script/cibuild ~
	@$(MAKE) cache

cache:
	@rm -f .bashrc.cache
	@bash .bashrc
	@bash .bashrc

deps:
	@aptitude install -y ntp curl unzip git perl ruby language-pack-en nfs-common build-essential dkms lvm2 xfsprogs xfsdump bridge-utils thin-provisioning-tools software-properties-common aptitude

../base/Makefile.docker:
	sudo mkdir -p ../base
	sudo touch ../base/Makefile.docker

include ../base/Makefile.docker

docker:
	$(MAKE) home=defnhome home

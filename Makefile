SHELL = bash

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

container = block-$(shell basename $(PWD))
instance = deploy-$(shell basename $(PWD))

docker:
	docker build -t $(container) .d/

redeploy:
	$(MAKE) daemon
	$(MAKE) deploy

instance:
	@docker rm -f $(instance) $(instance) 2>/dev/null || true
	@docker run -d -ti -p 2222:22 -v /vagrant:/vagrant --name $(instance) $(instance) 
	$(MAKE) ssh

run:
	@docker rm -f $(container) $(container) 2>/dev/null || true
	@docker run -ti -p 2222:22 -v /vagrant:/vagrant --name $(container) $(container)

daemon:
	@docker rm -f $(container) $(container) 2>/dev/null || true
	@docker run -d -ti -p 2222:22 -v /vagrant:/vagrant --name $(container) $(container)

deploy:
	env HOME_REPO=git@github.com:defn/home home remote cache init ssh -A -p 2222 ubuntu@localhost --

ssh:
	ssh -A -p 2222 ubuntu@localhost

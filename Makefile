WORKSPACE='workspace'

.PHONY: clean
clean:
	@cd $(WORKSPACE); \
	    rm -rf _devops/ Vagrantfile README.md

.PHONY: build
build: check-arg
	@mkdir -p $(WORKSPACE);
	@cp -r _skeleton/* $(WORKSPACE)/;
	@cp -r puppet-modules $(WORKSPACE)/_devops/puppet/modules;
	@cd $(WORKSPACE); \
	    mkdir -p docroot; \
	    find _devops/ Vagrantfile README.md -type f | xargs sed -i "s/@@PROJECT@@/$(PROJECT)/g";

.PHONY: check-arg
check-arg:
ifndef PROJECT
	$(error PROJECT is undefined)
endif

.PHONY: all test clean

PLATFORM := $(shell docker version --format '{{.Server.Os}}/{{.Server.Arch}}')
DOCKER := docker run --rm --network none --platform $(PLATFORM)

test: lint unit-tests

unit-tests:
	@for f in tests/test*.sh; do \
		echo "sh $$f"; \
		sh "$$f"; \
	done

lint:
	$(DOCKER) -v ./Makefile:/work/Makefile:ro backplane/checkmake Makefile
	$(DOCKER) -v .:/workspace:ro mstruebing/editorconfig-checker ec -exclude '^\.git/'

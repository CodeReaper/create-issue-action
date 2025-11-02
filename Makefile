.PHONY: tests
tests: unit-tests

unit-tests:
	@for f in tests/test*.sh; do \
		echo "sh $$f"; \
		sh "$$f"; \
	done

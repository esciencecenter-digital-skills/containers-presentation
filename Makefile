.PHONY: build

pandoc_args += -s -trevealjs

build: docs/index.html

docs/index.html: index.md Makefile
	@mkdir -p docs
	pandoc $(pandoc_args) $< -o $@


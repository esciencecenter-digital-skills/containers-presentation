.PHONY: build

pandoc_args += -s -trevealjs
pandoc_args += --css style.css

genfig := fig/software-stack.svg
figures := $(wildcard fig/*) $(genfig)

build: docs/index.html docs/style.css $(addprefix docs/,$(figures))

watch:
	browser-sync start -w -s docs & \
	while true; do \
		inotifywait -e close_write *; \
		make build; \
	done

fig/software-stack.svg: figsrc/software-stack.scm figsrc/style.css
	cd figsrc; guile xml-gen.scm < software-stack.scm > ../fig/software-stack.svg

docs/fig/%: fig/%
	@mkdir -p docs/fig
	cp $< $@

docs/style.css: style.css
	cp $< $@

docs/index.html: index.md Makefile
	@mkdir -p docs
	pandoc $(pandoc_args) $< -o $@


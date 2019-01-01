
src = $(wildcard *.coffee)
dst = $(src:.coffee=.js)

build: $(dst)
	@true

%.js: %.coffee
	coffee -c $<

auto:
	@watch -n 1 $(MAKE) build

dist:
	mkdir -p dist
	rm -vf dist/rof.zip
	zip dist/rof.zip *.html *.js icons/* manifest.json

.PHONY: build auto dist

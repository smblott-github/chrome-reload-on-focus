
src = $(wildcard *.coffee)
dst = $(src:.coffee=.js)

build: $(dst)
	@true

%.js: %.coffee
	coffee -c $<

auto:
	@watch -n 1 $(MAKE) build

.PHONY: build auto

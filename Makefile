export IDRIS2 ?= idris2

.PHONY: page
page:
	pack build bug.ipkg
	mkdir -p js
	cp -f build/exec/main.js js/main.js

.PHONY: build dev-deps doc examples build-test test

all: build doc examples

build:
	dune build

doc:
	dune build @doc

dev-deps:
	opam install . --deps-only --yes
	(cd test/js; npm install)

examples:
	dune build examples/00-various/index.bc.js

build-test:
	dune build test/js/testsuite.bc.js --profile release
	cp _build/default/test/js/testsuite.bc.js test/js/testsuite.test.js
	cp _build/default/test/js/testsuite.bc.map test/js/testsuite.test.map

test: build-test
	(cd test/js; npm run test)

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

build-test: build
	dune build test/js/base_test.bc.js --profile release
	dune build test/js/array_test.bc.js --profile release

test: build-test
	(cd test/js; npm run test)

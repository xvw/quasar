.PHONY: build dev-deps doc examples

all: build doc examples

build:
	dune build

doc:
	dune build @doc

dev-deps:
	opam install . --deps-only --yes

examples:
	dune build examples/00-various/various.bc.js

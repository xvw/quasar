.PHONY: build dev-deps doc

all: build doc

build:
	dune build

doc:
	dune build @doc

dev-deps :
	opam install . --deps-only --yes

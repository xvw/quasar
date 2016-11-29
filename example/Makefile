OCAML    = ocamlfind ocamlc -g -package js_of_ocaml -package js_of_ocaml.ppx
ROUTER   = -package quasar
JSOCAML  = js_of_ocaml +weak.js +toplevel.js

.PHONY: example.ml

# Specific rule
all: example.js
	rm -rf *.byte
	rm -rf *.cm*


# Generic rules

%.byte: %.ml
	$(OCAML) $(ROUTER) -dsource -linkpkg -o $(@) $(<)

%.js: %.byte
	$(JSOCAML) -o $(@) $(<)

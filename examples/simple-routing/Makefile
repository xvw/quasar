OCAML    = ocamlfind ocamlc -g -package js_of_ocaml
QUASAR   = -package quasar -package quasar.ppx
SLIDES   = -package quasar.slideshow
JSOCAML  = js_of_ocaml +weak.js +toplevel.js

.PHONY: all

# Specific rule
all: app.js
	rm -rf *.byte
	rm -rf *.cm*


# Generic rules

%.byte: %.ml
	$(OCAML) $(QUASAR) $(SLIDES) -dsource -linkpkg -o $(@) $(<)

%.js: %.byte
	$(JSOCAML) -o $(@) $(<)

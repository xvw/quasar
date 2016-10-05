OCAML    = ocamlfind ocamlc -g -package js_of_ocaml
QUASAR   = -package quasar -package quasar.ppx
MAPBOX   = -package quasar.mapbox
JSOCAML  = js_of_ocaml +weak.js +toplevel.js

.PHONY: app.ml

# Specific rule
all: app.js
	rm -rf *.byte
	rm -rf *.cm*
	rm -rf *.out


# Generic rules

%.byte: %.ml
	ocamlc config.ml
	$(OCAML) $(QUASAR) $(MAPBOX) -dsource -linkpkg -o $(@) config.cmo $(<)

%.js: %.byte
	$(JSOCAML) -o $(@) $(<)

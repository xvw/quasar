CC=ocamlfind ocamlc -package js_of_ocaml -package quasar -package quasar.ppx

all:
	$(CC) -linkpkg -o temp.byte -dsource app.ml
	js_of_ocaml -o app.js +weak.js +toplevel.js temp.byte
	rm -rf *.cm*
	rm -rf temp.*

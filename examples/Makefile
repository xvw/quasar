CC=ocamlfind ocamlc -package js_of_ocaml -package js_of_ocaml.ppx -package quasar

all:
	$(CC) -linkpkg -o temp.byte app.ml
	js_of_ocaml -o app.js +weak.js temp.byte
	rm -rf *.cm*
	rm -rf temp.*

.PHONY: clean default

default: domtest.js

clean:
	rm domtest.js domtest.byte domtest.cmo domtest.cmi

domtest.js: domtest.byte
	js_of_ocaml $<
domtest.byte: domtest.cmo
	ocamlfind ocamlc -package lwt,js_of_ocaml -linkpkg -o $@ $<
domtest.cmo domtest.cmi: domtest.ml
	ocamlfind ocamlc -syntax camlp4o -package lwt,js_of_ocaml.syntax -g -c $<

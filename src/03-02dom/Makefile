.PHONY: clean default

default: dom.js

clean:
	rm dom.js dom.byte dom.cmo dom.cmi

dom.js: dom.byte
	js_of_ocaml $<
dom.byte: dom.cmo
	ocamlfind ocamlc -package lwt,js_of_ocaml -linkpkg -o $@ $<
dom.cmo dom.cmi: dom.ml
	ocamlfind ocamlc -syntax camlp4o -package lwt,js_of_ocaml.syntax -g -c $<

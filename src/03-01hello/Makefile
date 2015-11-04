hello.js: hello.byte
	js_of_ocaml $<
hello.byte: hello.cmo
	ocamlfind ocamlc -package lwt,js_of_ocaml -linkpkg -o $@ $<
hello.cmo hello.cmi: hello.ml
	ocamlfind ocamlc -syntax camlp4o -package lwt,js_of_ocaml.syntax -g -c $<

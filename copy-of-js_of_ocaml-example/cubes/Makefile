# http://d.hatena.ne.jp/camlspotter/20111015/1318664763
cubes.js: cubes.byte
	js_of_ocaml $<
cubes.byte: cubes.cmo
	ocamlfind ocamlc -package lwt,js_of_ocaml -linkpkg -o $@ $<
cubes.cmo: cubes.ml
	ocamlfind ocamlc -syntax camlp4o -package lwt,js_of_ocaml.syntax -g -c $<

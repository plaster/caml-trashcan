# ここまでのあらすじ

* [opamいれた](00start.md)。
* [opam install js_of_ocaml.2.5 した](01opam-install-js_of_ocaml.md)。

# js_of_ocaml してみたい

[http://ocsigen.org/js_of_ocaml/install](http://ocsigen.org/js_of_ocaml/install) のtarのexampleをビルドしてみる。
みんな cubes.ml やってるっぽいからこれがいいかな？

```
[ plaster@ropecat:~/work/caml-trashcan/copy-of-js_of_ocaml-example/cubes ]
% cat Makefile 
# http://d.hatena.ne.jp/camlspotter/20111015/1318664763
cubes.js: cubes.byte
	js_of_ocaml $<
cubes.byte: cubes.cmo
	ocamlfind ocamlc -package lwt,js_of_ocaml -linkpkg -o $@ $<
cubes.cmo: cubes.ml
	ocamlfind ocamlc -syntax camlp4o -package lwt,js_of_ocaml.syntax -g -c $<
```

camlspotterさんの記事をみながらさくっとMakefile書いて

```
[ plaster@ropecat:~/work/caml-trashcan/copy-of-js_of_ocaml-example/cubes ]
% make
ocamlfind ocamlc -syntax camlp4o -package lwt,js_of_ocaml.syntax -g -c cubes.ml
ocamlfind ocamlc -package lwt,js_of_ocaml -linkpkg -o cubes.byte cubes.cmo
js_of_ocaml cubes.byte
```

makeが無事走り

```
[ plaster@ropecat:~/work/caml-trashcan/copy-of-js_of_ocaml-example/cubes ]
% google-chrome index.html 
```

見えた！

# ここまでのあらすじ

* [opamいれた](00start.md)。
* [opam install js_of_ocaml.2.6 した](01opam-install-js_of_ocaml.md)。
* [cubes.ml コンパイルして cubes.js うごいた](02js_of_ocaml.md)。

# 自分で書いてみる

[http://d.hatena.ne.jp/camlspotter/20111015/1318664763](http://d.hatena.ne.jp/camlspotter/20111015/1318664763)見ながら。まずはUnsafe.eval_string

```
[ plaster@ropecat:~/work/caml-trashcan/src/03-01hello ]
% cat index.html 
<!DOCTYPE HTML>
<html>
	<head>
		<script src="hello.js"></script>
	</head>
	<body>
	</body>
</html>
```

```
% cat hello.ml
(* http://d.hatena.ne.jp/camlspotter/20111015/1318664763 *)

open Js

let _ = Unsafe.eval_string "
alert('hello, world!');
"
```

```
% make
ocamlfind ocamlc -syntax camlp4o -package lwt,js_of_ocaml.syntax -g -c hello.ml
ocamlfind ocamlc -package lwt,js_of_ocaml -linkpkg -o hello.byte hello.cmo
js_of_ocaml hello.byte
```

ちゃんとalertされた！

DOM扱うには[Domモジュール](http://ocsigen.org/js_of_ocaml/2.6/api/Dom)なのかな？とりあえず「 <code>open Dom</code>」とか唱えてみるが、、、

```
% make
ocamlfind ocamlc -syntax camlp4o -package lwt,js_of_ocaml.syntax -g -c dom.ml
File "dom.ml", line 4, characters 5-8:
Error: Unbound module Dom
make: *** [dom.cmo] エラー 2
```

おやまあ。

（つづく。。。のか？）

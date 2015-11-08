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

きたきた。`open Dom_html`らしい。これで `Dom`モジュール内に定義されてるものも使えるようになってる感じ。

```
[ plaster@ropecat:~/work/caml-trashcan/src/03-02dom ]
% cat domtest.ml 
(* http://d.hatena.ne.jp/camlspotter/20111015/1318664763 *)

open Js
open Dom_html

let _ = Dom.ELEMENT

let _ = Unsafe.eval_string "
alert('hello, world!');
"
```

```
[ plaster@ropecat:~/work/caml-trashcan/src/03-02dom ]
% make
ocamlfind ocamlc -syntax camlp4o -package lwt,js_of_ocaml.syntax -g -c domtest.ml
ocamlfind ocamlc -package lwt,js_of_ocaml -linkpkg -o domtest.byte domtest.cmo
js_of_ocaml domtest.byte
```

しかしこのまま進もうにも使い方よくわかんないので、もうちょっときゃみばさまの記事を見ながらいじってこう。
「Class type で JS のオブジェクトをエンコード」のとこからが急に難易度が上がっている。
tってなんだ？みたいになってるのでとりあえず[このへんながめる](http://ocsigen.org/js_of_ocaml/2.6/api/Js#2_TypesforspecifyingmethodandpropertiesofJavascriptobjects)など。

型がちょっとむずかしい。なるべくかんたんになるようにつくられてるんだろうなって気はするんだけど、なんのために t をはさみまくるのかとかがあんまりわかってない。
それは置いといてみようみまねでやりたいとこなんだけど、たとえば
[`type (-'a, +'b) meth_callback`](http://ocsigen.org/js_of_ocaml/2.6/api/Js#TYPEconstr) の `-` や `+` ってなんだ？ってなる。OCamlの言語への理解がたりない。。。常ひごろOCamlさわってるひとじゃないとうれしくないのでは疑惑。OCamlの入門書どっかで調達してこよう。。。

[前へ](04introductiontoobjectivecaml-1.md)

# あらすじ

OCamlでJS書く仕組みをつかってみようとしたけどOCamlわかんないのにきづいたので[教科書になりそうなPDF](https://www.google.co.jp/search?q=Introduction+to+Objective+Caml)ながめてるなう

# 5章

多相型がでてくる。
推論させたくない場合は式の（おそらくは、至るところで）型を明示できる。
関数の場合は、引数と戻り値とでそれぞれ指定の仕方があるっぽい。

```ocaml
# let f1 (x : int) y z = x;;
val f1 : int -> 'a -> 'b -> int = <fun>
# let f3 x y (z : int) = z;;
val f3 : 'a -> 'b -> int -> int = <fun>
# let f1' x y z : int = x;;
val f1' : int -> 'a -> 'b -> int = <fun>
```

Value restrictionと単相型の説明もある。

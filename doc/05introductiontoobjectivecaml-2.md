[前へ](04introductiontoobjectivecaml-1.md)

# あらすじ

OCamlでJS書く仕組みをつかってみようとしたけどOCamlわかんないのにきづいたので[教科書になりそうなPDF](https://www.google.co.jp/search?q=Introduction+to+Objective+Caml)ながめてるなう

# 5章

多相型がでてくる。
推論させたくない場合は式の（おそらくは、至るところで）型を明示できる。
関数の場合は、引数と戻り値とでそれぞれ指定の仕方があるっぽい。

## 引数

```ocaml
# let f1 (x : int) y z = x;;
val f1 : int -> 'a -> 'b -> int = <fun>
# let f3 x y (z : int) = z;;
val f3 : 'a -> 'b -> int -> int = <fun>
```

## 戻り値

```ocaml
# let f1' x y z : int = x;;
val f1' : int -> 'a -> 'b -> int = <fun>
```

Value restrictionと単相型の説明もある。

キーワードっぽいの

> arbitrary type
> some (as yet unknown) type

Value restrictionについてのすんごいシンプルな説明があった。

> 「式が真に多相である（型をもつ）ためには、immutableな値でなければならない。immutableな値というのは、第一に完全に評価済みの値であるということ、第二に（破壊的）代入により変更されることがない値であるということだ。」
> 「関数適用が多相で(ある型をもた)ないのは、mutableな値を生成したり、（破壊的）代入を行うことがあるからだ。」

で、η展開(eta-expansion)してあげるとちゃんと多相（型をもつよう）になるのだと。

```
# identity identity;;
- : '_a -> '_a = <fun>
# fun x -> (identity identity) x;;
- : 'a -> 'a = <fun>
```

そうやって回避できるっていうのはわかったけど、どうしてこれで回避になってるのかは、よくわからない。

話は変わって、オーバーロード。
オーバーロードがない理由1: コンパイラが複雑になるし、十分に強力な型システムのもとでは型推論が計算不能になったりしかねないから。
オーバーロードがない理由2: プログラムを理解する難易度が上がるから。

<!-- vi: se ft=markdown : -->

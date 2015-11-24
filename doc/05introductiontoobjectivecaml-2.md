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

話は変わって、オーバーロード。教科書の要点まとめ:
* オーバーロードがない理由
  1. コンパイラが複雑になるし、十分に強力な型システムのもとでは型推論が計算不能になったりしかねないから。
  2. プログラムを理解する難易度が上がるから。
* 一方で、subtype polymorphismやdynamic method dispatch はフルでサポートしてる。 


## 5.2 Tuples

「the ordered tuples you have seen in mathmatics」は「順序対」を3個以上に拡張した感じかな？
DB項目の定義に使うのは"awkward"、record type使うべし。

ちょっとつかってみる。

```ocaml
# let div_and_mod n d = n / d, n mod d;;
val div_and_mod : int -> int -> int * int = <fun>
# div_and_mod 50 7;;
- : int * int = (7, 1)
# div_and_mod 50 11;;
- : int * int = (4, 6)
# div_and_mod 100 0;;
Exception: Division_by_zero.
```

letで受け取って多値返しにふつうに使える感じ。
```ocaml
# let n, d = div_and_mod 50 13 in n, d, n+d, n-d, n*d, n/d;;
- : int * int * int * int * int * int = (3, 11, 14, -8, 33, 0)
```

<!-- vi: se ft=markdown : -->

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


## 5.3 Lists

例のこれ

```ocaml
# let rec mem x l =
    match l with
      [] -> false
    | y :: l -> x = y || mem x l;;
val mem : 'a -> 'a list -> bool = <fun>
```

「`=`」をつかってるんだけど、型パラメータ的には「`'a`」なので、`=`がいつどんなとき使えるのみたいなのがすごい気になっている。
「`<`」もね。書いてみよう。

```ocaml
# let rec inorder xs =
  match xs with
    [] -> true
  | _ :: [] -> true
  | x :: ((x' :: _) as xs) -> x < x' && inorder xs;;
val inorder : 'a list -> bool = <fun>
# inorder [ 0; 1; 2 ];;
- : bool = true
# inorder [];;
- : bool = true
# inorder [ 1 ];;
- : bool = true
# inorder [ 0; 1; 1; 2 ];;
- : bool = false
# inorder [ 0; 1; 2 ];;
- : bool = true
# inorder [];;
- : bool = true
# inorder [ 1 ];;
- : bool = true
# inorder [ 0; 1; 1; 2 ];;
- : bool = false
# inorder [ [ 1; 2]; [ 1; 2 ] ];;
- : bool = false
# inorder [ [ 1; 2]; [ 1; 2; 3 ] ];;
- : bool = true
# inorder [ []; [ []; [] ]; [ []; [] ] ];;
- : bool = false
# inorder [ []; [ []; [] ]; [ []; [ [] ] ] ];;
- : bool = true
```

Haskellでいう Ord が最初から入ってる、のかな？
でも自分で定義した型とかだとどうなるんだろ？ record typeがでてきたら要チェックかな。

## 5.4 Tail recursion

だいじだよね

## 5.5 Exercise

### 5.4

```ocaml
# let select' db p =
    let rec loop acc db = match db with [] -> acc | e :: db -> loop (if p e then e :: acc else acc) db in
    let rec rev acc ls = match ls with [] -> acc | e :: ls -> loop (e :: acc) ls in
    rev [] ( loop [] db )
  ;;
val select' : 'a list -> ('a -> bool) -> 'a list = <fun>
# let select = select' db;;
val select :
  (string * string * float -> bool) -> (string * string * float) list = <fun>
```

ざっくりと。

```ocaml
- : (string * string * float) list =
[("John", "x3456", 50.1); ("Jaan", "unlisted", 12.7)]
```

たぶんおっけー。

ところで今更だけど、ぜんぶ違うんね。

```ocaml
# (2, 3, 4);;
- : int * int * int = (2, 3, 4)
# (2, (3, 4));;
- : int * (int * int) = (2, (3, 4))
# ((2, 3), 4);;
- : (int * int) * int = ((2, 3), 4)
```

`fst` なんかは `'a * 'b` しかとれないから

```ocaml
# fst;;
- : 'a * 'b -> 'a = <fun>
# snd;;
- : 'a * 'b -> 'b = <fun>
```

使うのもこんな感じになる

```ocaml
# fst (2, 3, 4);;
Characters 4-13:
  fst (2, 3, 4);;
      ^^^^^^^^^
Error: This expression has type 'a * 'b * 'c
       but an expression was expected of type 'd * 'e
# fst (2, (3, 4));;
- : int = 2
# fst ((2, 3), 4);;
- : int * int = (2, 3)
```

### 5.5

かんがえる。
例外とかつかって抜けちゃえばいいかも？あ、でもそれだと型が `'a -> 'b` になっちゃうか
```ocaml
# let f x = raise (Invalid_argument "hoge");;
val f : 'a -> 'b = <fun>
```
うむ。じゃあ、ifとかで通らない方にすれば。。。？
```ocaml
# let f x = if x = x then raise (Invalid_argument "=") else x;;
val f : 'a -> 'a = <fun>
```
型は合った。適用してみる。
```ocaml
# f 10;;
Exception: Invalid_argument "=".
# f "xxx";;
Exception: Invalid_argument "=".
# f 1.0;;
Exception: Invalid_argument "=".
# f nan;;
- : float = nan
```

期待どおり！
無限ループして帰ってこないやつでも同じことできそう。

```ocaml
# let rec f x = if x = x then f x else x;;
val f : 'a -> 'a = <fun>
# f nan;;
- : float = nan
# f 10;;
^CInterrupted.
```

### 5.6

value restriction に引っかかって単相型になってるだけ。なのでfunで包んでみる、が。。。

```ocaml
# let f x = let x' = g x in fun y -> h x' y;;
val f : int -> 'a -> 'a = <fun>
# let f' = f 0;;
val f' : '_a -> '_a = <fun>
```

だめだこれ。すぐにはわかんない。letがキモだったきもするんだけど、「g xを二度計算しない」との両立を達成する方法がわかんない。。。

### 5.7

rev_append を定義して、revして渡す、がお約束。

あ、末尾再帰版のrevはrev_appendといっしょだ。

```ocaml
# let append xs ys =
    let rec rev_append xs a = match xs with [] -> a | (x :: xs) -> rev_append xs (x :: a) in
    rev_append (rev_append xs []) ys
  ;;
val append : 'a list -> 'a list -> 'a list = <fun>
```

```ocaml
# append [1; 2; 3] [4; 5; 6];;
- : int list = [1; 2; 3; 4; 5; 6]
```

おｋ

### 5.8

`welfare crook`なる用語が出現。「生活保護の不正受給者」ってとこかな？

3つのリストに共通の要素を取り出す。どれもソートされてる。
頭の体操したいので、O(Σリスト長) の実装にしよう。
仕込みでdrop_whileをつくる。

```ocaml
# let drop_while p xs =
    let rec loop xs = match xs with
      [] -> []
    | (x' :: xs') -> if p x'
                     then loop xs'
                     else xs
  in loop xs
  ;;
val drop_while : ('a -> bool) -> 'a list -> 'a list = <fun>
```

~~あと必要な部品は、「リストのリストを受け取って、それぞれの先頭要素がすべて存在して等しいなら返す」、かな。Option使うか。~~
「2本のリストを受け取って共通部分返す」で十分だった。これを畳み込むなりすればn本に対しても動くし、オーダもかわらない。
あと、そろそろインタプリタだけで打ち込むのやめた。

```ocaml
% cat walfarecrook.ml 
let drop_while p xs =
    let rec loop xs = match xs with
        []          -> []
    |   (x' :: xs') ->
        if p x'
        then loop xs'
        else xs
    in loop xs

let intersect xs ys =
    let rec loop xs ys acc = match xs with
        []          -> acc
    |   ( x :: xs ) ->
        match drop_while ( fun y -> y < x ) ys with
            []                  -> acc
        |   ( z :: zs ) as ys ->
            if x = z
            then loop xs zs (x :: acc)
            else loop xs ys acc
    in
    let rec rev xs acc = match xs with
        [] -> acc
    |   ( x :: xs ) -> rev xs ( x :: acc )
    in
        rev (loop xs ys []) []

let walfarecrook xs ys zs =
    intersect (intersect xs ys) zs
```

```ocaml
% ocaml -init walfarecrook.ml
        OCaml version 4.02.3

# walfarecrook [ "AAA"; "BBB"; "CCC" ] [ "ABB"; "BBB"; "CCA"; "CCC"] ["BBB"; "CCX"];;
- : string list = ["BBB"]
```

# 6章

代数的データ型の話。途中でパターンマッチの話にもどる。
「OCamlで2つのパターン p1, p2 を 選択パターン p1 | p2 に結合することが許されるのは以下の2つの条件がそろっているときです: どちらのパターンも同じ変数を定義していること。どちらにも出現する変数はそれぞれで同じ型であること。それ以外はパターン中の変数がどんな配置になっていてもだいじょうぶです。」

コンストラクタがとれる引数はたかだか1個。複数もたせたいならタプルにしよう。カッコ必須。
引数つきコンストラクタは関数適用みたくなるけど関数じゃないので、単独で値として扱うことはできない。

<!-- vi: se ft=markdown : -->

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

Treeを定義してる。再帰的な型の定義はすんなりできるっぽい。「tree型の定義が再帰的なので、tree（の値）を引数にとる関数も再帰的になるだろうね」

## 6.4 Balanced red-black tree

ちゃんと読んで書けるようにしておきたい。

balance関数でさっそく選択パターンつかってる。構造を正規化するのを書くのにぴったりなんだな。
それはいいとして第一引数がBlackの場合しかみてないぽいんだけどなんでだ？挿入結果の(sub)ツリーのrootの色。
balance関数がなんとかしたいのは「a Red node has a Red child」のケース。それが発生し得るケースとして列挙されてるのすべて、rootが黒。うーん？

ああ、黒でだいじょうぶなのか？じゃなくて、「黒でだいじょうぶなように作ってる」んだわ、これたぶん。

## 6.5 Open union types

難しくなってきた。「最低限これらのコンストラクタを持つ型」を扱う話。

```ocaml
# 'Real 1.0;;
Characters 0-1:
  'Real 1.0;;
  ^
Error: Syntax error
```

???
あ、<code>'</code>じゃなくて<code>`</code>か。

```ocaml
# `Real 1.0;;
- : [> `Real of float ] = `Real 1.
```

で、こういう型にtypeで名前をつけようとすると（つけられるんだ！）、型引数を明示しなきゃいけないらしい。理由はまだ理解できてない。

```ocaml
# type num1 = [> `Integer of int ];;
Characters 0-32:
  type num1 = [> `Integer of int ];;
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Error: A type variable is unbound in this type declaration.
In type [> `Integer of int ] as 'a the variable 'a is unbound
# type 'a num1 = [> `Integer of int ];;
Characters 0-35:
  type 'a num1 = [> `Integer of int ];;
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Error: A type variable is unbound in this type declaration.
In type [> `Integer of int ] as 'a the variable 'a is unbound
```

```ocaml
# type 'a num1 = [> `Integer of int ] as 'a;;
type 'a num1 = 'a constraint 'a = [> `Integer of int ]
```

うーん。。。？？？

あと ```[> ... ]``` だけじゃなくて ```[< ... ]``` もあったよなー。これは「 *closed* union type」らしい。
例にあるような、引数の型として現れることが多そう。「たかだかこれだけのコンストラクタしかもってない型の値なら渡せます」

型引数の謎がとけてないけど説明おわってExerciseにきてしまった。。。


## 6.7 Exercise

### 6.1

```ocaml
# type 'a mylist = Nil | Cons of 'a * 'a mylist ;;
type 'a mylist = Nil | Cons of 'a * 'a mylist
# let rec rev a xs = match xs with Nil -> a | Cons(x, xs) -> rev (Cons(x, a)) xs;;
val rev : 'a mylist -> 'a mylist -> 'a mylist = <fun>
# let map f xs = let rec loop a xs = match xs with Nil -> rev Nil a | Cons(x, xs) -> loop (Cons(f x, a)) xs in loop Nil xs;;
val map : ('a -> 'b) -> 'a mylist -> 'b mylist = <fun>
```

```ocaml
# map (fun x -> x * x) (Cons(1, (Cons(2, (Cons(3, (Cons(4, Nil))))))));;
- : int mylist = Cons (1, Cons (4, Cons (9, Cons (16, Nil))))
```

Consの前にもうしろにもカッコ要るのしんどい。。。

```ocaml
# let append xs ys = rev ys (rev Nil xs);;
val append : 'a mylist -> 'a mylist -> 'a mylist = <fun>
```

```ocaml
# let ls = (Cons(1, (Cons(2, (Cons(3, (Cons(4, Nil))))))));;                   
val ls : int mylist = Cons (1, Cons (2, Cons (3, Cons (4, Nil))))
# let ls2 = map (fun x -> x + 10) ls;;
val ls2 : int mylist = Cons (11, Cons (12, Cons (13, Cons (14, Nil))))
# append ls ls2;;
- : int mylist =
Cons (1,
 Cons (2,
  Cons (3, Cons (4, Cons (11, Cons (12, Cons (13, Cons (14, Nil))))))))
```

### 6.2

```ocaml
# type unary_number = Z | S of unary_number;;
type unary_number = Z | S of unary_number
```

デバッグ用に

```ocaml
# let int_of_unary_number x = let rec loop a x = match x with Z -> a | S x -> loop (a + 1) x in loop 0 x;;
val int_of_unary_number : unary_number -> int = <fun>
```

```ocaml
# int_of_unary_number S(S(Z))
  ;;
Characters 0-19:
  int_of_unary_number S(S(Z))
  ^^^^^^^^^^^^^^^^^^^
Error: This function has type unary_number -> int
       It is applied to too many arguments; maybe you forgot a `;'.
# S(S(Z));;
- : unary_number = S (S Z)
# int_of_unary_number ( S(S(Z)) );;
- : int = 2
```

関数の引数になるとこでだけ気をつけないとあかんってことだな。
ちょっと前に「Consの前にもうしろにもカッコ要る」とか書いたけど、外側のカッコはいちばん外側だけでよかったにちがいない。

```ocaml
# map (fun x -> x * x) ( Cons( 1, Cons( 2, Cons( 3, Cons( 4, Nil ) ) ) ) );;
- : int mylist = Cons (1, Cons (4, Cons (9, Cons (16, Nil))))
```

うむ。閑話休題、デバッグ用をもうちょっと追加定義。

```ocaml
# let unary_number_of_int x = let rec loop a x = match x with 0 -> a | _ -> loop (S a) (x - 1) in loop Z x;;
val unary_number_of_int : int -> unary_number = <fun>
# unary_number_of_int 10;;
- : unary_number = S (S (S (S (S (S (S (S (S (S Z)))))))))
# int_of_unary_number (unary_number_of_int 10);;
- : int = 10
```

```ocaml
# let rec add_unary_number x y = match y with Z -> x | (S y) -> add_unary_number (S x) y;;
val add_unary_number : unary_number -> unary_number -> unary_number = <fun>
# int_of_unary_number (add_unary_number (unary_number_of_int 5) (unary_number_of_int 50) );;
- : int = 55
```

```ocaml
# let rec mult_unary_number x y = let rec loop a x = match x with Z -> a | (S x) -> loop (add_unary_number a y) x in loop Z x;;             
val mult_unary_number : unary_number -> unary_number -> unary_number = <fun>
# int_of_unary_number (mult_unary_number (unary_number_of_int 7) (unary_number_of_int 6));;
- : int = 42
# mult_unary_number Z (unary_number_of_int 100);;
- : unary_number = Z
# mult_unary_number (unary_number_of_int 100) Z;;
- : unary_number = Z
```

### 6.3

これはかんたん。
……でいいんだよね？

```ocaml
# type small = Four | Three | Two | One;;
type small = Four | Three | Two | One
# Four < One;;
- : bool = true
# let lt_small x y = y < x;;
val lt_small : 'a -> 'a -> bool = <fun>
# lt_small One Four;;
- : bool = true
# lt_small Four One;;
- : bool = false
```

6.3.2のツッコミに対しては、「typeがどんだけふくれようと lt_small の定義は拡張の必要なし」


### 6.4

```ocaml
# type unop = Neg
type binop = Add | Sub | Mul | Div
type exp =
  Constant of int
| Unary of unop * exp
| Binary of exp * binop * exp          
  ;;
type unop = Neg
type binop = Add | Sub | Mul | Div
type exp =
    Constant of int
  | Unary of unop * exp
  | Binary of exp * binop * exp
```

```ocaml
# let rec eval = function
    Constant n -> n
  | Unary (Neg, e) -> -1 * eval e
  | Binary (e0, Add, e1) -> (eval e0) + (eval e1)
  | Binary (e0, Sub, e1) -> (eval e0) - (eval e1)
  | Binary (e0, Mul, e1) -> (eval e0) * (eval e1)
  | Binary (e0, Div, e1) -> (eval e0) / (eval e1)
  ;;
val eval : exp -> int = <fun>
```

```ocaml
# eval ( Binary( Constant 10, Add, Constant 15 ) );;
- : int = 25
```

もっといくつかの例で確かめるべきというか例を先につくっておくくらいの習慣がほしい。。。

### 6.5

```ocaml
# type ('key, 'value) dictionary = Leaf | Node of 'key * 'value * ('key, 'value) dictionary * ('key, 'value) dictionary;;
type ('key, 'value) dictionary =
    Leaf
  | Node of 'key * 'value * ('key, 'value) dictionary *
      ('key, 'value) dictionary
```

```ocaml
# let empty = Leaf;;
val empty : ('a, 'b) dictionary = Leaf
# let rec add dic k v = match dic with                                                      
    Leaf -> Node(k, v, Leaf, Leaf)
  | Node(k0, v0, left, right) ->
      if k < k0
      then Node(k0, v0, (add left k v), right)
      else if k0 < k
      then Node(k0, v0, left, add right k v) 
      else dic
  ;;
val add : ('a, 'b) dictionary -> 'a -> 'b -> ('a, 'b) dictionary = <fun>
# let rec find dic k = match dic with
    Leaf -> raise Not_found
  | Node(k0, v0, left, right) ->
      if k < k0
      then find left k
      else if k0 < k
      then find right k
      else v0
  ;;
val find : ('a, 'b) dictionary -> 'a -> 'b = <fun>
```

```ocaml
# let d = add (add (add (add empty 10 "abc") 20 "def") 15 "ZZZ") 40 "hoge";; 
val d : (int, string) dictionary =
  Node (10, "abc", Leaf,
   Node (20, "def", Node (15, "ZZZ", Leaf, Leaf),
    Node (40, "hoge", Leaf, Leaf)))
# find d 20;;
- : string = "def"
# find d 15;;
- : string = "ZZZ"
# find d 40;;
- : string = "hoge"
# find d 10;;
- : string = "abc"
# find d 42;;
Exception: Not_found.
```

### 6.6

準備。
```ocaml
# type vertex = int;;
type vertex = int
# type graph = (vertex, vertex list) dictionary;;
type graph = (vertex, vertex list) dictionary
```

visitedな頂点を判定できるようにしておく。

```ocaml
# type vertex_set = (vertex, unit) dictionary;;
type vertex_set = (vertex, unit) dictionary
# let member dic k = try match find dic k with _ -> true with Not_found -> false;;
val member : ('a, 'b) dictionary -> 'a -> bool = <fun>
```

さてreachableを、、、といきたいところだが、再帰でvisitedをためてくのをpureに書くのってどうやるのがいいんだったっけ。。

ちょっとおやすみ。プロンプトに直打ちするのやめて、スクリプトにした。

途中で探索打ち切れないのがちょい残念だけど、「行ける場所全列挙して、その中に目的地があるか確かめる」ようにしてみた

```ocaml
let reachable_vertices (g : graph) (s : vertex) =
  let rec loop (vs : vertex_set) (ss : vertex list) =
    match ss with
      [] -> vs
    | s :: ss ->
      if member vs s
      then vs
      else
        let children = try find g s with Not_found -> []
        in loop ( loop ( add vs s () )
                       children )
                ss
  in loop empty [s]

let reachable (g : graph) (s : vertex) (d : vertex) =
  let vs = reachable_vertices g s
  in member vs d
```

### 6.7

### 6.8

だんだんだるくなってきた。。。（
こんなときはさっさと先を読み進めるほうがよいだろう 

<!-- vi: se ft=markdown : -->

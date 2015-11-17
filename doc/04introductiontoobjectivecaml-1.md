# 今北産業

* js_of_ocaml であそぶために opamいれて環境をどうにかととのえたけれど
* わたしOCamlしらないじゃんってことに今更気づき（ISでの演習はどうした！）
* [教科書になりそうなPDF](https://www.google.co.jp/search?q=Introduction+to+Objective+Caml)ながめることにした

# 読んでみる

最初の方はざーっと読み飛ばす。Exerciseがちゃんとついてるのでそこだけさくさく解いていこう。

## Exercise 2.1

きになったもの

### 9
```ocaml
# if false then ();;
- : unit = ()
```

`else`が省略できる。その場合、式の値は利用できない。型がunitになる。

### 11
```ocaml
# true || (1 / 0 >= 0);;
- : bool = true
```

短絡評価。

### 14
```ocaml
# "Hello world".[11] <- 's';;
Characters 0-25:
  "Hello world".[11] <- 's';;
  ^^^^^^^^^^^^^^^^^^^^^^^^^
Warning 3: deprecated: String.set
Use Bytes.set instead.
Exception: Invalid_argument "index out of bounds".
```

文字列の途中を破壊的に（？）置き換えるのちょっと心配なのと、deprecatedでてるので教科書ちょっと古そうな予感がする

### 15
```ocaml
# String.lowercase "A" < "B";;
- : bool = false
```

文字列の大小比較がふつうに `<` でできるようだ。


## Exercise 3.1

### 9
```ocaml
# let x x = x + 1 in x 2;;
- : int = 3
```

わかる

### 10
```ocaml
# let rec x x = x + x in x 2;;
- : int = 4
```

！！？？？ ナンデ？？？型が明らかにちがうから混同しない、的な？？？

```ocaml
# let rec f x = if x < 1 then 1 else x * f (x - 1) in f 10;;
- : int = 3628800
```

```ocaml
# let rec x x = if x < 1 then 1 else x * x (x - 1) in x 10;;
Characters 39-40:
  let rec x x = if x < 1 then 1 else x * x (x - 1) in x 10;;
                                         ^
Error: This expression has type int
       This is not a function; it cannot be applied.
```

なるほどー、引数の束縛でshadowingされて本体関数は見えません、と。

### 15
```ocaml
# let (++) x = x + 1 in ++x;
  ^CInterrupted.
```

~~んー？なんだこれ。xは未束縛じゃないの？~~
セミコロンたりんかっただけだった。
```ocaml
# let (++) x = x + 1 in ++x;;
Characters 22-24:
  let (++) x = x + 1 in ++x;;
                        ^^
Error: Syntax error
```

単項演算子にはならないようだ。二項演算子として使うこと自体はできる（ただし型エラー。第二引数を食べようとするけど、第一引数を食べた時点でもう関数じゃなくなっちゃってるので）
```ocaml
# let (++) x = x + 1 in 1 ++ x;;
Characters 24-26:
  let (++) x = x + 1 in 1 ++ x;;
                          ^^
Error: This function has type int -> int
       It is applied to too many arguments; maybe you forgot a `;'.
```
しかし相変わらず x が未束縛なとこにはツッコミが入らない。。。（

コンパイラのパイプライン的に 字句解析→構文解析→変数解決→型チェック みたくなってると想像してたんだけど、変数解決より型チェックのが先に来る場合がありえるということで、処理系の実装方法についての重要な（？）示唆を与える結果だ。

## Exercise 3.3

さくっと末尾再帰で。

```ocaml
# let sum n m f =
    let rec loop i a = if i <= m then loop (i + 1) (a + f(i)) else a
    in loop n 0
  ;;
val sum : int -> int -> (int -> int) -> int = <fun>
# sum 1 10 (fun x -> x);;
- : int = 55
# sum 3 4 (fun x -> x * x);;
- : int = 25
```

## Exercise 3.4

そのまま書き下す。

```ocaml
# let rec gcd n m =
  if m = 0
  then n
  else if n > m
       then gcd (n - m) m
       else gcd n (m - n)
  ;;
val gcd : int -> int -> int = <fun>
# gcd 36 27;;
- : int = 9
# gcd 27 36;;
- : int = 9
# gcd 1 1;;
- : int = 1
# gcd 10 1;;
- : int = 1
# gcd 1 10;;
- : int = 1
# gcd 100 200;;
- : int = 100
# gcd 200 100;;
- : int = 100
# gcd 0 0;;
- : int = 0
# gcd 128 192;;
- : int = 64
```

## Exercise 3.5

二分探索とかしたほうがいいのかな、と思いつつもやる気出ないので、さくっと片付ける。
ついでに例外とかつかってみる。f 0 < 0 もチェックしたほうがよかっただろうか。。。？

```ocaml
# let search f n =
    let rec loop i =
      if i < n
      then if f i >= 0
           then i
           else loop (i + 1)
      else raise (Failure "no positive value")
    in loop 0
  ;;
val search : (int -> int) -> int -> int = <fun>
# search (fun x -> x - 5) 20;;
- : int = 5
# search (fun x -> x * x - 49) 10;;
- : int = 7
# search (fun x -> x * x - 50) 10;;
- : int = 8
# search (fun x -> x * x - 300) 10;;
Exception: Failure "no positive value".
```

## Exercise 3.6

### 1

```ocaml
# let empty _ = 0;;
val empty : 'a -> int = <fun>
# let add dict k v = fun k' -> if k = k' then v else dict k';;
val add : ('a -> 'b) -> 'a -> 'b -> 'a -> 'b = <fun>
# let find dict k = dict k;;
val find : ('a -> 'b) -> 'a -> 'b = <fun>
```

## Exercise 3.7

なんだこりゃ。bとcは固定、aが何度も動く。のを効率良く計算するコードを書けと。
```math
\frac{-b+\sqrt{b^2-4ac}}{2a}
```

これそのままじゃダメだよなー。なんかイイ感じの式変形が求められてる気がするんだけどうーんうーん
```math
\frac{\frac{-b}{2} + \sqrt{\frac{b^2}{4} - ac}}{a}
```
せいぜいこのくらい？

```ocaml
# let r' c b =
    let nbhalf = -. b /. 2.0
    and sqbhalf = (b *. b) /. 4.0
    in fun a -> (nbhalf +. sqrt (sqbhalf -. c *. a)) /. a
  ;;
val r' : float -> float -> float -> float = <fun>
```

## Exercise 3.8

3.7はよくわかんなかったけど3.8はちょっとかっこよさそうなのできをとりなおして。

### 1

```ocaml
# let (+:) s c = fun i -> c + s i;;
val ( +: ) : ('a -> int) -> int -> 'a -> int = <fun>
# let (-|) sx sy = fun i -> (sx i) - (sy i);;
val ( -| ) : ('a -> int) -> ('a -> int) -> 'a -> int = <fun>
# let map f s = fun i -> f ( s i);;
val map : ('a -> 'b) -> ('c -> 'a) -> 'c -> 'b = <fun>
```

### 2

とりあえず足りない関数いくつか書き足す

```ocaml
# let hd s = s 0;;
val hd : (int -> 'a) -> 'a = <fun>
# let tl s i = s (i + 1);;
val tl : (int -> 'a) -> int -> 'a = <fun>
# let derivative s = tl s -| s;;
val derivative : (int -> int) -> int -> int = <fun>
```

そんでもって動くかみてみる

```ocaml
# let evens i = i * 2;;
val evens : int -> int = <fun>
# [evens 0;evens 1;evens 2;evens 3];;
- : int list = [0; 2; 4; 6]
# let de = derivative evens in [ de 0; de 1; de 2; de 3 ];;
- : int list = [2; 2; 2; 2]
# [ sqs 0; sqs 1; sqs 2; sqs 3; sqs 4];;
- : int list = [0; 1; 4; 9; 16]
# let ds = derivative sqs in [ ds 0; ds 1; ds 2; ds 3 ];;
- : int list = [1; 3; 5; 7]
```

integral 書いてみる

```ocaml
# let rec integral s i = s i + if i = 0 then 0 else s (i-1);;
val integral : (int -> int) -> int -> int = <fun>
```

うごくかな？？

```ocaml
# let evens' = integral (derivative evens);;
val evens' : int -> int = <fun>
# [evens' 0;evens' 1;evens' 2;evens' 3];;
- : int list = [2; 4; 4; 4]
```

あちゃ。どこまちがったかな。。。って `integral` の `s (i-1)` は integralよばなきゃ。再帰になってないorz

```ocaml
# let integral s = let rec loop i = s i + if i = 0 then 0 else loop (i-1) in loop;;
val integral : (int -> int) -> int -> int = <fun>
# let evens' = integral (derivative evens);;
val evens' : int -> int = <fun>
# [evens' 0;evens' 1;evens' 2;evens' 3];;
- : int list = [2; 4; 6; 8]
# let sqs' = integral (derivative sqs);;  
val sqs' : int -> int = <fun>
# [ sqs' 0; sqs' 1; sqs' 2; sqs' 3; sqs' 4 ];;
- : int list = [1; 4; 9; 16; 25]
```

でき、た。。。？ いや、off-by-one やらかしてる。

```ocaml
# let integral s = let rec loop i = if i = 0 then 0 else s i-1 + loop (i-1) in loop;;
val integral : (int -> int) -> int -> int = <fun>
# let sqs' = integral (derivative sqs);;
val sqs' : int -> int = <fun>
# [ sqs' 0; sqs' 1; sqs' 2; sqs' 3; sqs' 4 ];;
- : int list = [0; 2; 6; 12; 20]
```

んー？なんかへん？？結合？

```ocaml
# let integral s = let rec loop i = if i = 0 then 0 else (s i-1) + loop (i-1) in loop;;
val integral : (int -> int) -> int -> int = <fun>
# let sqs' = integral (derivative sqs);; 
val sqs' : int -> int = <fun>
# [ sqs' 0; sqs' 1; sqs' 2; sqs' 3; sqs' 4 ];;
- : int list = [0; 2; 6; 12; 20]
```

カワンネ。。。あっ

```ocaml
# let integral s = let rec loop i = if i = 0 then 0 else s (i-1) + loop (i-1) in loop;;
val integral : (int -> int) -> int -> int = <fun>
# let sqs' = integral (derivative sqs);;
val sqs' : int -> int = <fun>
# [ sqs' 0; sqs' 1; sqs' 2; sqs' 3; sqs' 4 ];;
- : int list = [0; 1; 4; 9; 16]
```

二項演算はかなり結合がよわい。

## 4章

パターンマッチに一章割かれてる。使い慣れておきたい感。

## Exercise 4.1

### 3

```ocaml
- : string = "abcdef"
# let _ as s = "abc" in s ^ "def";;
- : string = "abcdef"
```
letはパターンがそのまま書ける

### 4

```ocaml
# (fun (1 | 2) as i -> i + 1) 2;;
Characters 13-15:
  (fun (1 | 2) as i -> i + 1) 2;;
               ^^
Error: Syntax error: operator expected.
# (fun ((1 | 2) as i) -> i + 1) 2;;
Characters 0-29:
  (fun ((1 | 2) as i) -> i + 1) 2;;
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Warning 8: this pattern-matching is not exhaustive.
Here is an example of a value that is not matched:
0
- : int = 3
```

ここにはカッコが必要です、と。複数の引数に対してそれぞれパターンを書くかもだから、かな？

## Exercise 4.2

> パターンマッチの記法で条件分と本体の区切りに「-&gt;」を使うの、「渡された関数を引数と本体でバラしてマッチさせるようなのはありえない」のをうまく使ってる感がある
> &mdash; たこさんズ（かい） (@plaster) [2015, 11月 15](https://twitter.com/plaster/status/665727852923322369)

こういうことを考えてたそばから、いい感じの問題！

> Why do you think the OCaml designers left out function matching?

関数の同一性、たしか「完全に等価」は判定不能だから、だと思う。
むりやりやろうとするとあまり意味のない同一性になってしまう。

## Exercise 4.3

部品づくりからやることにする。

```ocaml
# let index s c = let rec loop i = if i = String.length s then raise (Invalid_argument "index") else if c = s.[i] then i else loop (i + 1) in loop 0;;
val index : string -> char -> int = <fun>
# index "ABC" 'B';;
- : int = 1
# index "ABC" 'C';;
- : int = 2
# index "ABC" 'X';;
Exception: Invalid_argument "index".
```

```ocaml
# let lookup table1 table2 c = table2.[index table1 c];;
val lookup : string -> string -> char -> char = <fun>
# lookup "ABCD" "CADB" 'B';;
- : char = 'A'
# lookup "ABCD" "CADB" 'A';;
- : char = 'C'
# lookup "ABCD" "CADB" 'D';;
- : char = 'B'
```

文字列のmapがほしいので

```ocaml
# let stringmap charmap s =
    let result = String.create (String.length s) in
    let rec loop i =
      if i = String.length s
      then result
      else (                                         
        result.[i] <- charmap s.[i];
        loop (i+1)
      ) in
    loop 0
  ;;
Characters 41-54:
    let result = String.create (String.length s) in
                 ^^^^^^^^^^^^^
Warning 3: deprecated: String.create
Use Bytes.create instead.
Characters 155-182:
        result.[i] <- charmap s.[i];
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^
Warning 3: deprecated: String.set
Use Bytes.set instead.
val stringmap : (char -> char) -> string -> bytes = <fun>
```

```ocaml
# stringmap ( lookup "ABCD" "CADB" ) "BAD";;
- : bytes = "ACB"
```

相変わらず警告されまくりだけどとりあえずうごいた。
警告にしたがって直してみる。bytesとstringは同一視していいみたい。（マルチバイト文字どうなるんだ。。。？）

```ocaml
# let stringmap charmap s =
    let result = Bytes.create (Bytes.length s) in
    let rec loop i =
      if i = Bytes.length s
      then result
      else (
        Bytes.set result i (charmap s.[i]);
        loop (i+1)
      ) in
    loop 0
  ;;
val stringmap : (char -> char) -> bytes -> bytes = <fun>
# stringmap ( lookup "ABCD" "CADB" ) "BAD";;
- : bytes = "ACB"
```

さて部品がそろった。

```ocaml
# let gencheck encrypt plaintext cyphertext = cyphertext = encrypt plaintext;;
val gencheck : ('a -> 'b) -> 'a -> 'b -> bool = <fun>
```

あとは定数たべさせるだけ

```ocaml
# let check = gencheck (stringmap (lookup "ABCD" "CADB"));;
val check : bytes -> bytes -> bool = <fun>
```

うごいてる。いいかんじ。

```ocaml
# check "BAD" "ACB";;
- : bool = true
# check "BOO" "ACB";;
Exception: Invalid_argument "index".
# check "BAD" "A";;
- : bool = false
# check "CAD" "DCB";;
- : bool = true
# check "CAD" "BAD";;
- : bool = false
```

換字表がおっきくなっても引数かえるだけ。

長くなってきたのでそろそろページきりかえる。

[次へ](05introductiontoobjectivecaml-2.md)

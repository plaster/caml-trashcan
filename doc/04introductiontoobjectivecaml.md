# 今北産業

* js_of_ocaml であそぶために opamいれて環境をどうにかととのえたけれど
* わたしOCamlしらないじゃんってことに今更気づき（ISでの演習はどうした！）
* [教科書になりそうなPDF](https://www.google.co.jp/search?q=Introduction+to+Objective+Caml)ながめることにした

# 読んでみる

最初の方はざーっと読み飛ばす。Exerciseがちゃんとついてるのでそこだけさくさく解いていこう。

## Exercise 2.1

きになったもの

### 9
```
# if false then ();;
- : unit = ()
```

`else`が省略できる。その場合、式の値は利用できない。型がunitになる。

### 11
```
# true || (1 / 0 >= 0);;
- : bool = true
```

短絡評価。

### 14
```
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
```
# String.lowercase "A" < "B";;
- : bool = false
```

文字列の大小比較がふつうに `<` でできるようだ。


## Exercise 3.1

### 9
```
# let x x = x + 1 in x 2;;
- : int = 3
```

わかる

### 10
```
# let rec x x = x + x in x 2;;
- : int = 4
```

！！？？？ ナンデ？？？型が明らかにちがうから混同しない、的な？？？

```
# let rec f x = if x < 1 then 1 else x * f (x - 1) in f 10;;
- : int = 3628800
```

```
# let rec x x = if x < 1 then 1 else x * x (x - 1) in x 10;;
Characters 39-40:
  let rec x x = if x < 1 then 1 else x * x (x - 1) in x 10;;
                                         ^
Error: This expression has type int
       This is not a function; it cannot be applied.
```

なるほどー、引数の束縛でshadowingされて本体関数は見えません、と。

### 15
```
# let (++) x = x + 1 in ++x;
  ^CInterrupted.
```

~~んー？なんだこれ。xは未束縛じゃないの？~~
セミコロンたりんかっただけだった。
```
# let (++) x = x + 1 in ++x;;
Characters 22-24:
  let (++) x = x + 1 in ++x;;
                        ^^
Error: Syntax error
```

単項演算子にはならないようだ。二項演算子として使うこと自体はできる（ただし型エラー。第二引数を食べようとするけど、第一引数を食べた時点でもう関数じゃなくなっちゃってるので）
```
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

```
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

```
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

```
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

```
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

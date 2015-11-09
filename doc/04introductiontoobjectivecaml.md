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

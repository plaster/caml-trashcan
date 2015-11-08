# 今北産業

* js_of_ocaml であそぶために opamいれて環境をどうにかととのえたけれど
* わたしOCamlしらないじゃんってことに今更気づき（ISでの演習はどうした！）
* [教科書になりそうなPDF](https://www.google.co.jp/search?q=Introduction+to+Objective+Caml)ながめることにした

最初の方はざーっと読み飛ばす。Exerciseがちゃんとついてるのでそこだけさくさく解いていこう。

## Exercise 2.1

きになったもの

```
if false then ()
```

`else`が省略できる。その場合、式の値は利用できない。型がunitになる。

```
# true || (1 / 0 >= 0);;
- : bool = true
```

短絡評価。

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

```
# String.lowercase "A" < "B";;
- : bool = false
```

文字列の大小比較がふつうに `<` でできるようだ。

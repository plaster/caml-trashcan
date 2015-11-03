# つぎやること

* じぶんのコードで`js_of_ocaml`する
  * DOMいじりたい

# ここまでのまとめ

* opamつよい
* `opam install js_of_ocaml.2.5`
  * 最新2.6をビルドするには`base64`を1.0.0から2.0.0に上げる必要がありそうなんだけど
    * それやるとほかのパッケージがいくつか消えたりバージョンさがったりする。
    * なにより `js_of_ocaml.2.6` を入れようとすると `base64` が1.0.0に下げられてしまう。。。
      * そんなときには `opam pin add base64 2.0.0`
      * これで無事 `opam install js_of_ocaml.2.6` できたよ〜
* `js_of_ocaml` で実際JS吐いてみた
  * cubes.ml

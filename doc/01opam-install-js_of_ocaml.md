ここまでのあらすじ：[js_of_ocaml あそびはじめたいので opam でいろいろといれてみた](00start.md)。

opamいれるまえにaptitudeでjs_of_ocamlいれてたんだけど、この際opamで入れてみることにした。。。
ら、なんと失敗した！

```
[ plaster@ropecat:~ ]
% opam install js_of_ocaml
The following actions will be performed:
  ∗  install   cppo        1.3.1              [required by js_of_ocaml]
  ∗  install   cmdliner    0.9.8              [required by js_of_ocaml]
  ∗  install   base64      1.0.0              [required by js_of_ocaml]
  ∗  install   camlp4      4.02+6             [required by js_of_ocaml]
  ∗  install   menhir      20151030           [required by js_of_ocaml]
  ↻  recompile lwt         2.5.0              [uses camlp4]
  ∗  install   js_of_ocaml 2.6     
===== ∗  6   ↻  1 =====
Do you want to continue ? [Y/n] y

=-=- Gathering sources =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
[default] https://opam.ocaml.org/archives/base64.1.0.0+opam.tar.gz downloaded
[default] https://opam.ocaml.org/archives/cmdliner.0.9.8+opam.tar.gz downloaded
[default] https://opam.ocaml.org/archives/cppo.1.3.1+opam.tar.gz downloaded
[lwt] Archive in cache
[default] https://opam.ocaml.org/archives/camlp4.4.02+6+opam.tar.gz downloaded
[default] https://opam.ocaml.org/archives/js_of_ocaml.2.6+opam.tar.gz downloaded
[default] https://opam.ocaml.org/archives/menhir.20151030+opam.tar.gz downloaded

=-=- Processing actions -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
⊘  removed   lwt.2.5.0
∗  installed cmdliner.0.9.8
∗  installed cppo.1.3.1
∗  installed base64.1.0.0
∗  installed menhir.20151030
∗  installed camlp4.4.02+6
∗  installed lwt.2.5.0
[ERROR] The compilation of js_of_ocaml failed at "make build".
Processing  8/8: [js_of_ocaml: ocamlfind remove]
#=== ERROR while installing js_of_ocaml.2.6 ===================================#
# opam-version 1.2.2
# os           linux
# command      make build
# path         /home/plaster/.opam/4.02.1/build/js_of_ocaml.2.6
# compiler     4.02.1
# exit-code    2
# env-file     /home/plaster/.opam/4.02.1/build/js_of_ocaml.2.6/js_of_ocaml-28355-be72be.env
# stdout-file  /home/plaster/.opam/4.02.1/build/js_of_ocaml.2.6/js_of_ocaml-28355-be72be.out
# stderr-file  /home/plaster/.opam/4.02.1/build/js_of_ocaml.2.6/js_of_ocaml-28355-be72be.err
### stdout ###
# [...]
# ocamlfind ocamlopt -w +A-4-7-9-37-38-41-44-45 -I +compiler-libs -safe-string -package cmdliner -package base64 -package findlib -for-pack Compiler -g -c javascript.ml
# ocamlfind ocamlc     -w +A-4-7-9-37-38-41-44-45 -I +compiler-libs -safe-string -package cmdliner -package base64 -package findlib -c json.mli
# ocamlfind ocamlopt -w +A-4-7-9-37-38-41-44-45 -I +compiler-libs -safe-string -package cmdliner -package base64 -package findlib -for-pack Compiler -g -c json.ml
# ocamlfind ocamlc     -w +A-4-7-9-37-38-41-44-45 -I +compiler-libs -safe-string -package cmdliner -package base64 -package findlib -c vlq64.mli
# ocamlfind ocamlopt -w +A-4-7-9-37-38-41-44-45 -I +compiler-libs -safe-string -package cmdliner -package base64 -package findlib -for-pack Compiler -g -c vlq64.ml
# ocamlfind ocamlc     -w +A-4-7-9-37-38-41-44-45 -I +compiler-libs -safe-string -package cmdliner -package base64 -package findlib -c source_map.mli
# ocamlfind ocamlopt -w +A-4-7-9-37-38-41-44-45 -I +compiler-libs -safe-string -package cmdliner -package base64 -package findlib -for-pack Compiler -g -c source_map.ml
# ocamlfind ocamlc     -w +A-4-7-9-37-38-41-44-45 -I +compiler-libs -safe-string -package cmdliner -package base64 -package findlib -c js_output.mli
# ocamlfind ocamlopt -w +A-4-7-9-37-38-41-44-45 -I +compiler-libs -safe-string -package cmdliner -package base64 -package findlib -for-pack Compiler -g -c js_output.ml
# make[1]: ディレクトリ `/home/plaster/.opam/4.02.1/build/js_of_ocaml.2.6/compiler' から出ます
### stderr ###
# [...]
# findlib: [WARNING] Interface topdirs.cmi occurs in several directories: /home/plaster/.opam/4.02.1/lib/ocaml, /home/plaster/.opam/4.02.1/lib/ocaml/compiler-libs
# findlib: [WARNING] Interface topdirs.cmi occurs in several directories: /home/plaster/.opam/4.02.1/lib/ocaml, /home/plaster/.opam/4.02.1/lib/ocaml/compiler-libs
# findlib: [WARNING] Interface topdirs.cmi occurs in several directories: /home/plaster/.opam/4.02.1/lib/ocaml, /home/plaster/.opam/4.02.1/lib/ocaml/compiler-libs
# findlib: [WARNING] Interface topdirs.cmi occurs in several directories: /home/plaster/.opam/4.02.1/lib/ocaml, /home/plaster/.opam/4.02.1/lib/ocaml/compiler-libs
# findlib: [WARNING] Interface topdirs.cmi occurs in several directories: /home/plaster/.opam/4.02.1/lib/ocaml, /home/plaster/.opam/4.02.1/lib/ocaml/compiler-libs
# findlib: [WARNING] Interface topdirs.cmi occurs in several directories: /home/plaster/.opam/4.02.1/lib/ocaml, /home/plaster/.opam/4.02.1/lib/ocaml/compiler-libs
# File "js_output.ml", line 1079, characters 43-53:
# Error: Unbound module B64
# make[1]: *** [js_output.cmx] エラー 2
# make: *** [compiler] エラー 2



=-=- Error report -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
The following actions failed
  ∗  install js_of_ocaml 2.6
The following changes have been performed
  ∗  install base64   1.0.0   
  ∗  install camlp4   4.02+6  
  ∗  install cmdliner 0.9.8   
  ∗  install cppo     1.3.1   
  ∗  install menhir   20151030

The former state can be restored with:
    opam switch import "~/.opam/4.02.1/backup/state-20151001151034.export"
```
* aptitudeでいれたやつを消して opamだけでやることにする。
```
[ plaster@ropecat:~ ]
% sudo aptitude remove ocaml
[sudo] password for plaster: 
Sorry, try again.
[sudo] password for plaster: 
以下のパッケージが削除されます:          
  ocaml ocaml-base{u} 
更新: 0 個、新規インストール: 0 個、削除: 2 個、保留: 47 個。
0  バイトのアーカイブを取得する必要があります。展開後に 9,153 k バイトのディスク領域が解放されます。
先に進みますか? [Y/n/?] 
```
```
[ plaster@ropecat:~ ]
% sudo aptitude remove js-of-ocaml
以下のパッケージが削除されます:          
  camlp4{u} js-of-ocaml ledit{u} libderiving-ocsigen-ocaml{u} libderiving-ocsigen-ocaml-dev{u} libev-dev{u} libev4{u} libfindlib-ocaml{u} libfindlib-ocaml-dev{u} libjs-of-ocaml{u} 
  libjs-of-ocaml-dev{u} liblwt-ocaml{u} liblwt-ocaml-dev{u} liblwt-ocaml-doc{u} libncurses5-dev{u} libpcre-ocaml{u} libpcre-ocaml-dev{u} libpcre3-dev{u} libpcrecpp0{u} 
  libreact-ocaml{u} libreact-ocaml-dev{u} libtext-ocaml{u} libtext-ocaml-dev{u} libtinfo-dev{u} libtype-conv-camlp4-dev{u} ocaml-base-nox{u} ocaml-findlib{u} ocaml-interp{u} 
  ocaml-nox{u} 
更新: 0 個、新規インストール: 0 個、削除: 29 個、保留: 47 個。
0  バイトのアーカイブを取得する必要があります。展開後に 122 M バイトのディスク領域が解放されます。
先に進みますか? [Y/n/?] 
```
* しかし opam install js_of_ocaml は相変わらずエラー。<code>eval \`opam config env\` </code>してからやりなおしてもやっぱりエラー。
* ocamlのバージョンを疑うが、[4.02.1でjs_of_ocamlビルドしてる人がいるっぽい](http://www.recoil.org/~avsm/opam-bulk/logs/local-debian-stable-ocaml-4.02.1/raw/js_of_ocaml.html)ので直接問題ないっぽい
* あっでもまって。これ成功してるひと2.5だけど、手元のopamがいれようとしてるの2.6だ。新しいocamlが必要なのかも！
* 粛々と opam switch 4.02.3
```
[ plaster@ropecat:~ ]
% opam switch 4.02.3

=-=- Installing compiler 4.02.3 -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
[default.comp] http://caml.inria.fr/pub/distrib/ocaml-4.02/ocaml-4.02.3.tar.gz downloaded
Now compiling OCaml. This may take a while, please bear with us...
Done.

=-=- Gathering sources =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

=-=- Processing actions -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
∗  installed base-bigarray.base
∗  installed base-threads.base
∗  installed base-unix.base
Done.
# To setup the new switch in the current shell, you need to run:
eval `opam config env`
[ plaster@ropecat:~ ]
% eval `opam config env`
```
* そして opam install js_of_ocaml するのだ。今回これだけでやってみる。。。が、ならず。。。！
```
[ plaster@ropecat:~ ]
% opam install js_of_ocaml
The following actions will be performed:
  ∗  install cmdliner    0.9.8                [required by js_of_ocaml]
  ∗  install ocamlfind   1.5.6                [required by js_of_ocaml]
  ∗  install ppx_tools   0.99.3               [required by js_of_ocaml]
  ∗  install menhir      20151030             [required by js_of_ocaml]
  ∗  install cppo        1.3.1                [required by js_of_ocaml]
  ∗  install camlp4      4.02+6               [required by js_of_ocaml]
  ∗  install base64      1.0.0                [required by js_of_ocaml]
  ∗  install lwt         2.5.0                [required by js_of_ocaml]
  ∗  install js_of_ocaml 2.6     
===== ∗  9 =====
Do you want to continue ? [Y/n] y

=-=- Gathering sources =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
[base64] Archive in cache
[camlp4] Archive in cache
[cmdliner] Archive in cache
[cppo] Archive in cache
[js_of_ocaml] Archive in cache
[lwt] Archive in cache
[menhir] Archive in cache
[ocamlfind] Archive in cache
[ppx_tools] Archive in cache

=-=- Processing actions -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
∗  installed cmdliner.0.9.8
∗  installed ocamlfind.1.5.6
∗  installed cppo.1.3.1
∗  installed base64.1.0.0
∗  installed ppx_tools.0.99.3
∗  installed menhir.20151030
∗  installed camlp4.4.02+6
∗  installed lwt.2.5.0
[ERROR] The compilation of js_of_ocaml failed at "make build".
Processing  9/9: [js_of_ocaml: ocamlfind remove]
```
えーと、エラーは同じっすね
```
#=== ERROR while installing js_of_ocaml.2.6 ===================================#
# opam-version 1.2.2
# os           linux
# command      make build
# path         /home/plaster/.opam/4.02.3/build/js_of_ocaml.2.6
# compiler     4.02.3
# exit-code    2
# env-file     /home/plaster/.opam/4.02.3/build/js_of_ocaml.2.6/js_of_ocaml-11270-af57d6.env
# stdout-file  /home/plaster/.opam/4.02.3/build/js_of_ocaml.2.6/js_of_ocaml-11270-af57d6.out
# stderr-file  /home/plaster/.opam/4.02.3/build/js_of_ocaml.2.6/js_of_ocaml-11270-af57d6.err
### stdout ###
# [...]
# ocamlfind ocamlopt -w +A-4-7-9-37-38-41-44-45 -I +compiler-libs -safe-string -package cmdliner -package base64 -package findlib -for-pack Compiler -g -c javascript.ml
# ocamlfind ocamlc     -w +A-4-7-9-37-38-41-44-45 -I +compiler-libs -safe-string -package cmdliner -package base64 -package findlib -c json.mli
# ocamlfind ocamlopt -w +A-4-7-9-37-38-41-44-45 -I +compiler-libs -safe-string -package cmdliner -package base64 -package findlib -for-pack Compiler -g -c json.ml
# ocamlfind ocamlc     -w +A-4-7-9-37-38-41-44-45 -I +compiler-libs -safe-string -package cmdliner -package base64 -package findlib -c vlq64.mli
# ocamlfind ocamlopt -w +A-4-7-9-37-38-41-44-45 -I +compiler-libs -safe-string -package cmdliner -package base64 -package findlib -for-pack Compiler -g -c vlq64.ml
# ocamlfind ocamlc     -w +A-4-7-9-37-38-41-44-45 -I +compiler-libs -safe-string -package cmdliner -package base64 -package findlib -c source_map.mli
# ocamlfind ocamlopt -w +A-4-7-9-37-38-41-44-45 -I +compiler-libs -safe-string -package cmdliner -package base64 -package findlib -for-pack Compiler -g -c source_map.ml
# ocamlfind ocamlc     -w +A-4-7-9-37-38-41-44-45 -I +compiler-libs -safe-string -package cmdliner -package base64 -package findlib -c js_output.mli
# ocamlfind ocamlopt -w +A-4-7-9-37-38-41-44-45 -I +compiler-libs -safe-string -package cmdliner -package base64 -package findlib -for-pack Compiler -g -c js_output.ml
# make[1]: ディレクトリ `/home/plaster/.opam/4.02.3/build/js_of_ocaml.2.6/compiler' から出ます
### stderr ###
# [...]
# findlib: [WARNING] Interface topdirs.cmi occurs in several directories: /home/plaster/.opam/4.02.3/lib/ocaml, /home/plaster/.opam/4.02.3/lib/ocaml/compiler-libs
# findlib: [WARNING] Interface topdirs.cmi occurs in several directories: /home/plaster/.opam/4.02.3/lib/ocaml, /home/plaster/.opam/4.02.3/lib/ocaml/compiler-libs
# findlib: [WARNING] Interface topdirs.cmi occurs in several directories: /home/plaster/.opam/4.02.3/lib/ocaml, /home/plaster/.opam/4.02.3/lib/ocaml/compiler-libs
# findlib: [WARNING] Interface topdirs.cmi occurs in several directories: /home/plaster/.opam/4.02.3/lib/ocaml, /home/plaster/.opam/4.02.3/lib/ocaml/compiler-libs
# findlib: [WARNING] Interface topdirs.cmi occurs in several directories: /home/plaster/.opam/4.02.3/lib/ocaml, /home/plaster/.opam/4.02.3/lib/ocaml/compiler-libs
# findlib: [WARNING] Interface topdirs.cmi occurs in several directories: /home/plaster/.opam/4.02.3/lib/ocaml, /home/plaster/.opam/4.02.3/lib/ocaml/compiler-libs
# File "js_output.ml", line 1079, characters 43-53:
# Error: Unbound module B64
# make[1]: *** [js_output.cmx] エラー 2
# make: *** [compiler] エラー 2



=-=- Error report -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
The following actions failed
  ∗  install js_of_ocaml 2.6
The following changes have been performed
  ∗  install base64    1.0.0   
  ∗  install camlp4    4.02+6  
  ∗  install cmdliner  0.9.8   
  ∗  install cppo      1.3.1   
  ∗  install lwt       2.5.0   
  ∗  install menhir    20151030
  ∗  install ocamlfind 1.5.6   
  ∗  install ppx_tools 0.99.3  

The former state can be restored with:
    opam switch import "~/.opam/4.02.3/backup/state-20151001154527.export"
```
2.6のソースこわれてるんじゃね？みんな2.5でやってるみたいだし2.5でいってみよう。
バージョン指定しての方法は。。。`opam install js_of_ocaml.2.5`とかかな？
```
[ plaster@ropecat:~ ]
% opam install js_of_ocaml.2.5
The following actions will be performed:
  ∗  install js_of_ocaml 2.5

=-=- Gathering sources =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
[default] https://opam.ocaml.org/archives/js_of_ocaml.2.5+opam.tar.gz downloaded

=-=- Processing actions -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
∗  installed js_of_ocaml.2.5
Done.
```
いけた！
4.02.1側もなおす。
```
[ plaster@ropecat:~ ]
% opam switch 4.02.1     
# To setup the new switch in the current shell, you need to run:
eval `opam config env`
[ plaster@ropecat:~ ]
% eval `opam config env`
[ plaster@ropecat:~ ]
% opam install js_of_ocaml.2.5
The following actions will be performed:
  ∗  install js_of_ocaml 2.5

=-=- Gathering sources =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
[js_of_ocaml] Archive in cache

=-=- Processing actions -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
∗  installed js_of_ocaml.2.5
Done.
```


原因どうもこれっぽい。
https://github.com/mirage/ocaml-base64/commit/ed444d33e98f5fac921bfb01c36f25753963c287
あたらしいbase64が必要なのにopamが入れるbase64が古いせいでコケてる感じ。

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
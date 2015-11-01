* 目的 js_of_ocaml で遊べるようにする
* みてる
 * http://d.hatena.ne.jp/camlspotter/20111015/1318664763
 * http://no-maddojp.hatenablog.com/entry/2013/12/26/232400
* opamいれた
* opam init
 * 記録とりわすれたけど、<code>.zshrc</code>いじるけどいいか？ってきかれた。
  * いいよってこたえた。最初nにしちゃったけど思い直してもっかいopam initしてyにした。
   * opamでなにかやったらさいご必ずこれを
    ```
    % eval `opam config env`
    ```
* opam switch 4.02.1
  ```
  [ plaster@ropecat:~ ]
  % opam switch 4.02.1
  
  =-=- Installing compiler 4.02.1 -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  [default.comp] http://caml.inria.fr/pub/distrib/ocaml-4.02/ocaml-4.02.1.tar.gz downloaded
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
* opam install lwt
  ```
  % opam install lwt    
  The following actions will be performed:
    ∗  install ocamlfind 1.5.6                  [required by lwt]
    ∗  install ppx_tools 0.99.3                 [required by lwt]
    ∗  install lwt       2.5.0 
  ===== ∗  3 =====
  Do you want to continue ? [Y/n] y
  
  =-=- Gathering sources =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  [default] https://opam.ocaml.org/archives/ppx_tools.0.99.3+opam.tar.gz downloaded
  [default] https://opam.ocaml.org/archives/ocamlfind.1.5.6+opam.tar.gz downloaded
  [default] https://opam.ocaml.org/archives/lwt.2.5.0+opam.tar.gz downloaded
  
  =-=- Processing actions -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  ∗  installed ocamlfind.1.5.6
  ∗  installed ppx_tools.0.99.3
  ∗  installed lwt.2.5.0
  Done.
  ```
 * Findlib入れるべしとあるのだけれど、ocamlfindが入ってくれたからこれでよかったりしないかな？
   * http://projects.camlcity.org/projects/findlib.html

     > There is also a tool (ocamlfind) for interpreting the META files, so that it is very easy to use libraries in programs and scripts.

* js_of_ocaml は aptitude install js-of-ocaml で入れた、、、いれてしまった
  * opamでやりなおすべき？
    * [次](01opam-install-js_of_ocaml.md) へ

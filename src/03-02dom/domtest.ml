(* http://d.hatena.ne.jp/camlspotter/20111015/1318664763 *)

open Js
open Dom_html

let _ = Dom.ELEMENT

let _ = Unsafe.eval_string "
alert('hello, world!');
"

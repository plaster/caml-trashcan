(* http://d.hatena.ne.jp/camlspotter/20111015/1318664763 *)

open Js

let _ = Unsafe.eval_string "
alert('hello, world!');
"

open Js_of_ocaml
open Quasar_core.Util
open Jest
module J = Quasar_js

let arr str = Js.Unsafe.js_expr str

let empty_array () =
  test "Create an empty array" (fun () ->
      let expected : 'a J.Array.t = arr "[]" in
      let input = J.Array.empty () in
      (expect input).%{to_strict_equal} <- expected)
;;

let init1 () =
  test "Create an array using init" (fun () ->
      let expected : int J.Array.t = arr "[0, 1, 2, 3, 4, 5]" in
      let input = J.Array.init 6 (fun x -> x) in
      (expect input).%{to_strict_equal} <- expected)
;;

let suite () = List.iter (fun t -> t ()) [ empty_array; init1 ]

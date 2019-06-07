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
  test "Create an array using init - 1" (fun () ->
      let expected : int J.Array.t = arr "[0, 1, 2, 3, 4, 5]" in
      let input = J.Array.init 6 id in
      (expect input).%{to_strict_equal} <- expected)
;;

let init2 () =
  test "Create an array using init - 2" (fun () ->
      let expected : int J.Array.t = arr "[]" in
      let input = J.Array.init 0 id in
      (expect input).%{to_strict_equal} <- expected)
;;

let prefilled1 () =
  test "Create an array using prefilled - 1" (fun () ->
      let expected : int J.Array.t = arr "[]" in
      let input = J.Array.prefilled 0 7 in
      (expect input).%{to_strict_equal} <- expected)
;;

let prefilled2 () =
  test "Create an array using prefilled - 2" (fun () ->
      let expected : int J.Array.t = arr "[7, 7, 7, 7, 7]" in
      let input = J.Array.prefilled 5 7 in
      (expect input).%{to_strict_equal} <- expected)
;;

let from_array1 () =
  test "Create an array from an OCaml array - 1" (fun () ->
      let expected : int J.Array.t = arr "[]" in
      let input = J.Array.from_array id [||] in
      (expect input).%{to_strict_equal} <- expected)
;;

let from_array2 () =
  test "Create an array from an OCaml array - 2" (fun () ->
      let expected : int J.Array.t = arr "[1, 2, 3, 4, 5]" in
      let input = J.Array.from_array id [| 1; 2; 3; 4; 5 |] in
      (expect input).%{to_strict_equal} <- expected)
;;

let from_array3 () =
  test "Create an array from an OCaml array - 3" (fun () ->
      let expected : Js.js_string Js.t J.Array.t =
        arr "['1', '2', '3', '4', '5']"
      in
      let input =
        J.Array.from_array
          (fun x -> string_of_int x |> Js.string)
          [| 1; 2; 3; 4; 5 |]
      in
      (expect input).%{to_strict_equal} <- expected)
;;

let from_list1 () =
  test "Create an array from an OCaml list - 1" (fun () ->
      let expected : int J.Array.t = arr "[]" in
      let input = J.Array.from_list id [] in
      (expect input).%{to_strict_equal} <- expected)
;;

let from_list2 () =
  test "Create an array from an OCaml list - 2" (fun () ->
      let expected : int J.Array.t = arr "[1, 2, 3, 4, 5]" in
      let input = J.Array.from_list id [ 1; 2; 3; 4; 5 ] in
      (expect input).%{to_strict_equal} <- expected)
;;

let from_list3 () =
  test "Create an array from an OCaml list - 3" (fun () ->
      let expected : Js.js_string Js.t J.Array.t =
        arr "['1', '2', '3', '4', '5']"
      in
      let input =
        J.Array.from_list
          (fun x -> string_of_int x |> Js.string)
          [ 1; 2; 3; 4; 5 ]
      in
      (expect input).%{to_strict_equal} <- expected)
;;

let length1 () =
  test "Test the length of an array - 1" (fun () ->
      let array = J.Array.empty () in
      let input = J.Array.length array in
      (expect input).%{to_be} <- 0)
;;

let length2 () =
  test "Test the length of an array - 2" (fun () ->
      let array = J.Array.from_list id [ 1; 2; 3 ] in
      let input = J.Array.length array in
      (expect input).%{to_be} <- 3)
;;

let get1 () =
  test "Test get - 1" (fun () ->
      let array = J.Array.empty () in
      let input = J.Array.get array 2 |> Js.Opt.option in
      (expect input).%{to_be_null})
;;

let get2 () =
  test "Test get - 2" (fun () ->
      let array = J.Array.from_list id [ 1; 2; 3 ] in
      let input = J.Array.get array 2 |> Js.Opt.option in
      (expect input).%{to_be} <- (Js.Opt.return 3))
;;

let suite () =
  List.iter
    (fun t -> t ())
    [ empty_array
    ; init1
    ; init2
    ; prefilled1
    ; prefilled2
    ; from_array1
    ; from_array2
    ; from_array3
    ; from_list1
    ; from_list2
    ; from_list3
    ; length1
    ; length2
    ; get1
    ; get2
    ]
;;

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

let set1 () =
  test "Test set - 1" (fun () ->
      let expected : int J.Array.t = arr "[10]" in
      let input = J.Array.empty () in
      let () = J.Array.set input 0 10 in
      (expect input).%{to_strict_equal} <- expected)
;;

let set2 () =
  test "Test set - 2" (fun () ->
      let expected : int J.Array.t = arr "[1, 2, 10, 4, 5]" in
      let input = J.Array.init 5 (fun x -> x + 1) in
      let () = J.Array.set input 2 10 in
      (expect input).%{to_strict_equal} <- expected)
;;

let fill1 () =
  test "Test for Array filling - 1" (fun () ->
      let expected : int J.Array.t = arr "[]" in
      let input = J.Array.(fill $ empty () $ 10) in
      (expect input).%{to_strict_equal} <- expected)
;;

let fill2 () =
  test "Test for Array filling - 2" (fun () ->
      let expected : int J.Array.t = arr "[10, 10, 10]" in
      let input = J.Array.(fill $ init 3 id $ 10) in
      (expect input).%{to_strict_equal} <- expected)
;;

let fill_from1 () =
  test
    "Test for Array filling (from a specific index) - 1"
    (fun () ->
      let expected : int J.Array.t = arr "[]" in
      let input = J.Array.(fill_from $ init 0 id $ 2 $ 10) in
      (expect input).%{to_strict_equal} <- expected)
;;

let fill_from2 () =
  test
    "Test for Array filling (from a specific index) - 2"
    (fun () ->
      let expected : int J.Array.t = arr "[10, 10, 10]" in
      let input = J.Array.(fill_from $ init 3 id $ 0 $ 10) in
      (expect input).%{to_strict_equal} <- expected)
;;

let fill_from3 () =
  test
    "Test for Array filling (from a specific index) - 3"
    (fun () ->
      let expected : int J.Array.t = arr "[0, 1, 10, 10]" in
      let input = J.Array.(fill_from $ init 4 id $ 2 $ 10) in
      (expect input).%{to_strict_equal} <- expected)
;;

let fill_between1 () =
  test "Test for Array filling (between two indexes) - 1" (fun () ->
      let expected : int J.Array.t = arr "[]" in
      let input = J.Array.(fill_between (init 0 id) 0 10 10) in
      (expect input).%{to_strict_equal} <- expected)
;;

let fill_between2 () =
  test "Test for Array filling (between two indexes) - 2" (fun () ->
      let expected : int J.Array.t = arr "[0, 1, 10, 10, 4]" in
      let input = J.Array.(fill_between (init 5 id) 2 3 10) in
      (expect input).%{to_strict_equal} <- expected)
;;

let fill_between3 () =
  test "Test for Array filling (between two indexes) - 3" (fun () ->
      let expected : Js.js_string Js.t J.Array.t =
        arr "['foo', 'foo', 'foo', 'foo', 'foo']"
      in
      let input =
        J.Array.(
          fill_between
            (init 5 (fun x -> string_of_int x |> Js.string))
            0
            200
            (Js.string "foo"))
      in
      (expect input).%{to_strict_equal} <- expected)
;;

let push1 () =
  test "Test for push - 1" (fun () ->
      let expected_array : int J.Array.t = arr "[10]" in
      let expected_length = 1 in
      let array = J.Array.empty () in
      let () = (expect array).%{to_strict_equal} <- (arr "[]") in
      let length = J.Array.push array 10 in
      let () = (expect length).%{to_be} <- expected_length in
      (expect array).%{to_strict_equal} <- expected_array)
;;

let push2 () =
  test "Test for push - 2" (fun () ->
      let expected_array : int J.Array.t =
        arr "[0, 1, 2, 3, 4, 10]"
      in
      let expected_length = 6 in
      let array = J.Array.init 5 id in
      let () =
        (expect array).%{to_strict_equal} <- (arr "[0, 1, 2, 3, 4]")
      in
      let length = J.Array.push array 10 in
      let () = (expect length).%{to_be} <- expected_length in
      (expect array).%{to_strict_equal} <- expected_array)
;;

let pop1 () =
  test "Test for pop - 1" (fun () ->
      let array = J.Array.empty () in
      let result = J.Array.pop array |> Js.Opt.option in
      (expect result).%{to_be_null})
;;

let pop2 () =
  test "Test for pop - 2" (fun () ->
      let expected_array = arr "[0, 1, 2, 3]" in
      let array = J.Array.init 5 id in
      let result = J.Array.pop array |> Js.Opt.option in
      let length = J.Array.length array in
      let () = (expect result).%{to_be} <- (Js.Opt.return 4) in
      let () = (expect array).%{to_strict_equal} <- expected_array in
      (expect length).%{to_be} <- 4)
;;

let shift1 () =
  test "Test for shift - 1" (fun () ->
      let array = J.Array.empty () in
      let result = J.Array.shift array |> Js.Opt.option in
      (expect result).%{to_be_null})
;;

let shift2 () =
  test "Test for shift - 2" (fun () ->
      let expected_array = arr "[1, 2, 3, 4]" in
      let array = J.Array.init 5 id in
      let result = J.Array.shift array |> Js.Opt.option in
      let length = J.Array.length array in
      let () = (expect result).%{to_be} <- (Js.Opt.return 0) in
      let () = (expect array).%{to_strict_equal} <- expected_array in
      (expect length).%{to_be} <- 4)
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
    ; set1
    ; set2
    ; fill1
    ; fill2
    ; fill_from1
    ; fill_from2
    ; fill_from3
    ; fill_between1
    ; fill_between2
    ; fill_between3
    ; push1
    ; push2
    ; pop1
    ; pop2
    ; shift1
    ; shift2
    ]
;;

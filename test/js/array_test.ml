open Js_of_ocaml
open Quasar_core.Util
open Jest
module A = Quasar_js.Array

let ( ?! ) x = expect x

let () =
  test "Create an empty ?ay" (fun () ->
      let expected : 'a A.t = js "[]" in
      let input = A.empty () in
      input == expected)
;;

let () =
  test "Create an array using init - 1" (fun () ->
      let expected : int A.t = js "[0, 1, 2, 3, 4, 5]" in
      let input = A.init 6 id in
      input == expected)
;;

let () =
  test "Create an array using init - 2" (fun () ->
      let expected : int A.t = js "[]" in
      let input = A.init 0 id in
      input == expected)
;;

let () =
  test "Create an array using make - 1" (fun () ->
      let expected : int A.t = js "[]" in
      let input = A.make 0 7 in
      input == expected)
;;

let () =
  test "Create an array using make - 2" (fun () ->
      let expected : int A.t = js "[7, 7, 7, 7, 7]" in
      let input = A.make 5 7 in
      input == expected)
;;

let () =
  test "Create an array from an OCaml array - 1" (fun () ->
      let expected : int A.t = js "[]" in
      let input = A.from_array id [||] in
      input == expected)
;;

let () =
  test "Create an array from an OCaml array - 2" (fun () ->
      let expected : int A.t = js "[1, 2, 3, 4, 5]" in
      let input = A.from_array id [| 1; 2; 3; 4; 5 |] in
      input == expected)
;;

let () =
  test "Create an array from an OCaml array - 3" (fun () ->
      let expected : Js.js_string Js.t A.t =
        js "['1', '2', '3', '4', '5']"
      in
      let input =
        A.from_array
          (fun x -> string_of_int x |> Js.string)
          [| 1; 2; 3; 4; 5 |]
      in
      input == expected)
;;

let () =
  test "Create an array from an OCaml list - 1" (fun () ->
      let expected : int A.t = js "[]" in
      let input = A.from_list id [] in
      input == expected)
;;

let () =
  test "Create an array from an OCaml list - 2" (fun () ->
      let expected : int A.t = js "[1, 2, 3, 4, 5]" in
      let input = A.from_list id [ 1; 2; 3; 4; 5 ] in
      input == expected)
;;

let () =
  test "Create an array from an OCaml list - 3" (fun () ->
      let expected : Js.js_string Js.t A.t =
        js "['1', '2', '3', '4', '5']"
      in
      let input =
        A.from_list
          (fun x -> string_of_int x |> Js.string)
          [ 1; 2; 3; 4; 5 ]
      in
      input == expected)
;;

let () =
  test "Test the length of an array - 1" (fun () ->
      let array = A.empty () in
      let input = A.length array in
      input = 0)
;;

let () =
  test "Test the length of an array - 2" (fun () ->
      let array = A.from_list id [ 1; 2; 3 ] in
      let input = A.length array in
      input = 3)
;;

let () =
  test "Test get - 1" (fun () ->
      let array = A.empty () in
      let input = A.get array 2 |> Js.Opt.option in
      ?!input.%{to_be_null})
;;

let () =
  test "Test get - 2" (fun () ->
      let array = A.from_list id [ 1; 2; 3 ] in
      let input = A.get array 2 |> Js.Opt.option in
      input = Js.Opt.return 3)
;;

let () =
  test "Test set - 1" (fun () ->
      let expected : int A.t = js "[10]" in
      let input = A.empty () in
      let () = A.set input 0 10 in
      input == expected)
;;

let () =
  test "Test set - 2" (fun () ->
      let expected : int A.t = js "[1, 2, 10, 4, 5]" in
      let input = A.init 5 (fun x -> x + 1) in
      let () = A.set input 2 10 in
      input == expected)
;;

let () =
  test "Test for Array filling - 1" (fun () ->
      let expected : int A.t = js "[]" in
      let input = A.(fill $ empty () $ 10) in
      input == expected)
;;

let () =
  test "Test for Array filling - 2" (fun () ->
      let expected : int A.t = js "[10, 10, 10]" in
      let input = A.(fill $ init 3 id $ 10) in
      input == expected)
;;

let () =
  test
    "Test for Array filling (from a specific index) - 1"
    (fun () ->
      let expected : int A.t = js "[]" in
      let input = A.(fill_from $ init 0 id $ 2 $ 10) in
      input == expected)
;;

let () =
  test
    "Test for Array filling (from a specific index) - 2"
    (fun () ->
      let expected : int A.t = js "[10, 10, 10]" in
      let input = A.(fill_from $ init 3 id $ 0 $ 10) in
      input == expected)
;;

let () =
  test
    "Test for Array filling (from a specific index) - 3"
    (fun () ->
      let expected : int A.t = js "[0, 1, 10, 10]" in
      let input = A.(fill_from $ init 4 id $ 2 $ 10) in
      input == expected)
;;

let () =
  test "Test for Array filling (between two indexes) - 1" (fun () ->
      let expected : int A.t = js "[]" in
      let input = A.(fill_between (init 0 id) 0 10 10) in
      input == expected)
;;

let () =
  test "Test for Array filling (between two indexes) - 2" (fun () ->
      let expected : int A.t = js "[0, 1, 10, 10, 4]" in
      let input = A.(fill_between (init 5 id) 2 3 10) in
      input == expected)
;;

let () =
  test "Test for Array filling (between two indexes) - 3" (fun () ->
      let expected : Js.js_string Js.t A.t =
        js "['foo', 'foo', 'foo', 'foo', 'foo']"
      in
      let input =
        A.(
          fill_between
            (init 5 (fun x -> string_of_int x |> Js.string))
            0
            200
            (Js.string "foo"))
      in
      input == expected)
;;

let () =
  test "Test for push - 1" (fun () ->
      let expected_array : int A.t = js "[10]" in
      let expected_length = 1 in
      let array = A.empty () in
      let () = array == js "[]" in
      let length = A.push array 10 in
      let () = length = expected_length in
      array == expected_array)
;;

let () =
  test "Test for push - 2" (fun () ->
      let expected_array : int A.t = js "[0, 1, 2, 3, 4, 10]" in
      let expected_length = 6 in
      let array = A.init 5 id in
      let () = array == js "[0, 1, 2, 3, 4]" in
      let length = A.push array 10 in
      let () = length = expected_length in
      array == expected_array)
;;

let () =
  test "Test for pop - 1" (fun () ->
      let array = A.empty () in
      let result = A.pop array |> Js.Opt.option in
      ?!result.%{to_be_null})
;;

let () =
  test "Test for pop - 2" (fun () ->
      let expected_array = js "[0, 1, 2, 3]" in
      let array = A.init 5 id in
      let result = A.pop array |> Js.Opt.option in
      let length = A.length array in
      let () = result = Js.Opt.return 4 in
      let () = array == expected_array in
      length = 4)
;;

let () =
  test "Test for shift - 1" (fun () ->
      let array = A.empty () in
      let result = A.shift array |> Js.Opt.option in
      ?!result.%{to_be_null})
;;

let () =
  test "Test for shift - 2" (fun () ->
      let expected_array = js "[1, 2, 3, 4]" in
      let array = A.init 5 id in
      let result = A.shift array |> Js.Opt.option in
      let length = A.length array in
      let () = result = Js.Opt.return 0 in
      let () = array == expected_array in
      length = 4)
;;

let () =
  test "Test for append" (fun () ->
      let expected_a = js "[0, 1, 2, 3, 4]" in
      let expected_b = js "[100, 101, 102, 103, 104, 105]" in
      let a = A.init 5 id in
      let b = A.init 6 (fun x -> x + 100) in
      let c = A.empty () in
      let () = A.append a c == expected_a in
      let () = A.append c b == expected_b in
      A.append a b
      == js "[0, 1, 2, 3, 4, 100, 101, 102, 103, 104, 105]")
;;

let () =
  test "Test for flatten" (fun () ->
      let empty = js "[]" in
      [ []; []; []; [] ]
      |> A.from_list (A.from_list id)
      |> A.flatten == empty;
      [ [ 1; 2; 3; 4 ]; []; [ 5; 6; 7; 8 ]; []; [ 9; 10; 11; 12 ] ]
      |> A.from_list (A.from_list id)
      |> A.flatten
      == js "[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]")
;;

let () =
  test "Test for to_array" (fun () ->
      A.to_array id $ js "[1, 2, 3, 4]" == [| 1; 2; 3; 4 |];
      A.to_array id $ js "[]" == [||];
      A.to_array (fun x -> x * 2)
      $ js "[1, 2, 3, 4]" == [| 2; 4; 6; 8 |])
;;

let () =
  test "Test for to_list" (fun () ->
      A.to_list id $ js "[1, 2, 3, 4]" == [ 1; 2; 3; 4 ];
      A.to_list id $ js "[]" == [];
      A.to_list (fun x -> x * 2) $ js "[1, 2, 3, 4]" == [ 2; 4; 6; 8 ]
  )
;;

let () =
  test "Test for map" (fun () ->
      A.map id $ A.empty () == js "[]";
      A.map id $ A.from_list id [ 1; 2; 3; 4 ] == js "[1, 2, 3, 4]";
      A.map succ $ A.from_list id [ 1; 2; 3; 4 ] == js "[2, 3, 4, 5]";
      A.map (fun x -> x, x)
      $ A.from_list id [ 1; 2; 3; 4 ]
      == A.from_list id [ 1, 1; 2, 2; 3, 3; 4, 4 ])
;;

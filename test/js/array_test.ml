open Js_of_ocaml
open Quasar_core.Util
open Jest
module A = Quasar_js.Array

let arr str = Js.Unsafe.js_expr str
let ( ?! ) x = expect x

let empty_array () =
  test "Create an empty array" (fun () ->
      let expected : 'a A.t = arr "[]" in
      let input = A.empty () in
      ?!input.%{to_strict_equal} <- expected)
;;

let init1 () =
  test "Create an array using init - 1" (fun () ->
      let expected : int A.t = arr "[0, 1, 2, 3, 4, 5]" in
      let input = A.init 6 id in
      ?!input.%{to_strict_equal} <- expected)
;;

let init2 () =
  test "Create an array using init - 2" (fun () ->
      let expected : int A.t = arr "[]" in
      let input = A.init 0 id in
      ?!input.%{to_strict_equal} <- expected)
;;

let make1 () =
  test "Create an array using make - 1" (fun () ->
      let expected : int A.t = arr "[]" in
      let input = A.make 0 7 in
      ?!input.%{to_strict_equal} <- expected)
;;

let make2 () =
  test "Create an array using make - 2" (fun () ->
      let expected : int A.t = arr "[7, 7, 7, 7, 7]" in
      let input = A.make 5 7 in
      ?!input.%{to_strict_equal} <- expected)
;;

let from_array1 () =
  test "Create an array from an OCaml array - 1" (fun () ->
      let expected : int A.t = arr "[]" in
      let input = A.from_array id [||] in
      ?!input.%{to_strict_equal} <- expected)
;;

let from_array2 () =
  test "Create an array from an OCaml array - 2" (fun () ->
      let expected : int A.t = arr "[1, 2, 3, 4, 5]" in
      let input = A.from_array id [| 1; 2; 3; 4; 5 |] in
      ?!input.%{to_strict_equal} <- expected)
;;

let from_array3 () =
  test "Create an array from an OCaml array - 3" (fun () ->
      let expected : Js.js_string Js.t A.t =
        arr "['1', '2', '3', '4', '5']"
      in
      let input =
        A.from_array
          (fun x -> string_of_int x |> Js.string)
          [| 1; 2; 3; 4; 5 |]
      in
      ?!input.%{to_strict_equal} <- expected)
;;

let from_list1 () =
  test "Create an array from an OCaml list - 1" (fun () ->
      let expected : int A.t = arr "[]" in
      let input = A.from_list id [] in
      ?!input.%{to_strict_equal} <- expected)
;;

let from_list2 () =
  test "Create an array from an OCaml list - 2" (fun () ->
      let expected : int A.t = arr "[1, 2, 3, 4, 5]" in
      let input = A.from_list id [ 1; 2; 3; 4; 5 ] in
      ?!input.%{to_strict_equal} <- expected)
;;

let from_list3 () =
  test "Create an array from an OCaml list - 3" (fun () ->
      let expected : Js.js_string Js.t A.t =
        arr "['1', '2', '3', '4', '5']"
      in
      let input =
        A.from_list
          (fun x -> string_of_int x |> Js.string)
          [ 1; 2; 3; 4; 5 ]
      in
      ?!input.%{to_strict_equal} <- expected)
;;

let length1 () =
  test "Test the length of an array - 1" (fun () ->
      let array = A.empty () in
      let input = A.length array in
      ?!input.%{to_be} <- 0)
;;

let length2 () =
  test "Test the length of an array - 2" (fun () ->
      let array = A.from_list id [ 1; 2; 3 ] in
      let input = A.length array in
      ?!input.%{to_be} <- 3)
;;

let get1 () =
  test "Test get - 1" (fun () ->
      let array = A.empty () in
      let input = A.get array 2 |> Js.Opt.option in
      ?!input.%{to_be_null})
;;

let get2 () =
  test "Test get - 2" (fun () ->
      let array = A.from_list id [ 1; 2; 3 ] in
      let input = A.get array 2 |> Js.Opt.option in
      ?!input.%{to_be} <- (Js.Opt.return 3))
;;

let set1 () =
  test "Test set - 1" (fun () ->
      let expected : int A.t = arr "[10]" in
      let input = A.empty () in
      let () = A.set input 0 10 in
      ?!input.%{to_strict_equal} <- expected)
;;

let set2 () =
  test "Test set - 2" (fun () ->
      let expected : int A.t = arr "[1, 2, 10, 4, 5]" in
      let input = A.init 5 (fun x -> x + 1) in
      let () = A.set input 2 10 in
      ?!input.%{to_strict_equal} <- expected)
;;

let fill1 () =
  test "Test for Array filling - 1" (fun () ->
      let expected : int A.t = arr "[]" in
      let input = A.(fill $ empty () $ 10) in
      ?!input.%{to_strict_equal} <- expected)
;;

let fill2 () =
  test "Test for Array filling - 2" (fun () ->
      let expected : int A.t = arr "[10, 10, 10]" in
      let input = A.(fill $ init 3 id $ 10) in
      ?!input.%{to_strict_equal} <- expected)
;;

let fill_from1 () =
  test
    "Test for Array filling (from a specific index) - 1"
    (fun () ->
      let expected : int A.t = arr "[]" in
      let input = A.(fill_from $ init 0 id $ 2 $ 10) in
      ?!input.%{to_strict_equal} <- expected)
;;

let fill_from2 () =
  test
    "Test for Array filling (from a specific index) - 2"
    (fun () ->
      let expected : int A.t = arr "[10, 10, 10]" in
      let input = A.(fill_from $ init 3 id $ 0 $ 10) in
      ?!input.%{to_strict_equal} <- expected)
;;

let fill_from3 () =
  test
    "Test for Array filling (from a specific index) - 3"
    (fun () ->
      let expected : int A.t = arr "[0, 1, 10, 10]" in
      let input = A.(fill_from $ init 4 id $ 2 $ 10) in
      ?!input.%{to_strict_equal} <- expected)
;;

let fill_between1 () =
  test "Test for Array filling (between two indexes) - 1" (fun () ->
      let expected : int A.t = arr "[]" in
      let input = A.(fill_between (init 0 id) 0 10 10) in
      ?!input.%{to_strict_equal} <- expected)
;;

let fill_between2 () =
  test "Test for Array filling (between two indexes) - 2" (fun () ->
      let expected : int A.t = arr "[0, 1, 10, 10, 4]" in
      let input = A.(fill_between (init 5 id) 2 3 10) in
      ?!input.%{to_strict_equal} <- expected)
;;

let fill_between3 () =
  test "Test for Array filling (between two indexes) - 3" (fun () ->
      let expected : Js.js_string Js.t A.t =
        arr "['foo', 'foo', 'foo', 'foo', 'foo']"
      in
      let input =
        A.(
          fill_between
            (init 5 (fun x -> string_of_int x |> Js.string))
            0
            200
            (Js.string "foo"))
      in
      ?!input.%{to_strict_equal} <- expected)
;;

let push1 () =
  test "Test for push - 1" (fun () ->
      let expected_array : int A.t = arr "[10]" in
      let expected_length = 1 in
      let array = A.empty () in
      let () = ?!array.%{to_strict_equal} <- (arr "[]") in
      let length = A.push array 10 in
      let () = ?!length.%{to_be} <- expected_length in
      ?!array.%{to_strict_equal} <- expected_array)
;;

let push2 () =
  test "Test for push - 2" (fun () ->
      let expected_array : int A.t = arr "[0, 1, 2, 3, 4, 10]" in
      let expected_length = 6 in
      let array = A.init 5 id in
      let () =
        ?!array.%{to_strict_equal} <- (arr "[0, 1, 2, 3, 4]")
      in
      let length = A.push array 10 in
      let () = ?!length.%{to_be} <- expected_length in
      ?!array.%{to_strict_equal} <- expected_array)
;;

let pop1 () =
  test "Test for pop - 1" (fun () ->
      let array = A.empty () in
      let result = A.pop array |> Js.Opt.option in
      ?!result.%{to_be_null})
;;

let pop2 () =
  test "Test for pop - 2" (fun () ->
      let expected_array = arr "[0, 1, 2, 3]" in
      let array = A.init 5 id in
      let result = A.pop array |> Js.Opt.option in
      let length = A.length array in
      let () = ?!result.%{to_be} <- (Js.Opt.return 4) in
      let () = ?!array.%{to_strict_equal} <- expected_array in
      ?!length.%{to_be} <- 4)
;;

let shift1 () =
  test "Test for shift - 1" (fun () ->
      let array = A.empty () in
      let result = A.shift array |> Js.Opt.option in
      ?!result.%{to_be_null})
;;

let shift2 () =
  test "Test for shift - 2" (fun () ->
      let expected_array = arr "[1, 2, 3, 4]" in
      let array = A.init 5 id in
      let result = A.shift array |> Js.Opt.option in
      let length = A.length array in
      let () = ?!result.%{to_be} <- (Js.Opt.return 0) in
      let () = ?!array.%{to_strict_equal} <- expected_array in
      ?!length.%{to_be} <- 4)
;;

let append () =
  test "Test for append" (fun () ->
      let expected_a = arr "[0, 1, 2, 3, 4]" in
      let expected_b = arr "[100, 101, 102, 103, 104, 105]" in
      let a = A.init 5 id in
      let b = A.init 6 (fun x -> x + 100) in
      let c = A.empty () in
      let () = ?!(A.append a c).%{to_strict_equal} <- expected_a in
      let () = ?!(A.append c b).%{to_strict_equal} <- expected_b in
      ?!(A.append a b).%{to_strict_equal}
      <- (arr "[0, 1, 2, 3, 4, 100, 101, 102, 103, 104, 105]"))
;;

let flatten () =
  test "Test for flatten" (fun () ->
      let empty = arr "[]" in
      ?!([ []; []; []; [] ]
        |> A.from_list (A.from_list id)
        |> A.flatten).%{to_strict_equal} <- empty;
      (expect
         ([ [ 1; 2; 3; 4 ];
            [];
            [ 5; 6; 7; 8 ];
            [];
            [ 9; 10; 11; 12 ]
          ]
         |> A.from_list (A.from_list id)
         |> A.flatten)).%{to_strict_equal}
      <- (arr "[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]"))
;;

let to_array () =
  test "Test for to_array" (fun () ->
      ?!(A.to_array id $ arr "[1, 2, 3, 4]").%{to_strict_equal}
      <- [| 1; 2; 3; 4 |];
      ?!(A.to_array id $ arr "[]").%{to_strict_equal} <- [||];
      ?!(A.to_array (fun x -> x * 2) $ arr "[1, 2, 3, 4]").%{to_strict_equal}
      <- [| 2; 4; 6; 8 |])
;;

let to_list () =
  test "Test for to_list" (fun () ->
      ?!(A.to_list id $ arr "[1, 2, 3, 4]").%{to_strict_equal}
      <- [ 1; 2; 3; 4 ];
      ?!(A.to_list id $ arr "[]").%{to_strict_equal} <- [];
      ?!(A.to_list (fun x -> x * 2) $ arr "[1, 2, 3, 4]").%{to_strict_equal}
      <- [ 2; 4; 6; 8 ])
;;

let map () =
  test "Test for map" (fun () ->
      ?!(A.map id $ A.empty ()).%{to_strict_equal} <- (arr "[]");
      ?!(A.map id $ A.from_list id [ 1; 2; 3; 4 ]).%{to_strict_equal}
      <- (arr "[1, 2, 3, 4]");
      ?!(A.map succ $ A.from_list id [ 1; 2; 3; 4 ]).%{to_strict_equal}
      <- (arr "[2, 3, 4, 5]");
      ?!(A.map (fun x -> x, x) $ A.from_list id [ 1; 2; 3; 4 ]).%{to_strict_equal}
      <- (A.from_list id [ 1, 1; 2, 2; 3, 3; 4, 4 ]))
;;

let suite () =
  List.iter
    (fun t -> t ())
    [ empty_array;
      init1;
      init2;
      make1;
      make2;
      from_array1;
      from_array2;
      from_array3;
      from_list1;
      from_list2;
      from_list3;
      length1;
      length2;
      get1;
      get2;
      set1;
      set2;
      fill1;
      fill2;
      fill_from1;
      fill_from2;
      fill_from3;
      fill_between1;
      fill_between2;
      fill_between3;
      push1;
      push2;
      pop1;
      pop2;
      shift1;
      shift2;
      append;
      flatten;
      to_array;
      to_list;
      map
    ]
;;

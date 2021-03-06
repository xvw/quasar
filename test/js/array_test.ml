open Js_of_ocaml
open Quasar_js.Util
open Jest
module A = Quasar_js.Array

let mk list = A.from_list id list

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
      let input = mk [] in
      input == expected)
;;

let () =
  test "Create an array from an OCaml list - 2" (fun () ->
      let expected : int A.t = js "[1, 2, 3, 4, 5]" in
      let input = mk [ 1; 2; 3; 4; 5 ] in
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
      let array = mk [ 1; 2; 3 ] in
      let input = A.length array in
      input = 3)
;;

let () =
  test "Test get - 1" (fun () ->
      let array = A.empty () in
      let input = A.get array 2 |> Js.Opt.option in
      (expect input).%{to_be_null})
;;

let () =
  test "Test get - 2" (fun () ->
      let array = mk [ 1; 2; 3 ] in
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
      let input = A.(fill (empty ()) 10) in
      input == expected)
;;

let () =
  test "Test for Array filling - 2" (fun () ->
      let expected : int A.t = js "[10, 10, 10]" in
      let input = A.(fill (init 3 id) 10) in
      input == expected)
;;

let () =
  test
    "Test for Array filling (from a specific index) - 1"
    (fun () ->
      let expected : int A.t = js "[]" in
      let input = A.(fill_from (init 0 id) 2 10) in
      input == expected)
;;

let () =
  test
    "Test for Array filling (from a specific index) - 2"
    (fun () ->
      let expected : int A.t = js "[10, 10, 10]" in
      let input = A.(fill_from (init 3 id) 0 10) in
      input == expected)
;;

let () =
  test
    "Test for Array filling (from a specific index) - 3"
    (fun () ->
      let expected : int A.t = js "[0, 1, 10, 10]" in
      let input = A.(fill_from (init 4 id) 2 10) in
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
      (expect result).%{to_be_null})
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
      (expect result).%{to_be_null})
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
      A.to_array id (js "[1, 2, 3, 4]") == [| 1; 2; 3; 4 |];
      A.to_array id (js "[]") == [||];
      A.to_array (fun x -> x * 2) (js "[1, 2, 3, 4]")
      == [| 2; 4; 6; 8 |])
;;

let () =
  test "Test for to_list" (fun () ->
      A.to_list id (js "[1, 2, 3, 4]") == [ 1; 2; 3; 4 ];
      A.to_list id (js "[]") == [];
      A.to_list (fun x -> x * 2) (js "[1, 2, 3, 4]") == [ 2; 4; 6; 8 ]
  )
;;

let () =
  test "Test for map" (fun () ->
      A.map id (A.empty ()) == js "[]";
      A.map id (mk [ 1; 2; 3; 4 ]) == js "[1, 2, 3, 4]";
      A.map succ (mk [ 1; 2; 3; 4 ]) == js "[2, 3, 4, 5]";
      A.map (fun x -> x, x) (mk [ 1; 2; 3; 4 ])
      == mk [ 1, 1; 2, 2; 3, 3; 4, 4 ])
;;

let () =
  test "Test for mapi" (fun () ->
      A.mapi (fun _ x -> x) (A.empty ()) == js "[]";
      A.mapi (fun i x -> mk [ i; x ]) (mk [ 1; 2; 3; 4 ])
      == js "[[0, 1], [1, 2], [2, 3], [3, 4]]")
;;

let () =
  test "Test for fold_left" (fun () ->
      A.fold_left ( + ) 123 (A.empty ()) = 123;
      A.fold_left ( + ) 0 (mk [ 1; 2; 3; 4 ]) = 10;
      A.fold_left (fun acc x -> x :: acc) [] (mk [ 1; 2; 3; 4 ])
      |> mk == js "[4, 3, 2, 1]")
;;

let () =
  test "Test for fold_right" (fun () ->
      A.fold_right ( + ) (A.empty ()) 123 = 123;
      A.fold_right ( + ) (mk [ 1; 2; 3; 4 ]) 0 = 10;
      A.fold_right (fun x acc -> x :: acc) (mk [ 1; 2; 3; 4 ]) []
      |> mk == js "[1, 2, 3, 4]")
;;

let () =
  test "Test for for_all" (fun () ->
      let a = A.for_all (fun x -> x > 10) (A.empty ()) |> Js.bool in
      let () = (expect a).%{to_be_truthy} in
      let b =
        A.for_all (fun x -> x > 10) (mk [ 11; 12; 178; 17 ])
        |> Js.bool
      in
      let () = (expect b).%{to_be_truthy} in
      let c =
        A.for_all (fun x -> x > 10) (mk [ 11; 12; 5; 17 ]) |> Js.bool
      in
      (expect c).%{to_be_falsy})
;;

let () =
  test "Test for exists" (fun () ->
      let a = A.exists (fun x -> x > 10) (A.empty ()) |> Js.bool in
      let () = (expect a).%{to_be_falsy} in
      let b =
        A.exists (fun x -> x > 10) (mk [ 1; 12; 0; -7 ]) |> Js.bool
      in
      let () = (expect b).%{to_be_truthy} in
      let c =
        A.exists (fun x -> x > 10) (mk [ 1; 2; 0; -7 ]) |> Js.bool
      in
      (expect c).%{to_be_falsy})
;;

let () =
  test "Test for sort" (fun () ->
      A.sort compare (A.empty ()) == A.empty ();
      A.sort compare (mk [ 2; 1; 8; 9; 11; -7; 43 ])
      == mk [ -7; 1; 2; 8; 9; 11; 43 ])
;;

let () =
  test "Test for filter" (fun () ->
      A.filter (fun _ -> true) (A.empty ()) == A.empty ();
      A.filter (fun _ -> false) (A.empty ()) == A.empty ();
      A.filter (fun x ->  Stdlib.(x mod 2 = 0)) (mk [1; 2; 3; 4; 5; 6])
      == mk [2; 4; 6]
    )

let () =
  test "Test for filteri" (fun () ->
      A.filteri (fun _ _ -> true) (A.empty ()) == A.empty ();
      A.filteri (fun _ _ -> false) (A.empty ()) == A.empty ();
      A.filteri (fun x _ ->  Stdlib.(x mod 2 = 0)) (mk [1; 2; 3; 4; 5; 6])
      == mk [1; 3; 5]
    )
    
let () = todo "Test for iter"
let () = todo "Test for iteri"

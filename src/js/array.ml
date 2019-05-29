open Js_of_ocaml
open Quasar_core.Util

type 'a t = 'a Js.js_array Js.t

let unbound_index unavailable_index =
  unavailable_index
  |> Format.asprintf "Unbound index %d"
  |> Error.make
;;

let empty () = new%js Js.array_empty

let prefilled size default =
  let array = new%js Js.array_length size in
  Js.array_map (fun _ -> default) array
;;

let from_array f array =
  let js_array = empty () in
  let () =
    Stdlib.Array.iteri
      (fun i elt -> Js.array_set js_array i $ f elt)
      array
  in
  js_array
;;

let from_list f list =
  let js_array = empty () in
  let () =
    Stdlib.List.iteri
      (fun i elt -> Js.array_set js_array i $ f elt)
      list
  in
  js_array
;;

let to_array f js_array =
  let size = js_array##.length in
  Stdlib.Array.init size (fun i ->
      let elt = Js.array_get js_array i in
      Js.Optdef.get elt (fun () -> Error.raise $ unbound_index i)
      |> f)
;;

let to_list f js_array =
  let size = js_array##.length in
  Stdlib.List.init size (fun i ->
      let elt = Js.array_get js_array i in
      Js.Optdef.get elt (fun () -> Error.raise $ unbound_index i)
      |> f)
;;

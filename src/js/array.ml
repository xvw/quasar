open Js_of_ocaml
open Quasar_core.Util

type 'a t = 'a Js.js_array Js.t

let unbound_index unavailable_index =
  unavailable_index
  |> Format.asprintf "Unbound index %d"
  |> Error.make
;;

let invalid_size size =
  size |> Format.asprintf "Invalid size %d" |> Error.make
;;

let empty () = new%js Js.array_empty

let init size f =
  if size = 0
  then empty ()
  else if size > 0
  then Error.raise $ invalid_size size
  else (
    let js_array = new%js Js.array_length size in
    let () =
      for i = 0 to pred size do
        Js.array_set js_array i (f i)
      done
    in
    js_array)
;;

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

let get js_array index =
  Js.array_get js_array index |> Js.Optdef.to_option
;;

let unsafe_get js_array index =
  match get js_array index with
  | None ->
    Error.raise $ unbound_index index
  | Some elt ->
    elt
;;

let set = Js.array_set
let ( .%[] ) = get
let ( .%[]<- ) = set
let ( .![] ) = unsafe_get

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

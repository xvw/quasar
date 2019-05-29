open Js_of_ocaml

type t = Js.error Js.t

let make ?name message =
  let js_message = Js.string message in
  let error = new%js Js.error_constr js_message in
  let () =
    match name with
    | Some n ->
      error##.name := Js.string n
    | None ->
      ()
  in
  error
;;

let raise = Js.raise_js_error

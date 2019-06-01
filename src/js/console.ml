open Js_of_ocaml

class type hook =
  object
    inherit Firebug.console

    method clear : unit Js.meth

    method timeLog : 'a. Js.js_string Js.t -> 'a -> unit Js.meth

    method table :
      'a. 'a -> Js.js_string Js.t Js.js_array Js.t Js.Optdef.t
      -> unit Js.meth
  end

external get_console : unit -> hook Js.t = "caml_js_get_console"

let console = get_console ()
let log x = console##log x
let print x = x |> Js.string |> log
let clear () = console##clear
let error x = console##error x
let warning x = console##warn x
let time name = console##time (Js.string name)
let time_log name x = console##timeLog (Js.string name) x
let time_end name = console##timeEnd (Js.string name)

let timetrack timer_name actions =
  let name = Js.string timer_name in
  let () = console##time name in
  let () =
    List.iter (fun f -> f (fun x -> console##timeLog name x)) actions
  in
  console##timeEnd name
;;

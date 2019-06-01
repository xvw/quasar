open Js_of_ocaml

class type hook =
  object
    inherit Firebug.console

    method clear : unit Js.meth

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

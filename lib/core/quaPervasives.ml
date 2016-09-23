(*
 * Quasar
 *
 * Copyright (C) 2016  Xavier Van de Woestyne <xaviervdw@gmail.com>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
*)

(* String extension *)
module String =
struct
  
  include String
  let ocaml          = Js.to_string
  let js             = Js.string
  let of_json        = Yojson.Safe.to_string
  let of_unsafe_json = Yojson.to_string
      
end


(* Infix operators *)
let (>>=)        = Lwt.bind
let ( >> ) a b   = a >>= ( fun _ -> b)
    
let ( % )  f g x = f (g x)
let ( %> ) f g x = g (f x)
let ( $ )  f x   = f x

(* Common functions *)
let id   x       = x
let flip f x y   = f y x


(* Common JavaScript object *)
let document     = Dom_html.document
let window       = Dom_html.window
let console      = Firebug.console
let location     = window##.location
  

(* Helpers *)
let with_debugger () =
  try
    let f = Js.Unsafe.js_expr "$QUASAR_DEBUG" in
    f <> Js._false
    with _ -> false
 

(* Common JavaScript functions *)
let alert str    = window##alert(String.js str)
let log value    = console##log(value)
let (!!)         = Tyxml_js.To_dom.of_element

(* Error Management *)
module Error =
struct

  exception Runtime of string
  exception Unoptable

  let perform_failure message =
    if with_debugger () then begin
      alert message;
      log message
    end

  let fail message =
    let () = perform_failure message in
    raise (Runtime message)
    |> ignore

  let raise_ message =
    let () = perform_failure message in
    raise (Runtime message)

  let try_with f message =
    try ignore (f ()) with _ -> fail message

  let fail_unopt () =
    raise Unoptable
  
end

(* Stuff with Opt *)

let unopt x   = Js.Opt.get x Error.fail_unopt
let try_unopt = Js.Opt.to_option


(* Option management *)
module Option =
struct

  let safe f x =
    try Some (f x)
    with _ -> None

  let some x = Some x
  let none = None

  let is_some = function
    | Some _ -> true
    | None -> false

  let is_none = function
    | None -> true
    | Some _ -> false

  let default v = function
    | None -> v
    | Some x -> x

  let unit_map f = function
    | Some x -> f x
    | None -> ()

  let map f = function
    | None -> None
    | Some x -> Some (f x)

  let apply = function
    | None -> id
    | Some f -> f

end
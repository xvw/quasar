(*
 * Drumaderian
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
  let ocaml = Js.to_string
  let js    = Js.string
      
end


(* Infix operators *)
let (>>=)        = Lwt.bind
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

(* Common JavaScript functions *)
let alert str    = window##alert(String.js str)
let log value    = console##log(value)

(* Error Management *)
module Error =
struct

  exception Runtime of string

  (* Need to be rewritted using a $QUASARDEBUG *)
  let perform_failure message =
    alert message;
    log message

  let fail message =
    let () = perform_failure message in
    raise (Runtime message)
  
end



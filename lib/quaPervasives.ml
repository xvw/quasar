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

(* Common JavaScript object *)
let document     = Dom_html.document
let window       = Dom_html.window
let console      = Firebug.console
let location     = window##.location

(* Check if the application is in debug mode *)
let with_debugger () =
  try
    let f = Js.Unsafe.js_expr "$QUASAR_DEBUG" in
    f <> Js._false
  with _ -> false


(* printing function *)
let alert str = window##alert(Js.string str)
let log value = console##log(value)

(* Module for DOM manipulation  *)
module Tag =
struct

  let unopt_where f coersion elt acc =
    match Js.Opt.to_option elt with
    | None   -> acc
    | Some x ->
      Js.Opt.to_option (coersion x)
      |> function
      | None   -> acc
      | Some e ->
        if f e then e::acc else acc

  let all_elements_of ?(where=fun _ -> true) coersion parent =
    let nodes = parent##querySelectorAll(Js.string "a") in
    let len = nodes##.length in
    let rec aux acc i =
      if i = len then acc
      else aux
          (unopt_where where coersion (nodes##item(i)) acc)
          (succ i)
    in aux [] 0

  let all_elements ?(where = fun _ -> true) coersion =
    all_elements_of ~where coersion document

end

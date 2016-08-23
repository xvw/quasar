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

open QuaPervasives

type t = Dom_html.element Js.t


(* Retreive elements *)

let getById_opt idt =
  document##getElementById(String.js idt)
  |> try_unopt

let getById idt =
  document##getElementById(String.js idt)
  |> unopt
  
  
let find container selector =
  container##querySelector(String.js selector)
  |> unopt

let find_opt container selector =
  container##querySelector(String.js selector)
  |> try_unopt

let select container selector =
  container##querySelectorAll(String.js selector)
  |> Dom.list_of_nodeList

let find_all = select

let getByTag tag =
  document##getElementsByTagName (String.js tag)
  |> Dom.list_of_nodeList

let all () = getByTag "*"

(* Attributes *)

let raw_has_attribute element attribute =
  let str = String.js attribute in 
  ((element##hasAttribute(str)) == Js._true, str)

let has_attribute element attribute =
  fst (raw_has_attribute element attribute)
  

let get_attribute element attribute =
  let (check, str) = raw_has_attribute element attribute in
  if check then
    Some (
      element##getAttribute(str)
      |> unopt
      |> String.ocaml
    )
  else None
    

let set_attribute element attribute value =
  let attr = String.js attribute
  and svalue = String.js value in
  element##setAttribute attr svalue;
  element

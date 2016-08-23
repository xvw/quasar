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

let has_attribute attribute element =
  fst (raw_has_attribute element attribute)
  

let get_attribute attribute element =
  let (check, str) = raw_has_attribute element attribute in
  if check then
    Some (
      element##getAttribute(str)
      |> unopt
      |> String.ocaml
    )
  else None
    

let set_attribute attribute value element =
  let attr = String.js attribute
  and svalue = String.js value in
  element##setAttribute attr svalue;
  element

let remove_attribute attribute element =
  element##removeAttribute (String.js attribute);
  element

let has_data data    = has_attribute ("data-"^data)
let get_data data    = get_attribute ("data-"^data)
let set_data data    = set_attribute ("data-"^data)
let remove_data data = remove_attribute ("data-"^data)


let add_class klass element =
  element##.classList##add(String.js klass);
  element

let add_classes classes element =
  let f = fun x -> ignore (add_class x element) in
  List.iter f classes;
  element

let remove_class klass element =
  element##.classList##remove(String.js klass);
  element

let remove_classes classes element =
  let f = fun x -> ignore (remove_class x element) in
  List.iter f classes;
  element

let has_class klass element =
  let str = String.js klass in
  element##.classList##contains(str) = Js._true


let append parent elt =
  Dom.appendChild parent elt;
  parent

let prepend parent elt =
  Dom.insertBefore parent elt (parent##.firstChild);
  parent

let element = Tyxml_js.To_dom.of_element
let (!!) = element

let ( <+> ) = append
let ( <|> ) = prepend



    

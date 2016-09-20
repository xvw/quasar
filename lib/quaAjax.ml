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
open XmlHttpRequest

let request meth file sync response callback =
  let xhr    = create () in
  let onr () =
    match xhr##.readyState, xhr##.status with
    | DONE, 200 -> callback (response xhr)
    | _ -> ()
  in
  let _ = xhr##.onreadystatechange := (Js.wrap_callback onr) in
  let _ = xhr##_open
      (String.js meth)
      (String.js file)
      (if sync then Js._true else Js._false)
  in xhr##send(Js.null)

let _get f = request "GET" f true

let get_text file = _get file (fun x -> String.ocaml x##.responseText)
let get_xml  file = _get file (fun x -> try_unopt x##.responseXML) 


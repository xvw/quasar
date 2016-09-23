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

type 'response generic_http_frame = {
  url: string;
  code: int;
  headers: string -> string option;
  content: 'response;
  content_xml: unit -> Dom.element Dom.document Js.t option;
}

type result = http_frame


let get     = perform_raw_url ~override_method:`GET
let post    = perform_raw_url ~override_method:`POST
let head    = perform_raw_url ~override_method:`HEAD
let put     = perform_raw_url ~override_method:`PUT
let delete  = perform_raw_url ~override_method:`DELETE
let options = perform_raw_url ~override_method:`OPTIONS    
let patch   = perform_raw_url ~override_method:`PATCH


module Atomic =
struct

  let failure _ _ = Error.raise_ "failure of Ajax request"

  let request
      ?(error=failure)
      meth
      file
      sync
      response
      callback =
    let xhr    = create () in
    let onr () =
      match xhr##.readyState, xhr##.status with
      | DONE, code when code >= 200 && code <= 226 -> callback (response xhr)
      | (UNSENT | DONE) as t, code -> error t code
      | _ -> ()
    in
    let _ = xhr##.onreadystatechange := (Js.wrap_callback onr) in
    let _ = xhr##_open
        (String.js meth)
        (String.js file)
        (if sync then Js._true else Js._false)
    in xhr##send(Js.null)

  let _get  ?(error=failure) f = request ~error "GET"  f true
  let _post ?(error=failure) f = request ~error "POST" f true

  let txt s = String.ocaml s##.responseText



  let get_text ?(error=failure) file =
    _get ~error  file txt
  [@@ocaml.deprecated]

  let get_xml ?(error=failure) file =
    _get ~error  file (fun x -> try_unopt x##.responseXML)
  [@@ocaml.deprecated]

  let post ?(error=failure) file =
    _post ~error file txt
  [@@ocaml.deprecated]

end








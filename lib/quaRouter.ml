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


let start f =
  let open QuaEvent.Watcher in
  let _ = QuaEvent.watch_once onload  () (fun _ -> f ()) in
  let _ = QuaEvent.watch onhashchange () (fun _ -> f ()) in
  ()

let routes = QuaUrl.get_hash

let coersion_int = function
  | Some str -> begin
      try int_of_string str
      with _ -> Error.raise_ "Unable to coers string into int"
    end 
  | None -> Error.raise_ "Unable to coers string into int"
        

let coersion_float = function
  | Some str -> begin
      try float_of_string str
      with _ -> Error.raise_ "Unable to coers string into float"
    end
  | None -> Error.raise_ "Unable to coers string into float"
              
let coersion_bool = function
  | Some str -> str <> "false"
  | None -> Error.raise_ "Unable to coers string into bool"


let coersion_char = function
  | Some str ->
    if (String.length str) <> 1 then
      Error.raise_ "Unable to coers string into char"
    else str.[0]
  | None -> Error.raise_ "Unable to coers string into char"
    

let coersion_string = function
  | Some str -> str
  | None -> Error.raise_ "Unable to coers string into string"

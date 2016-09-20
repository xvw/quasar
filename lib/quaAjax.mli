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


(** Provide simple functions as helper *)
module Atomic :
sig
  
  val get_text :
    ?error:(XmlHttpRequest.readyState -> int -> unit)
    -> string
    -> (string -> unit)
    -> unit
    
  val get_xml :
    ?error:(XmlHttpRequest.readyState -> int -> unit)
    -> string
    -> (Dom.element Dom.document Js.t option -> unit)
    -> unit
    
  val post :
    ?error:(XmlHttpRequest.readyState -> int -> unit)
    -> string
    -> (string -> unit)
    -> unit

end




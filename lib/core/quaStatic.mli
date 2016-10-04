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

(** Tool for managing static assets *)

(** {2 Load external composants} *)

val add_stylesheet  : ?prepend:bool -> string -> unit
val add_css         : ?prepend:bool -> string -> unit
val add_script      : ?prepend:bool -> string -> unit
val add_js          : ?prepend:bool -> string -> unit

(** {2 PreSaved styles} *)
module Fx :
sig

  (** Use Css Special FX *)
  val use : unit -> unit
    

end 

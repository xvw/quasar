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

(** Start routing *)
val start : (unit -> 'a) -> unit

(** Get the current hash *)
val routes : unit -> string

(** Coersion for the routes arguments *)
  
val coersion_int    : string option -> int
val coersion_float  : string option -> float
val coersion_bool   : string option -> bool
val coersion_char   : string option -> char
val coersion_string : string option -> string
  
  

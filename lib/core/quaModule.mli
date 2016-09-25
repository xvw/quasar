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


(**
   This module offer an MV architecture for building 
   large application with structure
*)

(** {2 Interfaces} *)

(** M is the smallest module architecture*)
module type M =
sig

  type t
  val init   : t
  val update : t -> t
  val view   : t -> Dom_html.element Js.t
  val mount  : Dom_html.element Js.t

end

(** {2 General interfaces} *)
module type T =
sig

  include M
  val boot : unit -> unit

end

(** {2 Functors} *)

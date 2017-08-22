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

(** A Qexp is a king of Sexp to describe the main tokens of a Quasar file *)


(** The internal representation of a Qexp *)
type t =
  | Atom of string
  | Keyword of string
  | String of string
  | Integer of int
  | Float of float
  | Node of t list


(** {2 Create specifics nodes} *)
val node : t list -> t
val atom : string -> t
val keyword : string -> t
val string : string -> t
val integer : int -> t
val float : float -> t

(** {2 Parsers} *)

val of_string : string -> t
val of_stream : char Stream.t -> t

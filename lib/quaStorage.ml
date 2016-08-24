(*
 * Quasar
 *
 * Copyright (C) 2016  Xavier Van de Woestyne <xaviervdw@gmail.com>
 * Copyright (C) 2015  Pierre Ruyter <grimfw@gmail.com>
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

exception Not_allowed

(* Minimal storage interface *)
module type STORAGE_HANDLER =
sig
  val handler : Dom_html.storage Js.t Js.optdef
end

(* General API for storage *)
module type STORAGE =
sig
  val get : string -> string option
  val set : string -> string -> unit
  val remove : string -> unit
  val clear : unit -> unit
  val key : int -> string option
  val length : unit -> int
  val to_hashtbl : unit -> (string, string) Hashtbl.t
  val map : (string -> string -> string) -> unit
  val fold : ('a -> string -> string -> 'a) -> 'a -> 'a
  val filter : (string -> string -> bool) -> (string, string) Hashtbl.t
  val iter : (string -> string -> unit) -> unit
end

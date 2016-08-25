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

(** Function for webstorage manipulation *)

(** Raised if the Webstorages are not allowed *)
exception Not_allowed


(** {2 API for session storage (key value)} *)
module Session :
sig

  (** [Session.get key] retreive (in an option) the value at the [key] *)
  val get : string -> string option

  (** [Session.set key value] save [value] at [key] as a key  *)
  val set : string -> string -> unit

  (** [Session.remove key] remove the value at the [key] *)
  val remove : string -> unit

  (** [Session.clear ()] clear the storage *)
  val clear : unit -> unit

  (** Get a key with is position *)
  val key : int -> string option

  (** [Session.length ()] give the total of stored object *) 
  val length : unit -> int

  (** [Session.to_hashtbl ()] retreive all stored data as an Hashtbl *) 
  val to_hashtbl : unit -> (string, string) Hashtbl.t

  (** [Session.to_jstable ()] retreive all stored data as a jstable *)
  val to_jstable : unit -> (Js.js_string Js.t) Jstable.t

  (** [Session.map (fun key value -> ...))] map the function on each block *)
  val map : (string -> string -> string) -> unit

  (** [Session.fold (fun acc key value -> ...) default] fold on storage *)
  val fold : ('a -> string -> string -> 'a) -> 'a -> 'a

  (** [Session.filter (fun key value -> a_predicat)] filter using a predicate *)
  val filter : (string -> string -> bool) -> unit

  (** [Session.iter (fun key value -> ... )] apply f on each cell *)
  val iter : (string -> string -> unit) -> unit
    

end


(** {2 API for local storage (key value)} *)
module Local :
sig

  (** [Local.get key] retreive (in an option) the value at the [key] *)
  val get : string -> string option

  (** [Local.set key value] save [value] at [key] as a key  *)
  val set : string -> string -> unit

  (** [Local.remove key] remove the value at the [key] *)
  val remove : string -> unit

  (** [Local.clear ()] clear the storage *)
  val clear : unit -> unit

  (** Get a key with is position *)
  val key : int -> string option

  (** [Local.length ()] give the total of stored object *) 
  val length : unit -> int

  (** [Local.to_hashtbl ()] retreive all stored data as an Hashtbl *) 
  val to_hashtbl : unit -> (string, string) Hashtbl.t

  (** [Local.to_jstable ()] retreive all stored data as a jstable *)
  val to_jstable : unit -> (Js.js_string Js.t) Jstable.t

  (** [Local.map (fun key value -> ...))] map the function on each block *)
  val map : (string -> string -> string) -> unit

  (** [Local.fold (fun acc key value -> ...) default] fold on storage *)
  val fold : ('a -> string -> string -> 'a) -> 'a -> 'a

  (** [Local.filter (fun key value -> a_predicat)] filter using a predicate *)
  val filter : (string -> string -> bool) -> unit

  (** [Local.iter (fun key value -> ... )] apply f on each cell *)
  val iter : (string -> string -> unit) -> unit
    

end



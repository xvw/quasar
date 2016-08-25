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
  val to_jstable : unit -> (Js.js_string Js.t) Jstable.t
  val map : (string -> string -> string) -> unit
  val fold : ('a -> string -> string -> 'a) -> 'a -> 'a
  val filter : (string -> string -> bool) -> (string, string) Hashtbl.t
  val iter : (string -> string -> unit) -> unit
end


type raho =
    Null

(* Functor for building storage *)
module Make (S : STORAGE_HANDLER) =
struct

  let handler =
    Js.Optdef.case
      S.handler
      (fun () -> raise Not_allowed)
      id

  let wrap f k =
    try_unopt (f k)
    |> Option.map String.ocaml

  let js_get k = unopt (handler##getItem(k))
  let js_key i = unopt (handler##key(i))

  let length () = handler##.length
  let get = wrap (fun x -> handler##getItem(String.js x))
  let key = wrap (fun x -> handler##key(x))
  let set k v  = handler##setItem (String.js k) (String.js v)
  let remove k = handler##removeItem (String.js k)
  let clear() = handler##clear

  let raw_get k =
    match get k with
    | Some r -> r
    | None -> raise Not_found

  let internal_iter len f =
    for i = 0 to pred len do
      match key i with
      | None -> raise Not_found
      | Some k -> let () = (f k (raw_get k)) in ()
    done

  let iter f =
    let len = length () in
    internal_iter len f

  let to_hashtbl () =
    let len = length () in 
    let h = Hashtbl.create len in
    internal_iter len (fun k v -> Hashtbl.add h k v);
    h

  let to_jstable () =
    let len = length () in
    let h = Jstable.create () in
    for i = 0 to pred len do
      let k = js_key i in
      Jstable.add h k (js_get k)
    done;
    h

  let map f =
    iter (fun k v -> set k (f k v))
      
  let filter p =
    iter (fun k v -> if not (p k v) then remove k)
  
end


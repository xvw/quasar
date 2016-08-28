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

(** This module provide the common API of the library *)

(** {2 Usefuls functions} *)

(** Identity function *)
val id : 'a -> 'a

(** Reverted application for two parameters in a function *)
val flip : ('a -> 'b -> 'c) -> 'b -> 'a -> 'c


(** {2 Infix operators} *)

(** Shortcut for Lwt.bind *)
val ( >>=) : 'a Lwt.t -> ('a -> 'b Lwt.t) -> 'b Lwt.t

(** Function composition *)
val ( % ) : ('a -> 'b) -> ('c -> 'a) -> 'c -> 'b

(** Function composition when the second function is executed first*)
val ( %> ) : ('a -> 'b) -> ('b -> 'c) -> 'a -> 'c

(** Application operator. This operator is redundant, since ordinary
    application (f x) means the same as (f $ x). However, $ has low,
    right-associative binding precedence, so it sometimes allows parentheses
*)
val ( $ ) : ('a -> 'b) -> 'a -> 'b 

(** {2 JavaScript objects} *)
val document : Dom_html.document Js.t
val window   : Dom_html.window   Js.t
val console  : Firebug.console   Js.t
val location : Dom_html.location Js.t
  
(** {2 JavaScript useful functions} *)
    
(** Perform a JavaScript alert *)
val alert : string -> unit

(** Write data int the console *)
val log : 'a -> unit

(** Try to extract a potential null value, raise Error.Unoptable if the value is null *)
val unopt : 'a Js.Opt.t -> 'a

(** Same as [unopt] but returns an option instead of raising an exception *)
val try_unopt : 'a Js.Opt.t -> 'a option

(** Check if the application is in debug mode *)
val with_debugger : unit -> bool

(** {2 Option} *)

module Option :
sig

  val some : 'a -> 'a option
  (** [some x] returns [Some x] *)


  val none : 'a option
  (** [none] returns [None] *)


  (** [safe f x] try [f x] and wrap the result in an option *)
  val safe : ('a -> 'b) -> 'a -> 'b option

  val default : 'a -> 'a option -> 'a
  (** return the wrapped value or the first arguments (if the gived 
      option is None ) *)

  (** Map a side effect on an option *)
  val unit_map : ('a -> unit) -> 'a option -> unit

  val map : ('a -> 'b) -> 'a option -> 'b option
  (** [map f opt] returns [Some (f x)] if opt = Some x, None if opt = None *)

  val apply : ('a -> 'a) option -> 'a -> 'a
  (** [apply None x] returns [x] and [apply (Some f) x] returns [f x] *)

  (** {2 Option verification} *)

  val is_some : 'a option -> bool
  (** [is_some opt] returns true if opt is Some(x), otherwise false *)

  val is_none : 'a option -> bool
  (** [is_none opt] returns true if opt is None, otherwise false *)


end


(** {2 Internals or extensions modules} *)


(** Extension for String *)
module String :
sig

  include module type of String

  (** Convert JavaScript's string to an OCaml's string *)
  val ocaml    : Js.js_string Js.t -> string

  (** Convert OCaml's string to a JavaScript 's string *)
  val js       : string -> Js.js_string Js.t

  (** Convert Safe Json to string *)
  val of_json  :
    ?buf:Bi_outbuf.t
    -> ?len:int
    -> ?std:bool
    -> Yojson.Safe.json
    -> string

    (** Convert Unsafe Json to string *)
  val of_unsafe_json  :
    ?buf:Bi_outbuf.t
    -> ?len:int
    -> ?std:bool
    -> Yojson.json
    -> string
 

end

(** Error Management *)
module Error :
sig

  exception Runtime of string
  exception Unoptable

  (** Fail with a message *)
  val fail : string -> unit

  (** [try_with f "failure"] try f () with potential failure *)
  val try_with : (unit -> 'a) -> string -> unit

  (** Fail data extraction *)
  val fail_unopt : unit -> 'a

end



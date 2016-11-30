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

(** This module is only defined for internal usage ! *)

(** {2 Common JavaScript objects} *)

val document : Dom_html.document Js.t
val window   : Dom_html.window   Js.t
val console  : Firebug.console   Js.t
val location : Dom_html.location Js.t

(**{2 Debugging function} *)
    
(** Check if the application is in debug mode *)
val with_debugger : unit -> bool

(** Perform a JavaScript alert *)
val alert : string -> unit

(** Write data int the console *)
val log : 'a -> unit

(** {2 Usefuls functions} *)
val id : 'a -> 'a

(** {2 Dom manipulation} *)
module Tag :
sig

  (** returns each nammed elements in an element *)
  val all_elements_of :
    ?where:('a -> bool)
    -> ?map:('a -> 'a)
    -> string
    -> (Dom_html.element Js.t -> 'a Js.Opt.t)
    -> #Dom_html.nodeSelector Js.t
    -> 'a list

  (** Returns all elements in a document *)
  val all_elements :
    ?where:('a -> bool)
    -> ?map:('a -> 'a)
    -> string
    -> (Dom_html.element Js.t -> 'a Js.Opt.t)
    -> 'a list

  (** Returns all links in an element *)
  val all_links_of :
    ?where:(Dom_html.anchorElement Js.t -> bool)
    -> ?map:(Dom_html.anchorElement Js.t -> Dom_html.anchorElement Js.t)
    -> #Dom_html.nodeSelector Js.t
    -> Dom_html.anchorElement Js.t list

  (** Returns all links in a document *)
  val all_links:
    ?where:(Dom_html.anchorElement Js.t -> bool)
    -> ?map:(Dom_html.anchorElement Js.t -> Dom_html.anchorElement Js.t)
    -> unit
    -> Dom_html.anchorElement Js.t list

  (** Check if a tag has an attribute *)
  val has_attribute : string -> #Dom_html.element Js.t -> bool

  (** Get the attribute of a tag [get_attribute key element] *)
  val get_attribute : string -> #Dom_html.element Js.t -> string option


  (** Check if a tag has a custom attribute *)
  val has_data : string -> #Dom_html.element Js.t -> bool

  (** Get the custom attribute of a tag [get_data key element] *)
  val get_data : string -> #Dom_html.element Js.t -> string option

end

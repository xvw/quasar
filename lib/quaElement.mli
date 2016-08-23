(*
 * Drumaderian
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

(** Shortcuts for element *)
type t = Dom_html.element Js.t

(** {2 Retreive Elements from the document} *)

(** [getById_opt "an_element"] returns an Html element into an option *)
val getById_opt : string -> t option

(** [getById "an_element"] returns an Html element (or raise an exception *)
val getById : string -> t

(** [getByTag "tagname"] returns all element by tag name as a list *)
val getByTag : string -> t list

(** [find element "selector"] QuerySelector on an element *)
val find : t -> string -> t

(** [find_opt element "selector"] QuerySelector on an element wrapped in a option *)
val find_opt : t -> string -> t option

(** [select element "selector"] QuerySelectorAll on an element *)
val select : t -> string -> t list

(** Alias of [select] *)
val find_all : t -> string -> t list

(** Get all elements as a list *)
val all : unit -> t list


(** {2 Attributes management} *)

(** Check if an element as an attribute *)
val has_attribute : t -> string -> bool

(** Try to get an attribute of an element *)
val get_attribute : t -> string -> string option

(** Set an attribute to an element *)
val set_attribute : t -> string -> string -> t

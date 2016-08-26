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


(** {2 Listener} *)

module Listener :
sig

  (** {3 Internals types} *)

  type mouse        = Dom_html.mouseEvent Js.t Lwt.t
  type keyboard     = Dom_html.keyboardEvent Js.t Lwt.t
  type event        = Dom_html.event Js.t Lwt.t
  type drag         = Dom_html.dragEvent Js.t Lwt.t
  type wheel        = (Dom_html.mouseEvent Js.t * (int * int)) Lwt.t
  type touch        = Dom_html.touchEvent Js.t Lwt.t
  type 'a multiple  = ('a Js.t -> unit Lwt.t -> unit Lwt.t) -> unit Lwt.t

  (** {3 List of listeners *)

end

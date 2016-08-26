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

  val click       : ?use_capture:bool ->  #Dom_html.eventTarget Js.t -> mouse
  val dblclick    : ?use_capture:bool ->  #Dom_html.eventTarget Js.t -> mouse
  val mousedown   : ?use_capture:bool ->  #Dom_html.eventTarget Js.t -> mouse
  val mouseup     : ?use_capture:bool ->  #Dom_html.eventTarget Js.t -> mouse
  val mouseover   : ?use_capture:bool ->  #Dom_html.eventTarget Js.t -> mouse
  val mousemove   : ?use_capture:bool ->  #Dom_html.eventTarget Js.t -> mouse
  val mouseout    : ?use_capture:bool ->  #Dom_html.eventTarget Js.t -> mouse
  val mousewheel  : ?use_capture:bool ->  #Dom_html.eventTarget Js.t -> wheel

  val keypress    : ?use_capture:bool ->  #Dom_html.eventTarget Js.t -> keyboard
  val keyup       : ?use_capture:bool ->  #Dom_html.eventTarget Js.t -> keyboard
  val keydown     : ?use_capture:bool ->  #Dom_html.eventTarget Js.t -> keyboard

  val timeupdate  : ?use_capture:bool ->  #Dom_html.eventTarget Js.t -> event
  val input       : ?use_capture:bool ->  #Dom_html.eventTarget Js.t -> event
  val change      : ?use_capture:bool ->  #Dom_html.eventTarget Js.t -> event
  val focus       : ?use_capture:bool ->  #Dom_html.eventTarget Js.t -> event
  val blur        : ?use_capture:bool ->  #Dom_html.eventTarget Js.t -> event
  val scroll      : ?use_capture:bool ->  #Dom_html.eventTarget Js.t -> event
  val submit      : ?use_capture:bool ->  #Dom_html.eventTarget Js.t -> event
  val select      : ?use_capture:bool ->  #Dom_html.eventTarget Js.t -> event
    

  val dragstart   : ?use_capture:bool ->  #Dom_html.eventTarget Js.t -> drag
  val dragend     : ?use_capture:bool ->  #Dom_html.eventTarget Js.t -> drag
  val dragenter   : ?use_capture:bool ->  #Dom_html.eventTarget Js.t -> drag
  val dragover    : ?use_capture:bool ->  #Dom_html.eventTarget Js.t -> drag
  val dragleave   : ?use_capture:bool ->  #Dom_html.eventTarget Js.t -> drag
  val drag        : ?use_capture:bool ->  #Dom_html.eventTarget Js.t -> drag
  val drop        : ?use_capture:bool ->  #Dom_html.eventTarget Js.t -> drag

  val touchstart  : ?use_capture:bool ->  #Dom_html.eventTarget Js.t -> touch
  val touchmove   : ?use_capture:bool ->  #Dom_html.eventTarget Js.t -> touch
  val touchend    : ?use_capture:bool ->  #Dom_html.eventTarget Js.t -> touch
  val touchcancel : ?use_capture:bool ->  #Dom_html.eventTarget Js.t -> touch

  val transitionend : #Dom_html.eventTarget Js.t -> unit Lwt.t
    
    
    

end

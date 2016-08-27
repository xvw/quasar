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

(** {2 Event manager} *)

(** Cancel any Lwt thread *)
val cancel : 'a Lwt.t -> unit

(** Wait for events *)
val wait_for : (unit -> 'a Lwt.t) list -> unit Lwt.t

(** Promote a function to an event handler *)
val handler : ('event -> 'b) -> ('event -> unit Lwt.t -> unit Lwt.t)

(** creates a looping Lwt thread that waits for the event ev to happen on target, 
    then execute handler, and start again waiting for the event. Events happening 
    during the execution of the handler are ignored. 
*)
val sequential : 
  (?use_capture:bool -> 'target -> 'event Lwt.t)
  -> ?cancel_handler:bool
  -> ?use_capture:bool
  -> 'target
  -> ('event -> unit Lwt.t -> unit Lwt.t)
  -> unit Lwt.t

(** async_loop is similar to sequential, but each handler runs independently. No event
    is thus missed, but since several instances of the handler can be run concurrently,
    it is up to the programmer to ensure that they interact correctly.
*)
val async :
  (?use_capture:bool -> 'target -> 'event Lwt.t)
  -> ?use_capture:bool
  -> 'target
  -> ('event -> unit Lwt.t -> unit Lwt.t)
  -> unit Lwt.t


(** buffered_loop is similar to sequential, but any event that occurs during an execution 
    of the handler is queued instead of being ingnored.
*)
val buffered :
  (?use_capture:bool -> 'target -> 'event Lwt.t)
  -> ?cancel_handler:bool
  -> ?cancel_queue:bool
  -> ?use_capture:bool
  -> 'target
  -> ('event -> unit Lwt.t -> unit Lwt.t)
  -> unit Lwt.t


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
  type 'a multiple  = ('a Js.t -> unit Lwt.t -> unit Lwt.t)

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

  val clicks :
    ?cancel_handler:bool
    -> ?use_capture:bool
    -> #Dom_html.eventTarget Js.t
    -> Dom_html.mouseEvent multiple
    -> unit Lwt.t

  val dblclicks :
    ?cancel_handler:bool
    -> ?use_capture:bool
    -> #Dom_html.eventTarget Js.t
    -> Dom_html.mouseEvent multiple
    -> unit Lwt.t
      
  val mousedowns :
    ?cancel_handler:bool
    -> ?use_capture:bool
    -> #Dom_html.eventTarget Js.t
    -> Dom_html.mouseEvent multiple
    -> unit Lwt.t

   val mouseups :
    ?cancel_handler:bool
    -> ?use_capture:bool
    -> #Dom_html.eventTarget Js.t
    -> Dom_html.mouseEvent multiple
    -> unit Lwt.t

   val mouseovers :
    ?cancel_handler:bool
    -> ?use_capture:bool
    -> #Dom_html.eventTarget Js.t
    -> Dom_html.mouseEvent multiple
    -> unit Lwt.t

   val mousemoves :
    ?cancel_handler:bool
    -> ?use_capture:bool
    -> #Dom_html.eventTarget Js.t
    -> Dom_html.mouseEvent multiple
    -> unit Lwt.t

  val mouseouts :
    ?cancel_handler:bool
    -> ?use_capture:bool
    -> #Dom_html.eventTarget Js.t
    -> Dom_html.mouseEvent multiple
    -> unit Lwt.t

  val keypresses :
    ?cancel_handler:bool
    -> ?use_capture:bool
    -> #Dom_html.eventTarget Js.t
    -> Dom_html.keyboardEvent multiple
    -> unit Lwt.t

  val keydowns :
    ?cancel_handler:bool
    -> ?use_capture:bool
    -> #Dom_html.eventTarget Js.t
    -> Dom_html.keyboardEvent multiple
    -> unit Lwt.t

  val keyups :
    ?cancel_handler:bool
    -> ?use_capture:bool
    -> #Dom_html.eventTarget Js.t
    -> Dom_html.keyboardEvent multiple
    -> unit Lwt.t

  val inputs :
    ?cancel_handler:bool
    -> ?use_capture:bool
    -> #Dom_html.eventTarget Js.t
    -> Dom_html.event multiple
    -> unit Lwt.t

  val timeupdates :
    ?cancel_handler:bool
    -> ?use_capture:bool
    -> #Dom_html.eventTarget Js.t
    -> Dom_html.event multiple
    -> unit Lwt.t

  val changes :
    ?cancel_handler:bool
    -> ?use_capture:bool
    -> #Dom_html.eventTarget Js.t
    -> Dom_html.event multiple
    -> unit Lwt.t

  val dragstarts :
    ?cancel_handler:bool
    -> ?use_capture:bool
    -> #Dom_html.eventTarget Js.t
    -> Dom_html.dragEvent multiple
    -> unit Lwt.t

  val dragends :
    ?cancel_handler:bool
    -> ?use_capture:bool
    -> #Dom_html.eventTarget Js.t
    -> Dom_html.dragEvent multiple
    -> unit Lwt.t

  val dragenters :
    ?cancel_handler:bool
    -> ?use_capture:bool
    -> #Dom_html.eventTarget Js.t
    -> Dom_html.dragEvent multiple
    -> unit Lwt.t

  val dragovers :
    ?cancel_handler:bool
    -> ?use_capture:bool
    -> #Dom_html.eventTarget Js.t
    -> Dom_html.dragEvent multiple
    -> unit Lwt.t

  val dragleaves :
    ?cancel_handler:bool
    -> ?use_capture:bool
    -> #Dom_html.eventTarget Js.t
    -> Dom_html.dragEvent multiple
    -> unit Lwt.t

  val drags :
    ?cancel_handler:bool
    -> ?use_capture:bool
    -> #Dom_html.eventTarget Js.t
    -> Dom_html.dragEvent multiple
    -> unit Lwt.t

  val drops :
    ?cancel_handler:bool
    -> ?use_capture:bool
    -> #Dom_html.eventTarget Js.t
    -> Dom_html.dragEvent multiple
    -> unit Lwt.t

  val mousewheels :
    ?cancel_handler:bool
    -> ?use_capture:bool
    -> #Dom_html.eventTarget Js.t
    -> (Dom_html.mouseEvent Js.t * (int * int) -> unit Lwt.t -> unit Lwt.t)
    -> unit Lwt.t

  val touchstarts :
    ?cancel_handler:bool
    -> ?use_capture:bool
    -> #Dom_html.eventTarget Js.t
    -> Dom_html.touchEvent multiple
    -> unit Lwt.t

  val touchmoves :
    ?cancel_handler:bool
    -> ?use_capture:bool
    -> #Dom_html.eventTarget Js.t
    -> Dom_html.touchEvent multiple
    -> unit Lwt.t

  val touchends :
    ?cancel_handler:bool
    -> ?use_capture:bool
    -> #Dom_html.eventTarget Js.t
    -> Dom_html.touchEvent multiple
    -> unit Lwt.t

  val touchcancels :
    ?cancel_handler:bool
    -> ?use_capture:bool
    -> #Dom_html.eventTarget Js.t
    -> Dom_html.touchEvent multiple
    -> unit Lwt.t

  val focuses :
    ?cancel_handler:bool
    -> ?use_capture:bool
    -> #Dom_html.eventTarget Js.t
    -> Dom_html.event multiple
    -> unit Lwt.t


  val blurs :
    ?cancel_handler:bool
    -> ?use_capture:bool
    -> #Dom_html.eventTarget Js.t
    -> Dom_html.event multiple
    -> unit Lwt.t

 
  val scrolls :
    ?cancel_handler:bool
    -> ?use_capture:bool
    -> #Dom_html.eventTarget Js.t
    -> Dom_html.event multiple
    -> unit Lwt.t


  val submits :
    ?cancel_handler:bool
    -> ?use_capture:bool
    -> #Dom_html.eventTarget Js.t
    -> Dom_html.event multiple
    -> unit Lwt.t

 
  val selects :
    ?cancel_handler:bool
    -> ?use_capture:bool
    -> #Dom_html.eventTarget Js.t
    -> Dom_html.event multiple
    -> unit Lwt.t


  val loads :
    ?cancel_handler:bool
    -> ?use_capture:bool
    -> #Dom_html.imageElement Js.t
    -> Dom_html.event multiple
    -> unit Lwt.t

 val errors :
    ?cancel_handler:bool
    -> ?use_capture:bool
    -> #Dom_html.imageElement Js.t
    -> Dom_html.event multiple
    -> unit Lwt.t

 val aborts :
    ?cancel_handler:bool
    -> ?use_capture:bool
    -> #Dom_html.imageElement Js.t
    -> Dom_html.event multiple
    -> unit Lwt.t
  
  
  
  val transitionend : #Dom_html.eventTarget Js.t -> unit Lwt.t
      
  val transitionends :
    ?cancel_handler:bool
    -> #Dom_html.eventTarget Js.t
    -> (unit Lwt.t -> unit Lwt.t)
    -> unit Lwt.t
    
  val load  : ?use_capture:bool ->  #Dom_html.imageElement Js.t -> event    
  val error : ?use_capture:bool ->  #Dom_html.imageElement Js.t -> event
  val abort : ?use_capture:bool ->  #Dom_html.imageElement Js.t -> event
    

end

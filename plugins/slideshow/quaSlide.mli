(*
 * Quasar.slideshow
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

(** QuaSlide provide combinators to write awesome presentation !*)

(** {2 Requirements} *)

(** Requirement to provide combinators to build new presentation *)
module type Configuration =
sig

  (** The css selector of all slides *)
  val selector : string

  (** Where slides are *)
  val parent : Quasar.Element.t

  (** Slider initialization *)
  val before :
    length:int
    -> slides:(Quasar.Element.t list)
    -> int ref
    -> unit

  (** Slide initialization *)
  val init_slide :
    length:int
    -> slides:(Quasar.Element.t list)
    -> Quasar.Element.t
    -> unit

  (** List of events to be listened *)
  val handler :
    int ref ->
    ((?use_capture:bool -> 'target -> 'event Lwt.t)
     * (length:int -> slides:(Quasar.Element.t list) -> int ref -> 'event -> unit)) list

  (** List of events to be watched *)
  val watcher :
    int ref ->
    (('a, 'b) Quasar.Event.watchable
     * ((length:int -> slides:(Quasar.Element.t list) -> int ref -> 'c -> 'd))      
     * [< `Once | `Always]) list

  (** Next slide : returns true if the changement is completely passed, false otherwhise*)
  val succ : length:int -> slides:(Quasar.Element.t list) -> int ref -> bool 

  (** Prev slide : returns true if the changement is completely passed, false otherwhise *)
  val pred : length:int -> slides:(Quasar.Element.t list) -> int ref -> bool

  (** Update is called when a slide is changed *)
  val update : length:int -> slides:(Quasar.Element.t list) -> int ref -> unit


end

(** {2 Default combinators} *)

val default_succ    : length:int -> slides:(Quasar.Element.t list) -> int ref -> bool
val default_pred    : length:int -> slides:(Quasar.Element.t list) -> int ref -> bool
val default_before  : length:int -> slides:(Quasar.Element.t list) -> int ref -> unit
  
val default_watcher :
  int ref ->
  (('a, 'b) Quasar.Event.watchable
   * ((length:int -> slides:(Quasar.Element.t list) -> int ref -> 'c -> 'd))      
   * [< `Once | `Always]) list

val default_handler:
  int ref ->
  ((?use_capture:bool -> 'target -> 'event Lwt.t)
   * (length:int -> slides:(Quasar.Element.t list) -> int ref -> 'event -> unit)) list



(** {2 Functors} *)

(** build simple combinators to build a slider *)
module Simple : functor (M : Configuration) ->
sig
  
  val selector : string
  val parent : Quasar.Element.t
                 
  val before :
    length:int
    -> slides:Quasar.Element.t list
    -> int ref
    -> unit
    
  val init_slide :
    length:int
    -> slides:Quasar.Element.t list
    -> Quasar.Element.t
    -> unit
    
  val handler :
    int ref ->
    ((?use_capture:bool -> 'target -> 'event Lwt.t) *
     (length:int ->
      slides:Quasar.Element.t list -> int ref -> 'event -> unit))
      list
      
  val watcher :
    int ref ->
    (('a, 'b) Quasar.Event.watchable *
     (length:int -> slides:Quasar.Element.t list -> int ref -> 'c -> 'd) *
     [< `Always | `Once ])
      list
      
  val succ : length:int -> slides:Quasar.Element.t list -> int ref -> bool
  val pred : length:int -> slides:Quasar.Element.t list -> int ref -> bool
    
  val update :
    length:int
    -> slides:Quasar.Element.t list
    -> int ref
    -> unit
    
  val cursor : int ref
  val set_cursor : int -> unit
    
  val move :
    length:int
    -> slides:Quasar.Element.t list
    -> int
    -> bool
    
  val get_slides : unit -> Quasar.Element.t list
      
  val init_slides :
    length:int
    -> slides:Quasar.Element.t list
    -> unit
    -> unit
  val init_listener :
    length:int
    -> slides:Quasar.Element.t list
    -> unit
    -> unit
    
  val init_watcher :
    length:int
    -> slides:Quasar.Element.t list
    -> unit
    -> unit
    
  val start : unit -> unit
end
  

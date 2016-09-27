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

open Quasar

(** Requirement to provide combinators to build new presentation *)
module type Configuration =
sig

  (** The css selector of all slides *)
  val selector : string

  (** Where slides are *)
  val parent : Element.t

  (** Slider initialization *)
  val before :
    length:int
    -> slides:(Element.t list)
    -> unit
    -> unit

  (** Slide initialization *)
  val init_slide :
    length:int
    -> slides:(Element.t list)
    -> Element.t
    -> unit

  (** List of events to be listened *)
  val handler :
    ((?use_capture:bool -> 'target -> 'event Lwt.t)
     * (length:int -> slides:(Element.t list) -> 'event -> unit)) list

  (** List of events to be watched *)
  val watcher :
    (('a, 'b) Event.watchable
     * ((length:int -> slides:(Element.t list) -> 'c -> 'd))      
     * [< `Once | `Always]) list

  (** Next slide : returns true if the changement is completely passed, false otherwhise*)
  val succ : length:int -> slides:(Element.t list) -> unit -> bool 

  (** Prev slide : returns true if the changement is completely passed, false otherwhise *)
  val pred : length:int -> slides:(Element.t list) -> unit -> bool 

end

(** Functor to provide combinators to build new presentation *)
module Simple (M :  Configuration) =
struct

  include M

  (** Move N slides *)
  let move ~length ~slides amount =
    if amount = 0 then true
    else let result = ref false in
      if amount > 0 then begin
        for i = 0 to amount do
          result := succ ~length ~slides ()
        done; !result
      end
      else begin for i = amount to 0 do
          result := pred ~length ~slides ()
        done; !result end
      

          
    
        
       

  (** Get all slides *)
  let get_slides () =
    Element.find_all parent selector

  (** Initialize each slides *)
  let init_slides ~length ~slides () =
    List.iter (init_slide ~length ~slides) slides

  (** Initialize event listener *)
  let init_listener ~length ~slides () =
    List.iter (fun (listener, f) ->
        Event.async
          listener
          document
          (fun e _ ->
             f ~length ~slides e;
             Lwt.return_unit
          ) |> ignore
      ) handler

  (** Initialize event watcher *)
  let init_watcher ~length ~slides () =
    List.iter (fun (watch, f, kind) ->
        let rf = (fun x -> f ~length ~slides x) in
        match kind with
        | `Once -> ignore $ Event.watch_once watch () rf
        | `Always -> ignore $ Event.watch watch () rf
        |> ignore
    ) watcher

  (** Initialize the slider *)
  let start () =
    let s = get_slides () in
    let l = List.length s in
    
    let _ = before        ~length:l ~slides:s () in
    let _ = init_listener ~length:l ~slides:s () in
    let _ = init_watcher  ~length:l ~slides:s () in
    init_slides   ~length:l ~slides:s ()

end


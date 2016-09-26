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
  val before : unit -> unit

  (** Slide initialization *)
  val init_slide :
    length:int
    -> slides:(Element.t list)
    -> Element.t
    -> unit

end

(** Functor to provide combinators to build new presentation *)
module Simple (M :  Configuration) =
struct

  include M

  (** Get all slides *)
  let get_slides () =
    Element.find_all parent selector

  (** Initialize each slides *)
  let init_slides ~length ~slides () =
    let _ = List.iter (init_slide ~length ~slides) slides in
    slides

end


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

(* open QuaPervasives *)

let cancel = Lwt.cancel

type ('a, 'b) watchable = 'a -> 'b Lwt.t
type event = Dom_html.event Js.t Lwt.t
    

module Listener =
struct

  type mouse        = Dom_html.mouseEvent Js.t Lwt.t
  type keyboard     = Dom_html.keyboardEvent Js.t Lwt.t
  type drag         = Dom_html.dragEvent Js.t Lwt.t
  type wheel        = (Dom_html.mouseEvent Js.t * (int * int)) Lwt.t
  type touch        = Dom_html.touchEvent Js.t Lwt.t
  type 'a multiple  = ('a Js.t -> unit Lwt.t -> unit Lwt.t)

  include Lwt_js_events
    
end

let wrap_lwt f =
  let%lwt _ = f () in
  Lwt.return_unit

let wait_for events =
  List.map wrap_lwt events
  |> Lwt.pick


let handler f = (fun e _ -> f e; Lwt.return_unit)
let sequential = Lwt_js_events.seq_loop
let async      = Lwt_js_events.async_loop
let buffered   = Lwt_js_events.buffered_loop

let watch_once event args f =
  let%lwt result = event args in
  let _ = f result in
  Lwt.return_unit

let rec watch event args f =
  let%lwt _ = watch_once event args f in
  watch event args f

module Watcher =
struct

  include Lwt_js_events

end


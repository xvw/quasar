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

open QuaPervasives


(* Get the history *)
let history = window##.history

(* last url *)
let prev_state = ref ""

(* Check if an element is scoped *)
let is_scoped elt =
  match Tag.get_data "scope" elt with
  | Some "internal" | Some "scoped" -> true
  | Some _ | None -> false


(* Watching changement ONCE *)
let watch_once event args f =
  let%lwt result = event args in
  let _ = f result in
  Lwt.return ()

(* Watching each changement *)
let rec watch event args f =
  let%lwt _ = watch_once event args f in
  watch event args f

(* Extract fragment of a link *)
let fragment_of = function
  | Url.Http e | Url.Https e -> e.Url.hu_path_string
  | Url.File e -> "#" ^ e.Url.fu_path_string

(* Perform link transformation *)
let perform_transformation elt = function
  | None -> ""
  | Some url ->
    let fragment = fragment_of url in
    let () = elt##.classList##add(Js.string "quasar-visited") in
    let () = history##pushState
        Js.null
        document##.title
        (Js.(Opt.return (string fragment)))
    in fragment

(* Change the behaviour of a link *)
let link_behaviour f elt ev result =
  let _ = Dom.preventDefault ev in
  let href = Js.to_string (elt##.href) in
  let fragment = perform_transformation elt (Url.url_of_string href) in
  let _ = if fragment <> !prev_state then f () in
  let _ = prev_state := fragment in
  if (with_debugger ()) then log (Js.string !prev_state);
  result

(* Apply the changement on each scoped link *)
let routing_behaviour f link_tag =
  let _ = Lwt_js_events.(
      async_loop click link_tag  (link_behaviour f link_tag)
    ) in link_tag

(* Perform DOM transformation before routing*)
let routing_callback f _ =
  let _ =
    Tag.all_links
      ~where:is_scoped
      ~map:(routing_behaviour f)
      ()
  in
  prev_state := Js.to_string (location##.hash) ;
  f ()

(* Entry point for the routing *)
let start f =
  let open Lwt_js_events in
  (* let g = fun () -> if !prev_state f () in *)
  let _ = watch_once onload  () (routing_callback f) in
  let _ = watch onhashchange () (routing_callback f) in
  ()


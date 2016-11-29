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


(* Watching changement *)
let watch_once event args f =
  let%lwt result = event args in
  let _ = f result in
  Lwt.return ()

let rec watch event args f =
  let%lwt _ = watch_once event args f in
  watch event args f

(* Entry point for the routing *)
let start f =
  let open Lwt_js_events in
  let _ = watch_once onload  () (fun _ -> f()) in
  let _ = watch onhashchange () (fun _ -> f()) in
  ()


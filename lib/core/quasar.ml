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


module Storage  = QuaStorage
module Url      = QuaUrl
module Event    = QuaEvent
module Listener = Event.Listener
module Watcher  = Event.Watcher
module Ajax     = QuaAjax
module Element  = QuaElement
module Router   = QuaRouter
  

include QuaPervasives
include Tyxml_js

(** {2 Application functions} *)

(** Entry point for an application *)
let start f =
  Event.watch_once
    Watcher.onload
    ()
    (fun _ -> f ())
  |> ignore
  
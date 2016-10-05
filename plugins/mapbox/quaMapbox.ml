(*
 * Quasar.Mapbox
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

module type Configuration =
sig

  val access_token: string

end

module Static =
struct

  let map =
    Printf.sprintf "https://%s/styles/%s/%F,%F,%d/%sx%s?access_token=%s"
      "api.mapbox.com"

end

module Connect (F : Configuration) =
struct

  let key    = F.access_token
  let lib    = Js.Unsafe.variable "L"
  let mapbox = lib##.mapbox

  let _      = mapbox##.accessToken := key

  let static
      ?retina
      ?(style="v1/mapbox/streets-v9/static")
      ~longitude
      ~latitude
      ~zoom
      ~width
      ~height
      () =
    let h = match retina with
      | Some x -> Printf.sprintf "%d@%d" height x
      | None -> string_of_int height
    and w = string_of_int width in
    Static.map style longitude latitude zoom w h key


  module Gl =
  struct

    type options = {
      container                    : string
    ; minZoom                      : int
    ; maxZoom                      : int
    ; style                        : string
    ; hash                         : bool
    ; interactive                  : bool
    ; bearingSnap                  : int
    ; classes                      : string list
    ; attributionControl           : bool
    ; failIfMajorPerformanceCaveat : bool
    ; preserveDrawingBuffer        : bool
    ; maxBounds                    : float list
    ; scrollZoom                   : bool
    ; boxZoom                      : bool
    ; dragRotate                   : bool
    ; dragPan                      : bool
    ; keyboard                     : bool
    ; doubleClickZoom              : bool
    ; touchRotateZoom              : bool
    ; trackResize                  : bool
    ; center                       : int list 
    ; zoom                         : int
    ; bearing                      : int
    ; pitch                        : int
      
    } [@@deriving yojson]

    let mapbox = Js.Unsafe.variable "mapboxgl"
    let _      = mapbox##.accessToken := key

    let options_to_js r =
      options_to_yojson r
      |> String.of_json
      |> Js.Unsafe.js_expr

  end

  
end

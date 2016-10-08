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


  (* Reference https://www.mapbox.com/mapbox.js/api/v2.4.0/l-map-class/ *)
  
    class type map = object

      method element: Js.js_string Js.prop
      method id : Js.js_string Js.prop
      method zoom : int Js.prop
      method center: float Js.js_array Js.prop
      method minZoom : float Js.prop
      method maxZoom : float Js.prop
      method maxBounds: float Js.js_array Js.prop
      method dragging: bool Js.prop
      method touchZoom: bool Js.prop
      method scrollWheelZoom: bool Js.prop
      method doubleClickZoom: bool Js.prop
      method boxZoom: bool Js.prop
      method tapTolerance: int Js.prop
      method trackResize: bool Js.prop
      method worldCopyJump: bool Js.prop
      method closePopupOnClick: bool Js.prop
      method bounceAtZoomLimits: bool Js.prop
      method keyboard: bool Js.prop
      method keyboardPanOffset: int Js.prop
      method keyboardZoomOffset: int Js.prop
      method intertia: bool Js.prop
      method inertiaDeceleration: int Js.prop
      method inertiaMaxSpeed: int Js.prop
      method inertiaThreshold: int Js.prop
      method zoomControl: bool Js.prop
      method attributionControl: bool Js.prop
      method fadeAnimation: bool Js.prop
      method zoomAnimation: bool Js.prop
      method zoomAnimationThreshold: int Js.prop
      method markerZoomAnimation: bool Js.prop
          
      method setView : float Js.js_array -> float -> unit Js.meth
    
  end

  type style = {
    owner : string
  ; name  : string
      
  }
  
  let default_style = {
    owner = "mapbox"
  ; name  = "streets-v9" 
  }

  let from_style s =
    Printf.sprintf "mapbox://styles/%s/%s"
      s.owner
      s.name

  
  let key    = F.access_token

  let point x y = Js.array [|x; y|]

  let get () =
    let l = Js.Unsafe.variable "L" in
    let m = l##.mapbox in
    let _ = m##.accessToken := key in
    m

  let map html_id map_id =
    let m = get () in
    let _ = m##map (String.js html_id) (String.js map_id) in
    m
    

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

    (* Work in progress *)

    type a_map = <
      repaint : unit -> unit;
      > Js.t

(*
    let mapbox  = Js.Unsafe.global##.mapboxgl 
    let _       = mapbox##.accessToken := key
    let constr  = mapbox##.Map

    let map
        ?(minZoom                      = 0.)
        ?(maxZoom                      = 20.)
        ?(style                        = default_style)
        ?(hash                         = false)
        ?(interactive                  = true)
        ?(bearingSnap                  = 7)
        ?(classes                      = [||])
        ?(attributionControl           = true)
        ?(failIfMajorPerformanceCaveat = false)
        ?(preserveDrawingBuffer        = false)
        ?(maxBounds                    = [||])
        ?(scrollZoom                   = true)
        ?(boxZoom                      = true)
        ?(dragRotate                   = true)
        ?(dragPan                      = true)
        ?(keyboard                     = true)
        ?(doubleClickZoom              = true)
        ?(touchZoomRotate              = true)
        ?(trackResize                  = true)
        ?(center                       = [|0.;0.|])
        ?(zoom                         = 0.)
        ?(bearing                      = 0)
        ?(pitch                        = 0)
        container =

       new%js constr (object%js
        val minZoom = minZoom
        val maxZoom = maxZoom
        val style = (from_style style)
        val hash = hash
        val interactive = interactive
        val bearingSnap = bearingSnap
        val classes = Js.array classes
        val attributionControl = attributionControl
        val failIfMajorPerformanceCaveat = failIfMajorPerformanceCaveat
        val preserveDrawingBuffer = preserveDrawingBuffer
        val maxBounds = Js.array maxBounds
        val scrollZoom = scrollZoom
        val boxZoom = boxZoom
        val dragRotate = dragRotate
        val dragPan = dragPan
        val keyboard = keyboard
        val doubleClickZoom = doubleClickZoom
        val touchZoomRotate = touchZoomRotate
        val trackResize =  trackResize
        val center = Js.array center
        val zoom = zoom
        val bearing = bearing
        val pitch = pitch
        val container = container
      end)
    
*)
  end

  
end

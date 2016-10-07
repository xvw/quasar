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

(** {2 Configuration for the API} *)

module type Configuration =
sig

  (** Access token for Mapbox *)
  val access_token: string

end

(** {2 API for Mapbox} *)
module Connect : functor (F : Configuration) ->
sig

  (** Classic Mapbox tools*)

  (** Describe a mapbox style *)
  type style = {
    owner : string
  ; name  : string
      
  }
  
  (** Default style *)
  val default_style : style


  (** Provide a static url for a point on a map *)
  val static :
    ?retina:int      ->
    ?style:string    ->
    longitude:float  ->
    latitude:float   ->
    zoom:int         ->
    width:int        ->
    height:int       ->
    unit             ->
    string

  (** { Standard Map Library} *)

  (** Create a point (for Lat/lon for example) *)
  val point : float -> float -> float Js.js_array Js.t

  (** Type to describe a map *)
  class type map = object

    (** Properties *)
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

    (** Methods *)

    method setView : float Js.js_array -> float -> unit Js.meth
    
  end

  (** `map htmlid mapname` fill x (referenced by his Id) with a map *)
  val map : string -> string -> map

  

  (** Tool for Mapbox GL *)
  module Gl :
  sig

    (* Work in progress *)

    (* type a_map = < *)
    (*   repaint : unit -> unit; *)
    (* > Js.t *)

    (* val map : *)
    (*   ?minZoom:float                     -> *)
    (*   ?maxZoom:float                     -> *)
    (*   ?style:style                       -> *)
    (*   ?hash:bool                         -> *)
    (*   ?interactive:bool                  -> *)
    (*   ?bearingSnap:int                   -> *)
    (*   ?classes:float array               -> *)
    (*   ?attributionControl:bool           -> *)
    (*   ?failIfMajorPerformanceCaveat:bool -> *)
    (*   ?preserveDrawingBuffer:bool        -> *)
    (*   ?maxBounds:float array             -> *)
    (*   ?scrollZoom:bool                   -> *)
    (*   ?boxZoom:bool                      -> *)
    (*   ?dragRotate:bool                   -> *)
    (*   ?dragPan:bool                      -> *)
    (*   ?keyboard:bool                     -> *)
    (*   ?doubleClickZoom:bool              -> *)
    (*   ?touchZoomRotate:bool              -> *)
    (*   ?trackResize:bool                  -> *)
    (*   ?center:float array                -> *)
    (*   ?zoom:float                        -> *)
    (*   ?bearing:int                       -> *)
    (*   ?pitch:int                         -> *)
    (*   string                             -> *)
    (*   a_map *)

  end

  
  
end


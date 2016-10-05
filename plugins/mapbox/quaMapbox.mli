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

  

  (** Tool for Mapbox GL *)
  module Gl :
  sig

    val map :
      ?minZoom:float ->
      ?maxZoom:float ->
      ?style:style ->
      ?hash:bool ->
      ?interactive:bool ->
      ?bearingSnap:int ->
      ?classes:float list ->
      ?attributionControl:bool ->
      ?failIfMajorPerformanceCaveat:bool ->
      ?preserveDrawingBuffer:bool ->
      ?maxBounds:float list ->
      ?scrollZoom:bool ->
      ?boxZoom:bool ->
      ?dragRotate:bool ->
      ?dragPan:bool ->
      ?keyboard:bool ->
      ?doubleClickZoom:bool ->
      ?touchZoomRotate:bool ->
      ?trackResize:bool ->
      ?center:float list ->
      ?zoom:float ->
      ?bearing:int ->
      ?pitch:int ->
      string ->
      unit

  end

  
  
end


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

(** tools for Ajax request *)

(** Content of a query *)

type 'response generic_http_frame = {
  url: string;
  code: int;
  headers: string -> string option;
  content: 'response;
  content_xml: unit -> Dom.element Dom.document Js.t option;
}

type result = XmlHttpRequest.http_frame

(** HTTP methods *)

val get :
  ?headers:(string * string) list
  -> ?content_type:string
  -> ?post_args:((string * Form.form_elt) list)
  -> ?get_args:((string * string) list) 
  -> ?form_arg:Form.form_contents
  -> ?check_headers:(int -> (string -> string option) -> bool)
  -> ?progress:(int -> int -> unit)
  -> ?upload_progress:(int -> int -> unit)
  -> ?override_mime_type:string
  -> ?with_credentials:bool
  -> string
  -> result Lwt.t

val post :
  ?headers:(string * string) list
  -> ?content_type:string
  -> ?post_args:((string * Form.form_elt) list)
  -> ?get_args:((string * string) list) 
  -> ?form_arg:Form.form_contents
  -> ?check_headers:(int -> (string -> string option) -> bool)
  -> ?progress:(int -> int -> unit)
  -> ?upload_progress:(int -> int -> unit)
  -> ?override_mime_type:string
  -> ?with_credentials:bool
  -> string
  -> result Lwt.t


val head :
  ?headers:(string * string) list
  -> ?content_type:string
  -> ?post_args:((string * Form.form_elt) list)
  -> ?get_args:((string * string) list) 
  -> ?form_arg:Form.form_contents
  -> ?check_headers:(int -> (string -> string option) -> bool)
  -> ?progress:(int -> int -> unit)
  -> ?upload_progress:(int -> int -> unit)
  -> ?override_mime_type:string
  -> ?with_credentials:bool
  -> string
  -> result Lwt.t

val put :
  ?headers:(string * string) list
  -> ?content_type:string
  -> ?post_args:((string * Form.form_elt) list)
  -> ?get_args:((string * string) list) 
  -> ?form_arg:Form.form_contents
  -> ?check_headers:(int -> (string -> string option) -> bool)
  -> ?progress:(int -> int -> unit)
  -> ?upload_progress:(int -> int -> unit)
  -> ?override_mime_type:string
  -> ?with_credentials:bool
  -> string
  -> result Lwt.t

val delete :
  ?headers:(string * string) list
  -> ?content_type:string
  -> ?post_args:((string * Form.form_elt) list)
  -> ?get_args:((string * string) list) 
  -> ?form_arg:Form.form_contents
  -> ?check_headers:(int -> (string -> string option) -> bool)
  -> ?progress:(int -> int -> unit)
  -> ?upload_progress:(int -> int -> unit)
  -> ?override_mime_type:string
  -> ?with_credentials:bool
  -> string
  -> result Lwt.t

val options :
  ?headers:(string * string) list
  -> ?content_type:string
  -> ?post_args:((string * Form.form_elt) list)
  -> ?get_args:((string * string) list) 
  -> ?form_arg:Form.form_contents
  -> ?check_headers:(int -> (string -> string option) -> bool)
  -> ?progress:(int -> int -> unit)
  -> ?upload_progress:(int -> int -> unit)
  -> ?override_mime_type:string
  -> ?with_credentials:bool
  -> string
  -> result Lwt.t

val patch :
  ?headers:(string * string) list
  -> ?content_type:string
  -> ?post_args:((string * Form.form_elt) list)
  -> ?get_args:((string * string) list) 
  -> ?form_arg:Form.form_contents
  -> ?check_headers:(int -> (string -> string option) -> bool)
  -> ?progress:(int -> int -> unit)
  -> ?upload_progress:(int -> int -> unit)
  -> ?override_mime_type:string
  -> ?with_credentials:bool
  -> string
  -> result Lwt.t

(** Provide simple functions as helper (to be used only for small ajax call) *)
module Atomic :
sig
  
  val get_text :
    ?error:(XmlHttpRequest.readyState -> int -> unit)
    -> string
    -> (string -> unit)
    -> unit
    
  val get_xml :
    ?error:(XmlHttpRequest.readyState -> int -> unit)
    -> string
    -> (Dom.element Dom.document Js.t option -> unit)
    -> unit
    
  val post :
    ?error:(XmlHttpRequest.readyState -> int -> unit)
    -> string
    -> (string -> unit)
    -> unit

end




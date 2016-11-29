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

(** {2 Common JavaScript objects} *)

val document : Dom_html.document Js.t
val window   : Dom_html.window   Js.t
val console  : Firebug.console   Js.t
val location : Dom_html.location Js.t

(**{2 Debugging function} *)
    
(** Check if the application is in debug mode *)
val with_debugger : unit -> bool

(** Perform a JavaScript alert *)
val alert : string -> unit

(** Write data int the console *)
val log : 'a -> unit

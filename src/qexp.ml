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

type t =
  | Atom of string
  | Keyword of string
  | String of string
  | Integer of int
  | Float of float
  | Node of t list


let node tokens = Node tokens
let keyword kwd = Keyword kwd
let atom kwd = Atom kwd
let string str = String str
let integer nb = Integer nb
let float nb = Float nb

let of_stream stream =
  Atom ""

let of_string string =
  string
  |> Stream.of_string
  |> of_stream

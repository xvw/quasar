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

let add elt = Dom.appendChild (document##.head) elt

let add_stylesheet uri =
  let s   = String.js uri in
  let css = Dom_html.createLink document in
  let _   = css##setAttribute (String.js "rel") (String.js "stylesheet") in
  let _   = css##setAttribute (String.js "type") (String.js "text/css") in
  let _   = css##setAttribute (String.js "href") s in
  add css

let add_css stl =
  let style = Dom_html.createStyle document in
  let _     = style##setAttribute (String.js "type") (String.js "text/css") in
  let _     = Dom.appendChild style (QuaElement.text stl) in
  add style

  



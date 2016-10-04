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

let add ~prepend elt =
  let parent = document##.head in 
  if prepend then  Dom.insertBefore parent elt (parent##.firstChild)
  else Dom.appendChild parent elt

let add_stylesheet ?(prepend=false) uri =
  let s   = String.js uri in
  let css = Dom_html.createLink document in
  let _   = css##setAttribute
      (String.js "rel")
      (String.js "stylesheet") in
  let _   = css##setAttribute
      (String.js "type")
      (String.js "text/css") in
  let _   = css##setAttribute
      (String.js "href") s in
  add ~prepend css

let add_css ?(prepend=false) stl =
  let style = Dom_html.createStyle document in
  let _     = style##setAttribute
      (String.js "type")
      (String.js "text/css") in
  let _     =
    Dom.appendChild
      style
      (QuaElement.text stl) in
  add ~prepend style

let add_script ?(prepend=false) uri =
  let script = Dom_html.createScript document in
  let _      =
    script##setAttribute
      (String.js "src")
      (String.js uri) in
  let _      = script##setAttribute
      (String.js "type")
      (String.js "application/javascript") in
  add ~prepend script

let add_js ?(prepend=false) scr =
  let script = Dom_html.createScript document in
  let _      = script##setAttribute
      (String.js "type")
      (String.js "application/javascript") in
  let _      = QuaElement.(Dom.appendChild script (text scr)) in
  add  ~prepend script


module Fx =
struct

  let c name li =
    (List.fold_left
       (fun a (b,c) -> a ^ b ^ ":" ^ c ^ ";")
       (name^"{")li) ^ "}\n"
      

  let text_glitch =
    c ".quasar-glitched-text, .fxglitch" [
      "position", "relative"
      ; 
    ]

  let rect () =
    Printf.sprintf "rect(%dpx, 99999999px, %dpx, 0)"
      (Random.int 100)
      (Random.int 100)

  let keyframe_glitch x =
    List.fold_left
      (fun acc coeff ->
         acc
         ^ (c (Printf.sprintf "%d%%" (coeff*10))
              ["clip", rect ()])
      )
      (Printf.sprintf "@keyframes quasar-glitch%d {\n" x)
      (0 --> 10)
    ^ "}\n"
    

  let after =
    c ".quasar-glitched-text::after,.fxglitch::after" [
      "position", "absolute"
    ; "top", "0"
    ; "left", "2px"
    ; "width", "100%"
    ; "height", "100%"
    ; "content", "attr(data-quasar-glitch)"
    ; "animation", "quasar-glitch2 2s infinite linear alternate-reverse"
    ; "background-color", "#000"
    ; "text-shadow", "-1px 0 red"
    ; "clip", "rect(à, 999999px, 0, 0)"
                           
    ]

  let before =
    c ".quasar-glitched-text::before,.fxglitch::before" [
      "position", "absolute"
    ; "top", "0"
    ; "left", "-2px"
    ; "width", "100%"
    ; "height", "100%"
    ; "content", "attr(data-quasar-glitch)"
    ; "animation", "quasar-glitch1 2s infinite linear alternate-reverse"
    ; "background-color", "#000"
    ; "text-shadow", "-1px 0 blue"
    ; "clip", "rect(à, 999999px, 0, 0)"
    ]
      
  let before = ""

  let use () =
    Random.self_init ()
    &: add_css ~prepend:true $
    text_glitch
    ^ keyframe_glitch 1
    ^ keyframe_glitch 2
    ^ after
    ^ before

end




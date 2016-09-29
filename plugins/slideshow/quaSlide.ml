(*
 * Quasar.slideshow
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

  val selector : string
  val parent : Element.t

  val before :
    length:int
    -> slides:(Element.t list)
    -> int ref
    -> unit
    
  val init_slide :
    length:int
    -> slides:(Element.t list)
    -> Element.t
    -> unit

  val succ : length:int -> slides:(Element.t list) -> int ref -> bool 
  val pred : length:int -> slides:(Element.t list) -> int ref -> bool
  val update : length:int -> slides:(Element.t list) -> int ref -> unit

  val deal_with_data : (string * (Quasar.Element.t -> string -> unit)) list


end

module Simple (M :  Configuration) =
struct

  include M

  let cursor = ref 0
  let set_cursor x = cursor := x

  let match_data () =
    let nodes = Element.all () in
    List.iter (fun elt ->
        List.iter (fun (attr, f) ->
            match Element.get_data attr elt with
            | None   -> ()
            | Some x -> f elt x 
          ) deal_with_data
      ) nodes

  let move ~length ~slides amount =
    if amount = 0 then true
    else let result = ref false in
      if amount > 0 then begin
        for i = 0 to amount do
          result := succ ~length ~slides cursor
        done; !result
      end
      else begin for i = amount to 0 do
          result := pred ~length ~slides cursor
        done; !result end
        

  let get_slides () =
    Element.find_all parent selector

  let init_slides ~length ~slides () =
    List.iter (init_slide ~length ~slides) slides


  let start () =
    let s = get_slides () in
    let l = List.length s in
    
    let _ = before        ~length:l ~slides:s cursor in
    let _ = init_slides   ~length:l ~slides:s () in
    let _ = match_data () in
    update  ~length:l ~slides:s cursor

end

let default_succ ~length ~slides cursor =
  let c = !cursor in
  if c > length-1 then false
  else let _ = incr cursor in true

let default_pred  ~length ~slides cursor =
  let c = !cursor in
  if c < 1 then false
  else let _ = decr cursor in true

let default_update ~length ~slides cursor =
  let current_div = List.nth slides !cursor in
  let () = List.iter (fun x ->
      Element.remove_class "quasar_slide_active" x
      |> Element.add_class "quasar_slide_inactive"
      |> ignore) slides                 
  in
  let _ =
    Element.remove_class "quasar_slide_inactive" current_div
    |> Element.add_class "quasar_slide_active"
  in ()

let default_before ~length ~slides cursor =
  let () =
    let hash = Url.get_hash () in
    let c =
      try Scanf.sscanf hash "%d" id with
      | _ -> 0
    in cursor := c in
  let _ = Event.(async Listener.keyup document (fun e _ ->
      Lwt.return begin
        match e##.keyCode with
        | 39 ->
          let _ = default_succ ~length ~slides cursor in
          default_update ~length ~slides cursor
        | 37 ->
          let _ = default_pred ~length ~slides cursor in
          default_update ~length ~slides cursor
        | _  -> ()
      end 
    ))
  in ()


module Default = Simple(struct

    let selector = "slide"
    let parent = Element.getById "slides"
    let before = default_before
    let init_slide = fun ~length ~slides _ -> ()
    let succ = default_succ
    let pred = default_pred
    let update = default_update
    let deal_with_data = []

  end)

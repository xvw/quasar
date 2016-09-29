open Quasar
module S = QuaSlideshow
  
module Slideshow = S.Simple(struct

    let selector       = ".quasar-slide"
    let parent         = Element.getById "quasar-slides"
    let deal_with_data = []
    let succ           = S.default_succ
    let pred           = S.default_pred
    let init_slide     = fun ~length ~slides _  -> ()


    let perform_section elt slides cursor =
      let slide = List.nth slides !cursor in
      match Element.get_data "section" slide with
      | None -> ()
      | Some value ->
        Dom.appendChild
          (Element.clean elt)
          (Element.text value)
                          
    
    let update ~length ~slides cursor =
      let open Element in
      let _ = S.default_update ~length ~slides cursor in
      let () =
        match getById_opt "pagination" with
        | None -> ()
        | Some elt ->
          Dom.appendChild
            (clean elt)
            (text $ Printf.sprintf "%d/%d" (!cursor+1) length) in
      match getById_opt "section" with
      | None -> ()
      | Some elt -> perform_section elt slides cursor
        

    let before ~length ~slides cursor =
      S.default_before ~length ~slides cursor update
                           

  end)
    
let () = Slideshow.start ()


open Quasar
module S = QuaSlideshow
  
module Slideshow = S.Simple(struct

    let selector       = ".quasar-slide"
    let parent         = Element.getById "quasar-slides"
    let deal_with_data = []
    let succ           = S.default_succ
    let pred           = S.default_pred
    let init_slide     = fun ~length ~slides _  -> ()
                          
    
    let update ~length ~slides cursor =
      let open Element in
      let _ = S.default_update ~length ~slides cursor in
      match getById_opt "footer" with
      | None -> ()
      | Some elt ->
        Dom.appendChild
          (clean elt)
          (text $ Printf.sprintf "%d/%d" (!cursor+1) length)

    let before ~length ~slides cursor =
      S.default_before ~length ~slides cursor update
                           

  end)
    
let () = Slideshow.start ()


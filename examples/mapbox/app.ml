open Quasar
open Html


module Mapbox = QuaMapbox.Connect(struct
    let access_token = Config.api_key
  end)
    


let uri lon lat zoom =
  Mapbox.static
    ~longitude:lon
    ~latitude:lat
    ~zoom:zoom
    ~width:700
    ~height:350
    ()



let insert_a_map parent lon lat zoom =
  let u = uri lon lat zoom in
  let img = [%html"<img src='"u"' alt='test'>"] in
  Element.(clean parent <+> !!img)
  |> ignore

let routing parent () =
  match [%routes] with
  | [%route "map-{float}-{float}-{int}"] ->
    let lon, lat, zoom = route_arguments () in
    log "route";
    insert_a_map parent lon lat zoom
  | "dynamic" ->
    log "route dynamic"
  | _ -> ()
  

let () = start (fun () ->
    match Element.getById_opt "app" with
    | None        -> alert "Unable to boot the application"
    | Some parent ->
      Static.Fx.use ()
      &: Router.start (routing parent)
  )

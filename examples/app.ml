open Quasar

let router app () =
  let open Element in

  let p text =
    let x = Html.pcdata text in
    !![%html "<p>"[x]"</p>"] in

  let i = 99 in 
  
  match [%quasar.routes] with
  | [%quasar.route "foo"]             -> app <+> p "page foo"
  | [%quasar.route "bar"] when i > 10 -> app <+> p "page bar"
  | ""                                -> app <+> p "page index"
  | _                                 -> app <+> p "unknown page"
    
    

let () =
  match Element.getById_opt "app" with
  | None     -> alert "unable to start"
  | Some app -> Router.start (router app)

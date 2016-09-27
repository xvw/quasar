open Quasar

let router app () =

  let page app text =
    let x = Html.pcdata text in
    Element.((clean app) <+> !![%html "<p>"[x]"</p>"])
    |> ignore
  in

  
  match [%routes] with
  | "hello"                          ->  page app "Hello World"
  | [%route "hello-{string}"] ->  page app ("Hello "^(route_arguments ()))
  | ""                               ->  page app "Index du site"
  | _                                ->  page app "Page inconnue"
    
    

let () =
  start (fun () ->
      match Element.getById_opt "app" with
      | None     -> alert "unable to start"
      | Some app -> Router.start (router app)
    )

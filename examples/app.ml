open Quasar

let router app () =

  let page app text =
    let x = Html.pcdata text in
    Element.((clean app) <+> !![%html "<p>"[x]"</p>"])
  in

  
  match [%quasar.routes] with
  
  | [%quasar.route "hello-{string}-{int}"]  ->
    let name, age = route_arguments () in
    page app (Printf.sprintf "Hello %s, tu as %d ans" name age)
    |> ignore
    

  | [%quasar.route "auth-{bool}-{int}"] ->
    let auth, age = route_arguments () in
    if auth && (age >= 18) then
      page app "Bienvenue"
      |> ignore
    else
      page app "Interdit !"
      |> ignore
         


  | "load" ->
    Ajax.get_text
      "https://xvw.github.io"
      (fun x -> alert x)
      

  | ""  ->  page app "Index du site" |> ignore
  | _   ->  page app "Page inconnue" |> ignore
    
    

let () =
  start (fun () ->
      match Element.getById_opt "app" with
      | None     -> alert "unable to start"
      | Some app -> Router.start (router app)
    )

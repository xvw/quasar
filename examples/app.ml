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
    begin
      try
        Ajax.(
          get "http://jsonplaceholder.typicode.com/posts/1"
          >>= (fun x -> page app x.content; Lwt.return_unit)
          >>  post "http://jsonplaceholder.typicode.com/posts"
          >>= (fun x -> alert x.content; Lwt.return_unit)
          |> ignore
        )
      with _ -> alert "erf"
    end
    

  | ""  ->  page app "Index du site" |> ignore
  | _   ->  page app "Page inconnue" |> ignore
    
    

let () =
  start (fun () ->
      match Element.getById_opt "app" with
      | None     -> alert "unable to start"
      | Some app -> Router.start (router app)
    )

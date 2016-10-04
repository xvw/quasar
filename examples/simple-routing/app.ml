open Quasar
open Html

let simple_h1 txt =
  !!(h1 [pcdata txt])

let index parent txt =
  let _ = Element.(
      clean parent
      <+> simple_h1 txt
    )
  in ()


let hello parent name =
  index parent ("Hello "^name)


let age parent a name =
  let str = string_of_int a in
  index parent ("Hello "^name^", you are "^str^" old !")


let error404 parent =
  index parent "404 Error"
  
                      

let routes parent () =
  match [%routes] with
  | "" -> index parent "Hello World"
            
  | [%route "hello-{string}"] ->
    let name = route_arguments () in
    hello parent name

  | [%route "age-{int}-name-{string}"] ->
    let a, name = route_arguments () in
    age parent a name
  
  | _  -> error404 parent


let () = start (fun () ->
    match Element.getById_opt "app" with
    | None        -> alert "Unable to boot the application"
    | Some parent ->
      Router.start (routes parent) 
  )

open Quasar

type test = {
  id: int
; name: string
} [@@deriving yojson]

let t = test_to_yojson {id = 1; name = "Nuki"} 

let _ =
  match Element.getById_opt "app" with
  | Some main_div ->
    let open Element in
    let open Html in
    let but = !![%html "<input type='button' value='test'>"] in
    let _ = log (String.js (String.of_json t)) in
    let _ = main_div <+> but in
    let _ = begin 
      match [%quasar.routes] with
      | "news" -> alert "news"
      | "user" -> alert "user"
      | _ -> alert "nothing"
    end
    in ()
    
  | None -> alert "unable to found app div"



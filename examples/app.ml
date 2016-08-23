open Quasar

let _ =
  match Element.getById_opt "app" with
  | Some main_div ->
    let open Element in
    let open Html in
      main_div
      <+> (!!(div [pcdata "Hello"]) <+> !!(pcdata " World"))
      <|> add_class "hello-world" !!(div [pcdata "Prepended Hello"])
      <+> set_data "hello" "world" !!(div [pcdata "Node with data"])
  |> ignore
  | None -> alert "unable to found app div"

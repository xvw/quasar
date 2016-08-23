open Quasar

let _ =
  let _ = alert "Test" in
  match Element.getById_opt "app" with
  | Some main ->
    let tplt = Html.(div [pcdata "Hello World"]) in
    Element.(main <+> !!tplt)
    |> ignore
  | None -> alert "Error"

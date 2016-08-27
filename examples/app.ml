open Quasar

let _ =
  match Element.getById_opt "app" with
  | Some main_div ->
    let open Element in
    let open Html in
    let but = !![%html "<input type='button' value='test'>"] in
    let _ = main_div <+> but in
    Event.(
      sequential
        Listener.click
        but
        (handler (fun _ -> alert "lol"))
    ) |> ignore
  | None -> alert "unable to found app div"




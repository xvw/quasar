open Js_of_ocaml
open Quasar_js.Util
open Jest

let () =
  test "to_be 1" (fun () -> (expect 42).%{to_be} <- 42);
  test "to_be 2" (fun () -> (not $ expect 42).%{to_be} <- 43);
  test "to_be_null 1" (fun () -> (expect Js.Opt.empty).%{to_be_null});
  test "to_be_null 2" (fun () ->
      (not (expect $ Js.Opt.return 42)).%{to_be_null})
;;

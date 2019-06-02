open Js_of_ocaml

let require module_name =
  let open Js.Unsafe in
  fun_call (js_expr "require") [| inject (Js.string module_name) |]
;;

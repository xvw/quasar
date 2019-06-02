open Js_of_ocaml

let test message action =
  let open Js.Unsafe in
  fun_call
    (js_expr "test")
    [| inject (Js.string message)
     ; inject (Js.wrap_callback action)
    |]
;;

let expect value =
  let open Js.Unsafe in
  fun_call (js_expr "expect") [| inject value |]
;;

let to_be e x = e##toBe x
let to_equal e x = e##toEqual x
let ( .%{}<- ) expected driver value = driver expected value

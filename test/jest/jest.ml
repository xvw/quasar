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

let ( .%{}<- ) expected driver value = driver expected value
let ( .%{} ) expected driver = driver expected
let not e = e##.not
let to_be e x = e##toBe x
let to_equal e x = e##toEqual x
let to_be_null e = e##toBeNull
let to_be_defined e = e##toBeDefined
let to_be_undefined e = e##toBeUndefined
let to_be_truthy e = e##toBeTruthy
let to_be_falsy e = e##toBeFalsy
let to_be_greather_than e x = e##toBeGreaterThan x
let to_be_greather_than_or_equal e x = e##toBeGreaterThanOrEqual x
let to_be_less_than e x = e##toBeLessThan x
let to_be_less_than_or_equal e x = e##toBeLessThanOrEqual x
let to_be_close_to e x = e##toBeCloseTo x

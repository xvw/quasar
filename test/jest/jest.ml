open Js_of_ocaml

class type ['a] expected =
  object
    method not : 'a expected Js.t Js.readonly_prop

    method toBe : 'a -> unit Js.meth

    method toEqual : 'a -> unit Js.meth

    method toStrictEqual : 'a -> unit Js.meth

    method toBeNull : unit Js.meth

    method toBeDefined : unit Js.meth

    method toBeUndefined : unit Js.meth

    method toBeTruthy : unit Js.meth

    method toBeFalsy : unit Js.meth

    method toBeGreaterThan : 'a -> unit Js.meth

    method toBeGreaterThanOrEqual : 'a -> unit Js.meth

    method toBeLessThan : 'a -> unit Js.meth

    method toBeLessThanOrEqual : 'a -> unit Js.meth

    method toBeCloseTo : float -> unit Js.meth

    method toThrow : Js.error Js.t Js.Optdef.t -> unit Js.meth
  end

let describe message test_list =
  let open Js.Unsafe in
  fun_call
    (js_expr "describe")
    [| inject (Js.string message)
     ; inject (Js.wrap_callback test_list)
    |]
;;

let test message action =
  let open Js.Unsafe in
  fun_call
    global##.test
    [| inject (Js.string message)
     ; inject (Js.wrap_callback action)
    |]
  |> ignore
;;

let expect value =
  let open Js.Unsafe in
  fun_call global##.expect [| inject value |]
;;

let ( .%{}<- ) expected driver value = driver expected value
let ( .%{} ) expected driver = driver expected
let not e = e##.not
let to_be e x = e##toBe x
let to_equal e x = e##toEqual x
let to_strict_equal e x = e##toStrictEqual x
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
let to_throw e = e##toThrow Js.Optdef.empty
let to_throw_error e error = e##toThrow (Js.Optdef.return error)

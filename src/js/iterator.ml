open Js_of_ocaml

class type ['a] step_js =
  object
    method _done : bool Js.t Js.readonly_prop

    method value : 'a Js.Optdef.t Js.readonly_prop
  end

class type ['a] js =
  object
    method next : 'a step_js Js.t Js.meth
  end

type 'a step =
  | Done
  | No_value
  | Value of 'a

type 'a t = 'a js Js.t

let next (iterator : 'a t) =
  let step = iterator##next in
  let is_done = Js.to_bool step##._done in
  let value = step##.value in
  if is_done
  then Done
  else Js.Optdef.case value (fun () -> No_value) (fun x -> Value x)
;;

let rec iter f iterator =
  match next iterator with
  | Done | No_value ->
    ()
  | Value value ->
    let () = f value in
    iter f iterator
;;

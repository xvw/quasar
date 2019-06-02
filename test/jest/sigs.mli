(** Interfaces *)
open Js_of_ocaml

class type ['a] expected =
  object
    method not : 'a expected Js.t Js.readonly_prop

    method toBe : 'a -> unit Js.meth

    method toEqual : 'a -> unit Js.meth

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
  end

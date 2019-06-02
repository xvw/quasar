(** Interfaces *)
open Js_of_ocaml

class type ['a] expected =
  object
    method toBe : 'a -> unit Js.meth

    method toEqual : 'a -> unit Js.meth
  end

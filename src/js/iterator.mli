(** Iterator implementation. *)

open Js_of_ocaml

(** {3 JavaScript boilerplate} *)

class type ['a] step_js =
  object
    method _done : bool Js.t Js.readonly_prop

    method value : 'a Js.Optdef.t Js.readonly_prop
  end

class type ['a] js =
  object
    method next : 'a step_js Js.t Js.meth
  end

(** {2 Types} *)

(** A JavaScript iterator. *)
type 'a t = 'a js Js.t

(** A Step of an iteration. *)
type 'a step =
  | Done
  | No_value
  | Value of 'a

(** {2 API} *)

(** Returns the next value of the iterator. *)
val next : 'a t -> 'a step

(** Same of [for ... to ...] in JavaScript. *)
val iter : ('a -> unit) -> 'a t -> unit

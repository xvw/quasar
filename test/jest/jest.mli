(** Partial binding of {{: https://jestjs.io }  Jest }*)

open Js_of_ocaml

(** {2 Js objects} *)

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

(** {2 API} *)

val describe : string -> (unit -> unit) -> unit
val test : string -> (unit -> unit) -> unit
val expect : 'a -> 'a expected Js.t

val ( .%{}<- )
  :  'a expected Js.t ->
  ('a expected Js.t -> 'a -> unit) ->
  'a ->
  unit

val ( .%{} ) : 'a expected Js.t -> ('a expected Js.t -> unit) -> unit

(** {3 Matchers} *)

val not : 'a expected Js.t -> 'a expected Js.t
val to_be : 'a expected Js.t -> 'a -> unit
val to_equal : 'a expected Js.t -> 'a -> unit
val to_strict_equal : 'a expected Js.t -> 'a -> unit
val to_be_null : 'a Js.Opt.t expected Js.t -> unit
val to_be_defined : 'a Js.Optdef.t expected Js.t -> unit
val to_be_undefined : 'a Js.Optdef.t expected Js.t -> unit
val to_be_truthy : bool Js.t expected Js.t -> unit
val to_be_falsy : bool Js.t expected Js.t -> unit
val to_be_greather_than : 'a expected Js.t -> 'a -> unit
val to_be_greather_than_or_equal : 'a expected Js.t -> 'a -> unit
val to_be_less_than : 'a expected Js.t -> 'a -> unit
val to_be_less_than_or_equal : 'a expected Js.t -> 'a -> unit
val to_be_close_to : float expected Js.t -> float -> unit
val to_throw : 'a expected Js.t -> unit
val to_throw_error : 'a expected Js.t -> Js.error Js.t -> unit

(** {2 Toplevel API} *)

val ( ! ) : 'a expected Js.t -> 'a expected Js.t
val ( <=> ) : 'a -> 'a -> unit
val ( = ) : 'a -> 'a -> unit
val ( == ) : 'a -> 'a -> unit
val ( !<=> ) : 'a -> 'a -> unit
val ( <> ) : 'a -> 'a -> unit
val ( != ) : 'a -> 'a -> unit

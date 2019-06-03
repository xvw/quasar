(** Partial binding of {{: https://jestjs.io }  Jest }*)

open Js_of_ocaml

(** {2 API} *)

val describe : string -> (unit -> unit) -> unit
val test : string -> (unit -> unit) -> unit
val expect : 'a -> 'a Sigs.expected Js.t

val ( .%{}<- )
  :  'a Sigs.expected Js.t
  -> ('a Sigs.expected Js.t -> 'a -> unit)
  -> 'a
  -> unit

val ( .%{} )
  :  'a Sigs.expected Js.t
  -> ('a Sigs.expected Js.t -> unit)
  -> unit

(** {3 Matchers} *)

val not : 'a Sigs.expected Js.t -> 'a Sigs.expected Js.t
val to_be : 'a Sigs.expected Js.t -> 'a -> unit
val to_equal : 'a Sigs.expected Js.t -> 'a -> unit
val to_be_null : 'a Js.Opt.t Sigs.expected Js.t -> unit
val to_be_defined : 'a Js.Optdef.t Sigs.expected Js.t -> unit
val to_be_undefined : 'a Js.Optdef.t Sigs.expected Js.t -> unit
val to_be_truthy : bool Js.t Sigs.expected Js.t -> unit
val to_be_falsy : bool Js.t Sigs.expected Js.t -> unit
val to_be_greather_than : 'a Sigs.expected Js.t -> 'a -> unit

val to_be_greather_than_or_equal
  :  'a Sigs.expected Js.t
  -> 'a
  -> unit

val to_be_less_than : 'a Sigs.expected Js.t -> 'a -> unit
val to_be_less_than_or_equal : 'a Sigs.expected Js.t -> 'a -> unit
val to_be_close_to : float Sigs.expected Js.t -> float -> unit

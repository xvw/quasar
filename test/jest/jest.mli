(** Partial binding of {{: https://jestjs.io }  Jest }*)

open Js_of_ocaml

(** {2 API} *)

val test : string -> (unit -> unit) -> unit
val expect : 'a -> 'a Sigs.expected Js.t
val to_be : 'a Sigs.expected Js.t -> 'a -> unit
val to_equal : 'a Sigs.expected Js.t -> 'a -> unit

val ( .%{}<- )
  :  'a Sigs.expected Js.t
  -> ('a Sigs.expected Js.t -> 'a -> unit)
  -> 'a
  -> unit

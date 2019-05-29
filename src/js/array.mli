(** Extension for JavaScript Array to deal with OCaml's Lists and Arrays.

    {3 Convention}
    - [array] reference OCaml arrays;
    - [js_array] reference JavaScript arrays;
    - [list] reference OCaml list.

*)

open Js_of_ocaml

(** {2 Types and errors} *)

(** ['a Quasar_js.Array.t] is an alias for ['a Js.js_array Js.t]. *)
type 'a t = 'a Js.js_array Js.t

(** Error emitted when an index is not available. *)
val unbound_index : int -> Error.t

(** {2 Array creation} *)

(** [Array.empty ()] returns a fresh empty array. *)
val empty : unit -> 'a t

(** [Array.prefilled n x] returns a fresh array of length [n], initialized 
    with [x].
*)
val prefilled : int -> 'a -> 'a t

(** [Array.from_array f ocaml_array] returns the [js_array] of an ocaml [array]
    where [f] is applied on each cell of the ocaml [array].
*)
val from_array : ('a -> 'b) -> 'a array -> 'b t

(** [Array.from_list f ocaml_list] returns the [js_array] of an ocaml [list].
    where [f] is applied on each element of the list.
*)
val from_list : ('a -> 'b) -> 'a list -> 'b t

(** {2 Array conversion} *)

(** [Array.to_array] returns the ocaml [array] of a [js_array] where [f] is 
    applied on each cell of the [js_array].
*)
val to_array : ('a -> 'b) -> 'a t -> 'b array

(** [Array.to_list] returns the ocaml [list] of a [js_array] where [f] is 
    applied on each cell of the [js_array].
*)
val to_list : ('a -> 'b) -> 'a t -> 'b list

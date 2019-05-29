(** Extension for JavaScript Array to deal with OCaml's Lists and Arrays.

    {3 Convention}
    - [array] reference OCaml arrays;
    - [js_array] reference JavaScript arrays;
    - [list] reference OCaml list.

*)

open Js_of_ocaml

(** {2 Types} *)

(** ['a Quasar_js.Array.t] is an alias for ['a Js.js_array Js.t]. *)
type 'a t = 'a Js.js_array Js.t

(** {2 Array creation} *)

(** [Array.empty ()] returns a fresh empty array. *)
val empty : unit -> 'a t

(** [Array.init n f] returns a fresh array of length [n]  with element number 
    [i] initialized to the result of [f i]. *)
val init : int -> (int -> 'a) -> 'a t

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

(** {2 Access and mutation} *)

(** [Array.get array i] try to returns the [i]-nd values of [array]. *)
val get : 'a t -> int -> 'a option

(** [Array.unsafe_get array i] returns the [i]-nd values of [array]. *)
val unsafe_get : 'a t -> int -> 'a

(** [Array.set array i x] replace the [i]-nd values of [array] by [x]. *)
val set : 'a t -> int -> 'a -> unit

(** Alias of [Array.get], used like that : [js_array.%[index]] is 
    [Array.get js_array index]. 
*)
val ( .%[] ) : 'a t -> int -> 'a option

(** Alias of [Array.set], used like that : [js_array.%[index] <- x] is
    [Array.set js_array index value]
*)
val ( .%[]<- ) : 'a t -> int -> 'a -> unit

(** Alias of [Array.unsafe_get], used like that : [js_array.![index]] is 
    [Array.unsafe_get js_array index]. 
*)
val ( .![] ) : 'a t -> int -> 'a

(** {2 Array conversion} *)

(** [Array.to_array] returns the ocaml [array] of a [js_array] where [f] is 
    applied on each cell of the [js_array].
*)
val to_array : ('a -> 'b) -> 'a t -> 'b array

(** [Array.to_list] returns the ocaml [list] of a [js_array] where [f] is 
    applied on each cell of the [js_array].
*)
val to_list : ('a -> 'b) -> 'a t -> 'b list

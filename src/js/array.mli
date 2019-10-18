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

(** {2 API} *)

(** {3 Creation} *)

(** [Array.empty ()] returns a fresh empty array. *)
val empty : unit -> 'a t

(** [Array.init n f] returns a fresh array of length [n]  with element number 
    [i] initialized to the result of [f i]. *)
val init : int -> (int -> 'a) -> 'a t

(** [Array.make n x] returns a fresh array of length [n], initialized 
    with [x].
*)
val make : int -> 'a -> 'a t

(** [Array.from_array f ocaml_array] returns the [js_array] of an ocaml [array]
    where [f] is applied on each cell of the ocaml [array].
*)
val from_array : ('a -> 'b) -> 'a array -> 'b t

(** [Array.from_list f ocaml_list] returns the [js_array] of an ocaml [list].
    where [f] is applied on each element of the list.
*)
val from_list : ('a -> 'b) -> 'a list -> 'b t

(** {3 Access, mutation, merge} *)

(** Return the length (number of elements) of the given [js_array]. *)
val length : 'a t -> int

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

(** [Array.fill arr x] replace each value of [arr] with [x]. *)
val fill : 'a t -> 'b -> 'b t

(** [Array.fill_from arr i x] replace each value of [arr] from
    [i] with [x]. 
*)
val fill_from : 'a t -> int -> 'a -> 'a t

(** [Array.fill_between arr i j x] replace each value between [i] and [j]
    with [x].
*)
val fill_between : 'a t -> int -> int -> 'a -> 'a t

(** [Array.push js_array x] add [x] at the end of [js_array] and returns
    the new length of the array.
 *)
val push : 'a t -> 'a -> int

(** [Array.pop js_array] remove and returns the last element of 
    [js_array]. 
*)
val pop : 'a t -> 'a option

(** [Array.shift js_array] remove and returns the first element of 
    [js_array]. 
*)
val shift : 'a t -> 'a option

(** [Array.append array_a array_b] returns a fresh array containing 
    the concatenation of the arrays [array_a] and [array_b]. 
*)
val append : 'a t -> 'a t -> 'a t

(** Concatenate a [js_array] of [js_array]. The elements of the argument
    are all concatenated together (in the same order) to give the result. 
*)
val flatten : 'a t t -> 'a t

(** {3 Conversion} *)

(** [Array.to_array] returns the ocaml [array] of a [js_array] where [f] is 
    applied on each cell of the [js_array].
*)
val to_array : ('a -> 'b) -> 'a t -> 'b array

(** [Array.to_list] returns the ocaml [list] of a [js_array] where [f] is 
    applied on each cell of the [js_array].
*)
val to_list : ('a -> 'b) -> 'a t -> 'b list

(** {3 Iterators} *)

(** [Array.iter f a] applies [f] in turn to all the elements of [a]. 
    It is equivalent to [f a.(0); f a.(1); ...; f a.(Array.length a - 1); ()]. 
*)
val iter : ('a -> unit) -> 'a t -> unit

(** Same as [Array.iter], but the function is applied with the index of 
    the element as first argument, and the element itself as second argument. 
*)
val iteri : (int -> 'a -> unit) -> 'a t -> unit

(** Mapping over [js_array]. *)
val map : ('a -> 'b) -> 'a t -> 'b t

(** Mapping over [js_array] with index has first callback parameter. *)
val mapi : (int -> 'a -> 'b) -> 'a t -> 'b t

(** [Array.fold_left f x] a computes [f (... (f (f x a.(0)) a.(1)) ...) 
    a.(n-1)], where n is the length of the array [a]. 
*)
val fold_left : ('a -> 'b -> 'a) -> 'a -> 'b t -> 'a

(** [Array.fold_right f a x] computes [f a.(0) 
    (f a.(1) ( ... (f a.(n-1) x) ...))], where n is the length of 
    the array [a].
*)
val fold_right : ('a -> 'b -> 'b) -> 'a t -> 'b -> 'b

(** {3 Scanning} *)

(** Checks if all elements of the array satisfy a predicate. *)
val for_all : ('a -> bool) -> 'a t -> bool

(** Checks if at least one element of the array satisfies a predicate. *)
val exists : ('a -> bool) -> 'a t -> bool

(** Creates a new array with all elements that pass the test implemented
    by the provided function. 
*)
val filter : ('a -> bool) -> 'a t -> 'a t

(** Creates a new array with all elements that pass the test implemented
    by the provided function (with index). 
*)
val filteri : (int -> 'a -> bool) -> 'a t -> 'a t

(** {3 Sorting} *)

(** Sort an array in increasing order according to a comparison function. 
    The comparison function must return 0 if its arguments compare as 
    equal, a positive integer if the first is greater, and a negative 
    integer if the first is smaller (see below for a complete specification). 
*)
val sort : ('a -> 'a -> int) -> 'a t -> 'a t

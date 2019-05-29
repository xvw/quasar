(** Deal with JavaScript's errors. *)

open Js_of_ocaml

(** {2 Types} *)

type t = Js.error Js.t

(** {2 Error creation} *)

(** [Error.make "foobar"] returns an error with the message [foobar]. *)
val make : ?name:string -> string -> t

(** {2 Error raising} *)

(** [Error.raise e] raises [e] as a JavaScript error. *)
val raise : t -> 'a

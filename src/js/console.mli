(** Generic Console Binding. *)

(** {2 API} *)

(** Log value on [console]. *)
val log : 'a -> unit

(** Print [string] on [console]. *)
val print : string -> unit

(** Clear [console]. *)
val clear : unit -> unit

(** Log error on [console]. *)
val error : 'a -> unit

(** Log warning on [console]. *)
val warning : 'a -> unit

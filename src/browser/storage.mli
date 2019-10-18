(** Deal with Local and Session storage. *)

open Js_of_ocaml

(** {2 Types} *)

(** Shortcut for [Dom_html.storage Js.t]. *)
type t = Dom_html.storage Js.t

(** Event fired by storage mutation. *)
type event =  Dom_html.storageEvent Js.t

(** {2 Events} *)

(** Storage event. *)
val event: event Dom_events.Typ.typ


(** {2 Exceptions} *)

(** Raised if the Storage is not supported by the browser. *)
exception Not_supported

(** This exception will be raised in particular case of conversion. *)
exception Not_found

(** {2 Abstract API} *)

(** The basic interface of a storage handler. 
    A Storage is basically a Key/Value store, using [string] for 
    the keys and the values.  This implémentation is a low-level 
    binding for the API. 
    The library uses [Hashtbl.t] as an output format for filtering.
*)
module type STORAGE = 
sig 

  type key = string 
  type value = string
  type old_value = string
  type url = string

  (** This type represents a changeset on the storage *)
  type change_state = 
    | Clear
    | Insert of key * value 
    | Remove of key * old_value 
    | Update of key * old_value * value


  (** Dump a changestate (mainly for debugging) *)
  val dump_change_state : change_state -> string


  (** [is_supported ()] returns [true] if the current storage is 
      supported by the browser, false otherwise.
   *)
  val is_supported: unit -> bool

  (** Returns the JavaScript's representation of the storage object *)
  val handler: t

  (** The length read-only property of the Storage interface returns an 
      integer representing the number of data items stored in the Storage object.
  *)
  val length: unit -> int

  (** When passed a key name, will return that key's value.  (Wrapped into an option) *)
  val get: key -> value option

  (**  When passed a key name and value, will add that key to the storage, 
       or update that key's value if it already exists.)
  *)
  val set: key -> value -> unit

  (** When passed a key name, will remove that key from the storage. *)
  val remove: key -> unit 

  (**  When invoked, clears all stored keys. *)
  val clear: unit -> unit

  (** When passed a number n, returns the name of the nth key in the storage. 
      The order of keys is [user-agent] defined, so you should not rely on it. *)
  val key: int -> key option

  (** Returns the couple Key/Value at a specific position  *)
  val at: int -> (key * value) option

  (** Produce an [Hashtbl.t] from a Storage *)
  val to_hashtbl: unit -> (key, value) Hashtbl.t

  (** applies function f on each key/value of a storage *)
  val iter: (key -> value -> unit) -> unit

  (** [find p] returns the first element of the storage that satisfies the predicate [p]. 
      The result is wrapped into an option.
  *)
  val find: (key -> value -> bool) -> (key * value) option


  (** [select p] returns all the elements of the storage that satisfy the predicate [p]. 
      The results is an [Hashtbl.t] of the results.
  *)
  val select: (key -> value -> bool) -> (key, value) Hashtbl.t

  (** [on_change f] trigger [f] at each changement of the storage. (You can use a [prefix]
      to trigger the events only if it concerns a set of keys (with the gived prefix)) 
  *)
  val on_change : 
    ?prefix:string 
    -> (change_state -> url -> unit) 
    -> Dom.event_listener_id


  (** [on_clear f] trigger [f] at each clear of the storage.  *)
  val on_clear: (url -> unit) -> Dom.event_listener_id


  (** [on_insert f] trigger [f] at each insertion in the storage. (You can use a [prefix]
      to trigger the events only if it concerns a set of keys (with the gived prefix)) 
  *)
  val on_insert:
    ?prefix:string  
    -> (key -> value -> url -> unit)
    -> Dom.event_listener_id

  (** [on_remove f] trigger [f] at each remove in the storage. (You can use a [prefix]
      to trigger the events only if it concerns a set of keys (with the gived prefix)) 
  *)
  val on_remove:
    ?prefix:string  
    -> (key -> old_value -> url -> unit)
    -> Dom.event_listener_id

  (** [on_update f] trigger [f] at each key update in the storage. (You can use a [prefix]
      to trigger the events only if it concerns a set of keys (with the gived prefix)) 
  *)
  val on_update:
    ?prefix:string  
    -> (key -> old_value -> value -> url -> unit)
    -> Dom.event_listener_id

end


(** {2 Concrete implementation} *)

(** Support for [LocalStorage] *)
module Local : STORAGE

(** Support for [SessionStorage] *) 
module Session : STORAGE

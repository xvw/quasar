(** Generic Console Binding. *)

(** {2 API} *)

(** {3 Log/Print} *)

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

(** {3 Counters} *)

(** If supplied, [Console.count ~label ()] outputs the number of times 
    it has been called with that label. 
    If omitted, [count] behaves as though it was called with the 
    ["default"] label. 
*)
val count : ?label:string -> unit -> unit

(** If supplied, [count_reset] resets the count for that [label] to 0. 
    If omitted, [count_reset] resets the ["default"] counter to 0. 
*)
val count_reset : ?label:string -> unit -> unit

(** {3 Timers} 
    Timers are used to calculate the procedure execution time. 
    - We instantiate a timer with: [Console.time name], 
      where [name] is a unique timer ID;
    - [Console.timer_log name] displays the time elapsed since calling 
      [Console.timer name];
    - [Console.time_stop name] stops the timer, referenced by its name, 
      in progress.
*)

val time : string -> unit
val time_log : string -> 'a -> unit
val time_end : string -> unit

(** [Console.timetrack name actions] is a shortcut, for example:
    {[
      let () =
        Console.timetrack
          "answer time"
          [ (fun logger ->
                logger ();
                Console.print "Hello")
          ; (fun logger ->
               logger ();
               Console.print "World")
          ]
      ;;
    ]}
    Where [logger] is a [Console.time_log]. This shortcut avoid 
    the to instanciate and closed a timer.
*)
val timetrack : string -> (('a -> unit) -> unit) list -> unit

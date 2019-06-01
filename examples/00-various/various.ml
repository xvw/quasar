open Quasar_js

let () = Console.log "Hello World"
let () = Console.print "Hello World"
let () = Console.error "test"
let () = Console.warning "foobar"

let () =
  Console.timetrack
    "answer time"
    [ (fun logger ->
        logger "foo";
        Console.print "Hello")
    ; (fun logger ->
        logger "bar";
        Console.print "World")
    ]
;;

let () = Console.time "foo"
let () = Console.time_log "foo" ()
let () = Console.time_log "foo" ()
let () = Console.time_end "foo"

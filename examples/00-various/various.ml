open Quasar_core.Util
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
let () = Console.clear ()
let () = Console.count ()
let () = Console.count ()
let () = Console.count ~label:"foo" ()
let () = Console.count_reset ()
let () = Console.count ~label:"foo" ()
let () = Console.count_reset ~label:"foo" ()
let () = Console.count ~label:"foo" ()
let () = Console.count ()
let () = Console.dir "foo"
let () = Console.dir 7
let () = Console.dir Js_of_ocaml.Firebug.console
let () = Console.trace ()
let () = Console.info "foo"

let () =
  Console.table
  $ Array.from_array Js_of_ocaml.Js.string [| "foo"; "bar"; "baz" |]
;;

let () =
  let () = Console.group ~label:"foo" () in
  let () = Console.print "foo" in
  let () = Console.print "bar" in
  let () = Console.group () in
  let () = Console.print "baz" in
  let () = Console.group_end () in
  let () = Console.print "foobar" in
  let () = Console.group_end () in
  Console.print "foobarbaz"
;;

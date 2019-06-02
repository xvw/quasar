open Js_of_ocaml
open Jest

let () = test "Simple test" (fun () -> (expect 42).%{to_equal} <- 42)

module ArrayTest = struct
  open Quasar_js
end

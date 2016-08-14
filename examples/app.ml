let () =
  let open Quasar in 
  if with_debugger () then alert "En debug"
  else alert "Pas en debug"

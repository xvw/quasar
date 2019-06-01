# Quasar

> Quasar is a library for building applications in the JavaScript ecosystem.
> It offers an API that approaches the idiomatic ways of doing OCaml.

### Anatomy 

Quasar is an umbrella for four specific libraries:

- `Quasar_core`: all agnostic JavaScript components, generic and usable 
   everywhere;
- `Quasar_js`: a library compatible with Node and the Browser to generate 
   JavaScript (via Js_of_ocaml);
- `Quasar_browser`: a browser-specific library as the execution context;
- `Quasar_node`: a specific library has Node as the execution context.
  (NodeJS recommandes version `>= v10.7.0`)

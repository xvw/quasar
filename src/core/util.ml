let id x = x
let flip f x y = f y x
let const x _ = x
let compose f g x = g (f x)
let ( $ ) f x = f x
let ( %> ) = compose
let ( <% ) f g x = f (g x)
let ( % ) = ( <% )

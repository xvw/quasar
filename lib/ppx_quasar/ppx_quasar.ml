(*
 * Quasar
 *
 * Copyright (C) 2016  Xavier Van de Woestyne <xaviervdw@gmail.com>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
*)

open Parsetree
open Asttypes
open Ast_helper

module Util =
struct

  let define_loc ?(loc = !default_loc) value =
    { txt = value; loc = loc }
                                               
  let loc = define_loc
  let ident ?(loc = !default_loc) value =
    define_loc ~loc (Longident.Lident value)
      
  let exp_ident x  = Exp.ident (ident x)
  let string value = Exp.constant (Const.string value)
  let int value    = Exp.constant (Const.int value)
  let _true        = Exp.construct (ident "true") None
  let _false       = Exp.construct (ident "false") None
  let pattern s    = Pat.var (loc s)
  let _unit        = pattern "()"
  
  let import_function modname funcname =
  loc Longident.(Ldot (Lident modname, funcname))
  |> Exp.ident

end

let match_route exp =
  match exp.pexp_desc with
  | Pexp_extension ({txt = "quasar.routes"; loc=_}, _) -> true
  | _ -> false 


(* to be continued ... *)
let expr_mapper mapper expr =
  let _ = print_endline "lol" in
  match expr.pexp_desc with
  | Pexp_match (exp, cases) when match_route exp ->
    let f = Util.import_function "Quasar.Url" "get_hash" in
    Exp.apply f [Nolabel, Util.exp_ident "()"]
  | _ -> Ast_mapper.(default_mapper.expr mapper expr)



let quasar_mapper =
  Ast_mapper.{
    default_mapper with
    expr = expr_mapper  
  }


let _ = print_endline "test" 

let () =
  Ast_mapper.run_main (
    fun argv -> quasar_mapper
  )

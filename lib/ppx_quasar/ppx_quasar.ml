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

let match_route exp =
  match exp.pexp_desc with
  | Pexp_extension ({txt = "routes"; loc=_}, _) -> true
  | _ -> false 

let expr_mapper mapper expr =
  match expr.pexp_desc with
  | Pexp_match (exp, cases) when match_route exp ->
    Ast_mapper.(default_mapper.expr mapper expr)
  | _ -> Ast_mapper.(default_mapper.expr mapper expr)



let quasar_mapper argv =
  Ast_mapper.{
    default_mapper with
    expr = expr_mapper  
  }

let () =
  Ast_mapper.register
    "ppx_quasar"
    quasar_mapper

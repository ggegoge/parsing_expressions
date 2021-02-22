open Ast

let parse (s : string) : expr =
  let lexbuf = Lexing.from_string s in
  let ast = Parser.prog Lexer.read lexbuf in
  ast


let plus_term = ( + )
let minus_term a b = a - b
let times_factor = ( * )
let div_factor = ( / )

let rec eval_expr = function
  | Plus (t, e) -> plus_term (eval_term t) (eval_expr e)
  | Minus (t, e) -> minus_term (eval_term t) (eval_expr e)
  | Term t -> eval_term t
and eval_term = function
  | FMinus t -> ( ~- ) @@ eval_term t
  | Times (f, t) -> times_factor (eval_factor f) (eval_term t)
  | Div (f, t) -> div_factor (eval_factor f) (eval_term t)
  | Factor f -> eval_factor f
and eval_factor = function
  | Expr e -> eval_expr e
  | Num n -> n
  | Var _ -> 7             (* variables are funkeyy *)
  (* | FMinus f -> ( ~- ) @@ eval_factor f *)

let eval = eval_expr



let printf = Printf.printf;;

let rec pn_expr = function
  | Plus (t, e) -> printf "+ "; pn_term t; printf " "; pn_expr e
  | Minus (t, e) -> printf "- "; pn_term t; printf " "; pn_expr e
  | Term t -> pn_term t
and pn_term = function
  | FMinus t -> printf "-"; pn_term t
  | Times (f, t) -> printf "* "; pn_factor f; printf " "; pn_term t
  | Div (f, t) -> printf "/ "; pn_factor f; printf " "; pn_term t
  | Factor f -> pn_factor f
and pn_factor = function
  | Expr e -> pn_expr e
  | Num n -> printf "%d" n
  | Var x -> printf "%s" x
  (* | FMinus f -> printf "-("; pn_factor f; printf ")" *)

let pn x = pn_expr x; print_endline "";;

let rec rpn_expr = function
  | Plus (t, e) -> rpn_term t; printf " "; rpn_expr e; printf " +"
  | Minus (t, e) -> rpn_term t; printf " "; rpn_expr e; printf " -"
  | Term t -> rpn_term t
and rpn_term = function
  | FMinus t -> printf "-"; rpn_term t
  | Times (f, t) -> rpn_factor f; printf " "; rpn_term t; printf " *"
  | Div (f, t) -> rpn_factor f; printf " "; rpn_term t; printf " /"
  | Factor f -> rpn_factor f
and rpn_factor = function
  | Expr e -> rpn_expr e
  | Num n -> printf "%d" n
  | Var x -> printf "%s" x
  (* | FMinus f -> printf "-("; rpn_factor f; printf ")" *)

let rpn x = rpn_expr x; print_endline "";;

let rec infix_expr = function
  | Plus (t, e) -> infix_term t; printf " + "; infix_expr e
  | Minus (t, e) -> infix_term t; printf " - "; infix_expr e
  | Term t -> infix_term t
and infix_term = function
  | FMinus t -> printf "-"; infix_term t
  | Times (f, t) -> infix_factor f; printf " * "; infix_term t
  | Div (f, t) -> infix_factor f; printf " / "; infix_term t
  | Factor f -> infix_factor f
and infix_factor = function
  | Expr e -> printf "("; infix_expr e; printf ")"
  | Num n -> printf "%d" n
  | Var x -> printf "%s" x
  (* | FMinus f -> printf "-("; infix_factor f; printf ")" *)

let infix x = infix_expr x; print_endline "";;



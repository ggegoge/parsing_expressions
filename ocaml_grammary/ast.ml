(* BNF prostej arytmetyki
 * <expr> ::= - <term > + <expr> | <term> + <expr> | <term> - <expr> | <term>
 * <term> ::= <term> * <factor> | factor
 * <factor> = (expr) | num | var *)

type expr =  
  | Plus of term * expr
  | Minus of term * expr
  | Term of term
and term =
  | FMinus of term
  | Times of factor * term
  | Div of factor * term
  | Factor of factor
and factor = Expr of expr | Num of int | Var of string

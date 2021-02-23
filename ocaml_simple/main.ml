open Ast

let parse (s : string) : arithtree =
  let lexbuf = Lexing.from_string s in
  let ast = Parser.prog Lexer.read lexbuf in
  ast

let potega a n = 
  let rec potegonowa a n ak =
    if n = 0 then ak
    else if n mod 2 = 0 then potegonowa (a * a) (n / 2) ak
    else potegonowa (a * a) (n / 2) (ak * a)
in potegonowa a n 1


let rec eval = function
  | Leaf n -> n
  | VLeaf _ -> 7
  | SNode t -> ~- (eval t)
  | Node (l, op, r) -> make_op l r op
and make_op l r op =
  let el = eval l in
  let er = eval r in
  match op with
  | Sum -> el + er
  | Mult -> el * er
  | Diff -> el - er
  | Divis -> el / er
  | Pow -> potega el er



let printf = Printf.printf;;

let find_bop = function
  | Sum -> "+"
  | Mult -> "*"
  | Diff -> "-"
  | Divis -> "/"
  | Pow -> "^"


let rec pn = function
  | Leaf n -> printf "%d" n
  | VLeaf x -> printf "%s" x
  | SNode t -> printf "-"; pn t
  | Node (l, op, r) -> find_bop op |> printf "%s "; pn l; printf " "; pn r

let rec rpn = function
  | Leaf n -> printf "%d" n
  | VLeaf x -> printf "%s" x
  | SNode t -> printf "-"; rpn t
  | Node (l, op, r) -> rpn l; printf " "; rpn r; find_bop op |> printf " %s"

(* check whether the subexpression needs to be parenthesised *)
let parent hop = function
  | Node (_, op, _) ->     
     (match (hop, op) with
     | Diff, _ | Divis, _ | Pow, _ | Mult, (Sum|Diff) -> true
     | Mult, (Mult|Divis|Pow) | Sum, (Sum|Mult|Divis|Pow|Diff) -> false
     )
  | SNode _ | Leaf _ | VLeaf _ -> false

let rec infix = function
  | Leaf n -> printf "%d" n
  | VLeaf x -> printf "%s" x
  | SNode t ->
     begin
       if parent Diff t then
         begin printf "-("; infix t; printf ")" end
       else
         begin printf "-"; infix t end
     end
  | Node (l, op, r) ->
     begin
       if parent op l then
         begin printf "("; infix l; printf ")" end
       else infix l;
       printf " %s " (find_bop op);
       if parent op r then
         begin printf "("; infix r; printf ")" end
       else infix r
     end



       

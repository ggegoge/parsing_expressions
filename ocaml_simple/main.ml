open Ast

let parse (s : string) : arithtree =
  let lexbuf = Lexing.from_string s in
  let ast = Parser.prog Lexer.read lexbuf in
  ast



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



let printf = Printf.printf;;

let find_bop = function
  | Sum -> "+"
  | Mult -> "*"
  | Diff -> "-"
  | Divis -> "/"


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
let parent = function
  | Node (_, op, _) ->
     begin
       match op with
       | Sum | Diff -> true
       | Mult | Divis -> false
     end
  | SNode _ | Leaf _ | VLeaf _ -> false
     
let rec infix = function
  | Leaf n -> printf "%d" n
  | VLeaf x -> printf "%s" x
  | SNode t -> printf "-"; infix t
  | Node (l, op, r) ->
     begin
       if parent l then
         begin printf "("; infix l; printf ")" end
       else infix l;
       printf " %s " (find_bop op);
       if parent r then
         begin printf "("; infix r; printf ")" end
       else infix r
     end



       

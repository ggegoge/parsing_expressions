
(* binary operation *)
type bop = Sum | Mult | Diff | Divis | Pow

(* the most basic arithemtics tree *)
type arithtree =
  | Leaf of int
  | VLeaf of string
  | SNode of arithtree
  | Node of arithtree * bop * arithtree

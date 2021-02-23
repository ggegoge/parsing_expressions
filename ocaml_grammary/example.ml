(* parsing examples *)
open Ast
open Main

let print_expr not e = not e; print_string " = "; print_int @@ eval e; print_endline ""

let hr () = print_endline "-----------------"

let s = "2 + 4";;
let e = parse s;;
let _ = print_expr infix_expr e
let _ = print_expr pn_expr e
let _ = print_expr rpn_expr e
(* eval e;;
 * pn e; infix e; rpn e;; *)
let () = hr ()

let s = "(2 + 4) * (2 + (2 + 0) * (1 + 1))"
let e = parse s
let _ = print_expr infix_expr e
let _ = print_expr pn_expr e
let _ = print_expr rpn_expr e
(* eval e;;
 * pn e; infix e; rpn e;; *)
let () = hr ()

let s = "-(10 * (-1 + 2))"
let e = parse s
let _ = print_expr infix_expr e
let _ = print_expr pn_expr e
let _ = print_expr rpn_expr e

(* eval e;;
 * pn e; infix e; rpn e;; *)

let s = "-(10 * ((-1) + 2 + 10))"
let e = parse s
let _ = print_expr infix_expr e
let _ = print_expr pn_expr e
let _ = print_expr rpn_expr e
(* eval e;;
 * pn e; infix e; rpn e;; *)
let () = hr ()

let s = "-(10 * (-1 + 2 + 10))"
let e = parse s
let _ = print_expr infix_expr e
let _ = print_expr pn_expr e
let _ = print_expr rpn_expr e
(* eval e;;
 * pn e; infix e; rpn e;; *)
let () = hr ()

let s = "1 + 2 + 3"
let e = parse s
let _ = print_expr infix_expr e
let _ = print_expr pn_expr e
let _ = print_expr rpn_expr e
(* eval e;;
 * pn e; infix e; rpn e;; *)
let () = hr ()

let _ = 
  let s = "1 * -2" in
  try   
    let e = parse s in
    let _ = print_expr infix_expr e in
    let _ = print_expr pn_expr e in
    let _ = print_expr rpn_expr e in ()
with _ -> print_string s; print_endline " has some illegalities in itself"
(* eval e;;
 * pn e; infix e; rpn e;; *)
let () = hr ()

let s = "-5 * (2 - 4) * ((3 * 2) + 5)"
let e = parse s
let _ = print_expr infix_expr e
let _ = print_expr pn_expr e
let _ = print_expr rpn_expr e
(* eval e;;
 * pn e; infix e; rpn e;; *)
let () = hr ()

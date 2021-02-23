(* parsing examples *)
open Ast
open Main

let printxpr not e = not e; print_string " = "; print_int @@ eval e; print_endline ""

let hr () = print_endline "-----------------"

let s = "2 + 4"
let e = parse s
let () = Printf.printf "input expr: %s; output:\n" s

let () = Printf.printf "input expr: %s; output:\n" s
let _ = printxpr infix e
let _ = printxpr pn e
let _ = printxpr rpn e
(* eval e;;
 * pn e; infix e; rpn e;; *)
let () = hr ()

let s = "(2 + 4) * (2 + (2 + 0) * (1 + 1))"
let e = parse s
let () = Printf.printf "input expr: %s; output:\n" s

let _ = printxpr infix e
let _ = printxpr pn e
let _ = printxpr rpn e
(* eval e;;
 * pn e; infix e; rpn e;; *)
let () = hr ()

let s = "-(10 * (-1 + 2))"
let e = parse s
let () = Printf.printf "input expr: %s; output:\n" s

let _ = printxpr infix e
let _ = printxpr pn e
let _ = printxpr rpn e
let () = hr ()

(* eval e;;
 * pn e; infix e; rpn e;; *)

let s = "-(10 * ((-1) + 2 + 10))"
let e = parse s
let () = Printf.printf "input expr: %s; output:\n" s

let _ = printxpr infix e
let _ = printxpr pn e
let _ = printxpr rpn e
(* eval e;;
 * pn e; infix e; rpn e;; *)
let () = hr ()

let s = "-(10 * (-1 + 2 + 10))"
let e = parse s
let () = Printf.printf "input expr: %s; output:\n" s

let _ = printxpr infix e
let _ = printxpr pn e
let _ = printxpr rpn e
(* eval e;;
 * pn e; infix e; rpn e;; *)
let () = hr ()

let s = "1 + 2 + 3"
let e = parse s
let () = Printf.printf "input expr: %s; output:\n" s

let _ = printxpr infix e
let _ = printxpr pn e
let _ = printxpr rpn e
(* eval e;;
 * pn e; infix e; rpn e;; *)
let () = hr ()

let _ = 
  let s = "1 * -2" in
  try   
    let e = parse s in
    let () = Printf.printf "input expr: %s; output:\n" s in
    let _ = printxpr infix e in
    let _ = printxpr pn e in
    let _ = printxpr rpn e in ()
with _ -> print_string s; print_endline " has some illegalities in itself"
(* eval e;;
 * pn e; infix e; rpn e;; *)
let () = hr ()

let s = "-5 * (2 - 4) * ((3 * 2) + 5)"
let e = parse s
let () = Printf.printf "input expr: %s; output:\n" s

let _ = printxpr infix e
let _ = printxpr pn e
let _ = printxpr rpn e
(* eval e;;
 * pn e; infix e; rpn e;; *)
let () = hr ()

let s = "(3 + 2 * (1 + 1 + 1))^2"
let e = parse s
let () = Printf.printf "input expr: %s; output:\n" s

let _ = printxpr infix e
let _ = printxpr pn e
let _ = printxpr rpn e
let () = hr ()

let s = "(1 + 1)^(2 * 1)"
let e = parse s
let () = Printf.printf "input expr: %s; output:\n" s

let _ = printxpr infix e
let _ = printxpr pn e
let _ = printxpr rpn e

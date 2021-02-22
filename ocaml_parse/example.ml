(* parsing examples *)

let s = "2 + 4";;
let e = parse s;;
eval e;;
pn e; infix e; rpn e;;

let s = "(2 + 4) * (2 + (2 + 0) * (1 + 1))"
let e = parse s;;
eval e;;
pn e; infix e; rpn e;;

let s = "-(10 * (-1 + 2))"
let e = parse s;;
eval e;;
pn e; infix e; rpn e;;

let s = "-(10 * ((-1) + 2 + 10))"
let e = parse s;;
eval e;;
pn e; infix e; rpn e;;

let s = "1 + 2 + 3"
let e = parse s;;
eval e;;
pn e; infix e; rpn e;;

let s = "1 * -2"
let e = parse s;;
eval e;;
pn e; infix e; rpn e;;

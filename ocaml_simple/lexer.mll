{
open Parser
}

let white = [' ' '\t']+
let digit = ['0'-'9']
let num = digit+ (* '-'? digit+ *)
let letter = ['a'-'z' 'A'-'Z']
let var = letter+

rule read = 
  parse
  | white { read lexbuf }
  | "*" { TIMES }
  | "/" { DIV }  
  | "+" { PLUS }
  | "-" { MINUS }
  | "^" { POW }
  | "(" { LPAREN }
  | ")" { RPAREN }
  | var { VAR (Lexing.lexeme lexbuf) }
  | num { NUM (int_of_string (Lexing.lexeme lexbuf)) }
  | eof { EOF }

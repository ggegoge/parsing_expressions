%{
open Ast
%}

%token <int> NUM
%token <string> VAR
%token TIMES
%token DIV
%token PLUS
%token MINUS
%token LPAREN
%token RPAREN
%token EOF

%left PLUS MINUS
%left TIMES DIV
%nonassoc FMINUS

%start <Ast.arithtree> prog

%%

prog:
  | e = expr EOF { e }
;

/* BNF prostej arytmetyki
 * <expr> ::= - <term > + <expr> | <term> + <expr> | <term> - <expr> | <term>
 * <term> ::= <term> * <factor> | factor
 * <factor> = (expr) | num | var */


expr:
  | MINUS t = term PLUS e = expr %prec FMINUS { Node (SNode t, Sum, e) }
  | MINUS t = term MINUS e = expr %prec FMINUS { Node (SNode t, Diff, e) }
  | MINUS t = term %prec FMINUS { SNode t }
  | t = term PLUS e = expr { Node (t, Sum, e) }
  | t = term MINUS e = expr { Node (t, Diff, e) }
  | t = term { t }
;

term:
  | f = factor TIMES t = term { Node (f, Mult, t)}
  | f = factor DIV t = term { Node (f, Divis, t) }
  | f = factor { f }
;

factor:
  | LPAREN e = expr RPAREN { e }
  | n = NUM { Leaf n }
  | x = VAR { VLeaf x }
;

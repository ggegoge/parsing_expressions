%{
open Ast
%}

%token <int> NUM
%token <string> VAR
%token TIMES
%token DIV
%token PLUS
%token MINUS
%token POW
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
 * <expr> ::= - <expr> + <term> | <expr> - <term> | <term>
 * <term> ::= - <term> | <term> * <factor> | <term> / <factor> | <factor>
 * <factor> = <factor>^<factor> | (expr) | num | var */


expr:
  | e = expr PLUS t = term { Node (e, Sum, t) }
  | e = expr MINUS t = term { Node (e, Diff, t) }
  | t = term { t }
;

term:
  | MINUS t = term %prec FMINUS { SNode t }
  | t = term TIMES f = factor { Node (t, Mult, f) }
  | t = term DIV f = factor { Node (t, Divis, f) }
  | f = factor { f }
;

factor:
  | f1 = factor POW f2 = factor { Node(f1, Pow, f2) }
  | LPAREN e = expr RPAREN { e }
  | n = NUM { Leaf n }
  | x = VAR { VLeaf x }
;

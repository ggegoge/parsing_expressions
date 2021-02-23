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

%start <Ast.expr> prog

%%

prog:
  | e = expr EOF { e }
;

expr:
  | MINUS t = term PLUS e = expr %prec FMINUS { Plus(FMinus t, e) }
  | MINUS t = term MINUS e = expr %prec FMINUS { Plus(FMinus t, e) }
  | MINUS t = term %prec FMINUS { Term (FMinus t) }
  | t = term PLUS e = expr { Plus (t, e) }
  | t = term MINUS e = expr { Minus (t, e) }
  | t = term { Term t }
;

term:
  | f = factor TIMES t = term { Times (f, t) }
  | f = factor DIV t = term { Div (f, t) }
  | f = factor { Factor f }
;

factor:
  | LPAREN e = expr RPAREN { Expr e }
  | n = NUM { Num n }
  | x = VAR { Var x }
;

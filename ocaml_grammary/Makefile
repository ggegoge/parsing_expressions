main: _build/main.byte main.ml;

_build/main.byte _build/main.cmo: _build/parser.mly _build/lexer.ml _build/lexer.mll main.ml
	ocamlbuild -use-menhir -menhir "menhir --unused-precedence-levels" main.byte

parser: _build/parser.mly;

_build/parser.mly: _build/lexer.ml _build/lexer.mll
	ocamlbuild -use-menhir parser.mly

lexer: _build/lexer.ml _build/lexer.mll lexer.mll;

_build/lexer.ml _build/lexer.mll: lexer.mll
	ocamlbuild lexer.mll

example: example.byte;

example.byte: example.ml _build/parser.mly _build/lexer.ml _build/lexer.mll
	ocamlbuild -use-menhir -menhir "menhir --unused-precedence-levels" example.byte

main: _build/main.byte;

_build/main.byte _build/main.cmo: _build/parser.mly _build/lexer.ml _build/lexer.mll
	ocamlbuild -use-menhir -menhir "menhir --unused-precedence-levels" main.byte

parser: _build/parser.mly;

_build/parser.mly: _build/lexer.ml _build/lexer.mll
	ocamlbuild -use-menhir parser.mly

lexer: _build/lexer.ml _build/lexer.mll;

_build/lexer.ml _build/lexer.mll:
	ocamlbuild lexer.ml

example: example.byte;

example.byte: _build/parser.mly _build/lexer.ml _build/lexer.mll
	ocamlbuild -use-menhir -menhir "menhir --unused-precedence-levels" example.byte

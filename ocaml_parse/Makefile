main: parser
	ocamlbuild -use-menhir main.byte

parser: lexer
	ocamlbuild -use-menhir parser.mly

lexer:
	ocamlbuild lexer.ml

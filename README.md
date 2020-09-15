# Expression parser
A simple C programme that parses and evaluates mathematical expressions.
 

### what
It parses them and then stores them as _trees_. Therefore it is extremely easy to then use the [RPN](https://en.wikipedia.org/wiki/Reverse_Polish_notation) as it [_grows on trees_](https://www.youtube.com/watch?v=TrfcJCulsF4) in a way.

### parsing
everything is parsed according to this simplified (im no bnf expert but [consult this website](http://homepage.divms.uiowa.edu/~jones/compiler/spring13/notes/10.shtml)) grammar:

```grammar
<expression> ::= <term> { + <term> }
<term> ::= <factor> { * <factor> }
<factor> ::=  <number> | ( <expression> ) 
```
of course the `+` could also be a `-` and the `*` could be `/` too. They are the same operation after all (but reversed).
 
The process of parsing is based on the principle highlited in the grammar above with 
three functions in `expressions.c` each creating a node for the tree:

```C
node *expr(...);
node *term(...);
node *factor(...);
```

### trees
given an expression like `a+b*(c+d)` the programme creates a binary tree like structure that would look something like that:

```
  +
 /  \
a    *
    /  \
   b    +
       / \
      c   d
```

so then it can easily write it out as a reverse polish (or _Azciweisakuł_) expression ie. `a b c d + * +`.

It also can reverse the process in order to get the standard Polish (or _Łukasiewicz_) notation so:
`+ a * b + c d` 

And if it is numeric it can be evaluated.

#### the principal
it is all based on a recursive approach. If we had eg. a recursive procedure named `P` that we want to apply to the tree (and its every node) then RPN, PN and traditional notation all portray the same thing but in different order of `P`ing:

* PN: `P(root); P(root^.left); P(root^.right);`
* RPN: `P(root^.left); P(root^.right); P(root);`
* traditional way: `P(root^.left); P(root); P(root^.right);`


#### example of the programme running
of course first it should be compiled `gcc -o parse main.c expressions.c onp.c`

if we run it:
```
$ ./parse
Podaj wyrazenie matematyczne:
(a*(b+c)*(d+e)+f)*(g+h*(i+j))
Lukasiewicz:
* + * a * + b c + d e f + g * h + i j 
Azciweisakul:
a b c + d e + * * f + g h i j + * + * 
reminder, ze bylo to:
( a * ( b + c ) * ( d + e ) + f ) * ( g + h * ( i + j ) ) 

$ ./parse
Podaj wyrazenie matematyczne:
2*(21/7+4)-(5+2)*2
Lukasiewicz:
- * 2 + / 21 7 4 * + 5 2 2 
Azciweisakul:
2 21 7 / 4 + * 5 2 + 2 * - 
reminder, ze bylo to:
2 * ( 21 / 7 + 4 ) - ( 5 + 2 ) * 2 = 0                                     
```
note it evaluates the exmample with actual numbers.


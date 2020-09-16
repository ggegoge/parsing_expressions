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

#### the principle
it is all based on a recursive approach. If we had eg. a recursive procedure named `P` that we want to apply to the tree (and its every node) then RPN, PN and traditional notation all portray the same thing but in different order of `P`ing:

* PN: `P(root); P(root^.left); P(root^.right);`
* RPN: `P(root^.left); P(root^.right); P(root);`
* traditional way: `P(root^.left); P(root); P(root^.right);`

### how to
you can use standard arithmetic operations so these 4 operands: `+-*/`.
Pass your expression without any spaces or it won't be registered correctly.

As for now it can either be an expression with integers* only or chars only (don't mix them together)

You can either pass it from the terminal so `./parse '<expression>'` or in the programme itself. Look below for an example

#### example of the programme running
of course first it should be compiled `gcc -o parse main.c expressions.c onp.c run.c`

if we run it:
```
$ ./parse '(2*3-4)-(9-4)/2'
Lukasiewicz:
- - * 2 3 4 / - 9 4 2 
Azciweisakul:
2 3 * 4 - 9 4 - 2 / - 
reminder, ze bylo to:
2 * 3 - 4 - ( 9 - 4 ) / 2 = 0

$ ./parse '(a*(b+c)*(d+e)+f)*(g+h*(i+j))'
Lukasiewicz:
* + * * a + b c + d e f + g * h + i j 
Azciweisakul:
a b c + * d e + * f + g h i j + * + * 
reminder, ze bylo to:
( a * ( b + c ) * ( d + e ) + f ) * ( g + h * ( i + j ) ) 

$ ./parse '2*(21/7+4)-(5+2)*2'
Lukasiewicz:
- * 2 + / 21 7 4 * + 5 2 2 
Azciweisakul:
2 21 7 / 4 + * 5 2 + 2 * - 
reminder, ze bylo to:
2 * ( 21 / 7 + 4 ) - ( 5 + 2 ) * 2 = 0

$ ./parse
Podaj wyrazenie matematyczne:
8/(4/2)
Lukasiewicz:
/ 8 / 4 2 
Azciweisakul:
8 4 2 / / 
reminder, ze bylo to:
8 / ( 4 / 2 ) = 4
                              
```






----------------
\*_positive integers_ - negative numbers also work to some extent but in some cases it'd be better to explicitly state them as 0-x.
Here's a working example:
```
$ ./parse '-2*(21/7+4)+(-5+(-2))*(-2)'
Lukasiewicz:
+ * -2 + / 21 7 4 * + -5 -2 -2 
Azciweisakul:
-2 21 7 / 4 + * -5 -2 + -2 * + 
reminder, ze bylo to:
-2 * ( 21 / 7 + 4 ) + ( -5 + -2 ) * -2 = 0
```
and here's a problematic one:
```
$ ./parse '-(2*3-4)-(9-4)/2'
Lukasiewicz:
- 0 / - 9 4 2 
Azciweisakul:
0 9 4 - 2 / - 
reminder, ze bylo to:
0 - ( 9 - 4 ) / 2 = -2
```
as you see `-` before a bracket is problematic

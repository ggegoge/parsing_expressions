#ifndef EXPRESSIONS_H_   /* Include guard */
#define EXPRESSIONS_H_

/* typedef struct node node; */
typedef struct node {
  int is_op, value;
  char op;
  struct node * l, * r;
} node;


/* gramatyka
<expr> ::= <term> { + <term> }
<term> ::= <factor> { * <factor> }
<factor> ::= <num> | ( <expr> )
*/

node *expr(char* p, int l, int r);
node *term(char* p, int l, int r);
node *factor(char* p, int l, int r);

/* clean up */
void delete_tree(node** p);

#endif // EXPRESSIONS_H_

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

node *expr(char** p);
node *term(char** p);
node *factor(char** p);

/* 'interface' */
/* void run(char* str, int len); */

/* clean up */
void delete_tree(node* p);

#endif 

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "expressions.h"
#include "onp.h"

/* typ strukturalny node zdefiniowany w "expressions.h" */



/* GRAMATYKA

<expr> ::= <term> { +|- <term> }
<term> ::= <factor> { *|/ <factor> }
<factor> ::= <num> | ( <expr> )
*/


/* <expr> ::= <term> { + <term> } */
node *expr(char* p, int l, int r) {
  int l_parenth = 0, r_parenth = 0, i = r-1;   /* r bo od tylu */
  node * root = (node*) malloc(sizeof(node));
  root->l = NULL;
  root->r = NULL;
  
  /* przesuwa sie OD konca do - lub + NIE wewnatrz nawiasow */
  while (((l_parenth != r_parenth) || !is_plus_minus(*(p+i))) && (i>=l)) {
    if (*(p+i) == '(') l_parenth++;
    if (*(p+i) == ')') r_parenth++;
    i--;                             
  }                                  

  if (*(p+i) == '+') {
    root->is_op = 1;      
    root->op = '+';
    root->l = expr(p, l, i);
    root->r = term(p, i+1, r);
  }
  else if (*(p+i) == '-') {
    root->is_op = 1;
    root->op = '-';                 
    root->l = expr(p, l, i);          /* { + <term> } */
    root->r = term(p, i+1, r);       /* <term> */
  }
  else 
    root = term(p, l, r);
  
  return root;
}


/* <term> ::= <factor> { * <factor> } */
node *term(char* p, int l, int r) {
  int l_parenth = 0, r_parenth = 0, i = r-1;   
  node * root = (node*) malloc(sizeof(node));
  root->l = NULL;
  root->r = NULL;

  /* przesuwa sie od konca OD / lub * NIE wewnatrz nawiasow */
  while ( ((l_parenth != r_parenth) || !is_star_div(*(p+i))) && (i>=l)) {
    if (*(p+i) == '(') l_parenth++;
    if (*(p+i) == ')') r_parenth++;
    i--;
  }
  
  if (*(p+i) == '*') {
    root->is_op = 1;
    root->op = '*';
    root->l = term(p, l, i);
    root->r = factor(p, i+1, r);
  }
  else if (*(p+i) == '/') {
    root->is_op = 1;
    root->op = '/';
    root->l = term(p, l, i);            /* { * <factor> } */
    root->r = factor(p, i+1, r);       /* <factor> */
  }  
  else 
    root = factor(p, l, r);
  
  return root;
}


/* <factor> ::= <num> | ( <expr> ) */
node *factor(char* p, int l, int r) {
  node * root = (node*) malloc(sizeof(node));
  root->l = NULL;
  root->r = NULL;
  if (*(p+l) == '(') {             /* ( <expr> ) */
    if (*(p+r-1) == ')')
      root = expr(p, l+1, r-1);
    else {
      printf("MISSING CLOSING PARENTHESES\n");
      root = expr(p, l+1, r-2);
    }
  }      
  else {
    root->is_op = 0;               /* <num> */
    root->op = *(p+l);
    if ((*(p+l) >= '0') && (*(p+l) <='9'))
      root->value = stoi(p, l, r);
  }
  return root;
}

  


void delete_tree(node ** p) {
  if (*p == NULL)
    return;
  delete_tree(&((*p)->l));     /* is this right? */
  delete_tree(&((*p)->r));
  free(*p);
  *p = NULL;
}

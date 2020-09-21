/* Wersja sekwencyjna */

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
node *expr(char** p) {
  int branch = 0;
  node * root2 = NULL;
  node * root = (node*) malloc(sizeof(node));
  root->l = NULL;
  root->r = NULL;

  if (**p == '-') {
    root2 = (node*) malloc(sizeof(node));
    root2->is_op = 0;
    root2->op = '0';
    root2->value = 0;
    root2->l = NULL;
    root2->r = NULL;
    root->l = root2;
    root->is_op = 1;
    root->op = '-';
    (*p)++; 
    branch = 1;
  }
  while (**p != '\0' && **p) {
    if (**p != '+' && **p != '-') {
      if (**p == ')')
        break;
      if (!branch) {
        root = term(p);
        branch = 1;
      }
      else 
        root->r = term(p);
    }
    else {
      root2 = root;
      root = (node*) malloc(sizeof(node));
      root->r = NULL;
      root->l = root2;
      root->op = **p;
      root->is_op = 1;
      (*p)++;
    }
  }                      
  return root;
}


/* <term> ::= <factor> { * <factor> } */
node *term(char** p) {
  int branch = 0;
  node * root2;
  node * root = (node*) malloc(sizeof(node));
  root->l = NULL;
  root->r = NULL;
  
  while (**p != '+' && **p != '-' && **p != '\0') {
    if (**p != '*' && **p != '/') {
      if (**p == ')' || **p == '\0')
        return root;
      if (!branch) {
        root = factor(p);
        branch = 1;
      }
      else 
        root->r = factor(p);
    }
    else {
      root2 = root;
      root = (node*) malloc(sizeof(node));
      root->r = NULL;
      root->l = root2;
      root->is_op = 1;
      root->op = **p;
      (*p)++;
    }
  }                      
  return root;
}


/* <factor> ::= <num> | ( <expr> ) */
node *factor(char** p) {
  int len = 0, sign = 0;
  node * root = (node*) malloc(sizeof(node));
  root->l = NULL;
  root->r = NULL;
  
  if (**p == '(') {             /* ( <expr> ) */
    (*p)++;
    root = expr(p);
    if (**p != ')') 
      printf("MISSING PARENTHESES\n");    
    (*p)++;
  }
  else {
    root->op = **p;
    if ((root->op >= '0' && root->op <= '9') || root->op == '-') {
      if (**p == '-') {
        sign = 1;
        (*p)++;
        root->op = **p;
      }      
      while (**p >= '0' && **p <= '9') {
        len++;
        (*p)++;
      }
      root->value = stoi(*p, len, sign);
    } else
      (*p)++;      
    root->is_op = 0;
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

#include <stdio.h>
#include <stdlib.h>

#include "expressions.h"
#include "onp.h"


/* string p w indeksach od l do r zmienia w int */
/* ujemna <-> jest znak <-> sign == 1 */
int stoi(char* p, int len, int sign) {
  int res = 0;
  int i;
  p -= len;
  for (i=0; i<len; i++) {
    res *= 10;
    res += *p - '0';
    p++;
  }
  return sign ? -res : res;
}

/* uproszczenie warunków pętli w <term> i <factor> */

int is_plus_minus(char c) {
  if ((c == '+') || (c == '-'))
    return 1;
  else
    return 0;
}
int is_star_div(char c) {
  if ((c == '*') || (c == '/'))
    return 1;
  else
    return 0;
}

/* tryb wyrażenia znakowego czy liczbowej kalkulacji */
int if_nums(node* p) {
  if (p->r == NULL) {
    if ((p->op >= '0') && (p->op <= '9'))
      return 1;
    else
      return 0;
  }
  return if_nums(p->r);
}

/* notacja symboliczna tj dla if_nums == 0: */

/* notacja lukasiewicza */
void np(node* p) {
  if (p != NULL) {          /* do, rekur left, rekur right*/
    printf("%c ", p->op);
    np(p->l);
    np(p->r);
  }
}

/* notacja azciweisakul */
void onp(node* p) {
  if (p != NULL) {       /* rekur left, rekur right, do*/
    onp(p->l);
    onp(p->r);
    printf("%c ", p->op);
  }
}


/* zwykly zapis matematyczny */
/* 
sa nawiasy wedlug nastepujacego algorytmu:
   - przylaczam lewa galaz wezla p (p^.l) z nawiasami wtw gdy operator
     p to nie jest ani plus ani minus. zatem (a+b)*p^.r, ale a+b+p^.r 
   - przylaczam prawa galaz z nawiasami wtw gdy 
       1. p^.op to -, a operator p^.r to - lub plus
       2. p^.op to / i dowolny operator w p^.r
       3. p^.op to * i w p^.r operator nie*
i skomplikowane ify aczkolwiek dzialajace
*/

void normalna(node* p) {
  if (p != NULL) {               /* rekur left, do, rekur right */
    if (p->l != NULL) { 
      if ((((p->l)->op == '+') || ((p->l)->op == '-')) && !((p->op == '+') || (p->op == '-')))
        printf("( ");
    }
    normalna(p->l);
    if (p->l != NULL) {
      if ((((p->l)->op == '+') || ((p->l)->op == '-')) && !((p->op == '+') || (p->op == '-')))
        printf(") ");
    }
    
    printf("%c ", p->op);
    
    if (p->r != NULL) {
      if ( ( (p->op == '-') && ( ((p->r)->op == '+') || ((p->r)->op == '-') ) )
           || ( (p->op == '/') && ((p->r)->is_op) )
           ||  ( (p->op == '*') && ((p->r)->is_op) && ((p->r)->op != '*')) )
        printf("( ");
    }
    normalna(p->r);
    if (p->r != NULL) {
      if ( ( (p->op == '-') && ( ((p->r)->op == '+') || ((p->r)->op == '-') ) )
           || ( (p->op == '/') && ((p->r)->is_op) )
           ||  ( (p->op == '*') && ((p->r)->is_op) && ((p->r)->op != '*')) )
        printf(") ");
    }
  }
}



/* notacja liczbowa analogicznie: */


void np_filled(node* p) {
  if (p != NULL) {
    if (p->is_op)
      printf("%c ", p->op);
    else
      printf("%d ", p->value); 
    np_filled(p->l);
    np_filled(p->r);
  }
}

void onp_filled(node* p) {
  if (p != NULL) {
    onp_filled(p->l);
    onp_filled(p->r);
    if (!p->is_op)
      printf("%d ", p->value);
    else
      printf("%c ", p->op);
  }
}


void normalna_filled(node* p) {
  if (p != NULL) {               /* rekur left, do, rekur right */
    if (p->l != NULL) { 
      if ((((p->l)->op == '+') || ((p->l)->op == '-')) && !((p->op == '+') || (p->op == '-')))
        printf("( ");
    }
    normalna_filled(p->l);
    if (p->l != NULL) {
      if ((((p->l)->op == '+') || ((p->l)->op == '-')) && !((p->op == '+') || (p->op == '-')))
        printf(") ");
    }
    
    if (!p->is_op)
      printf("%d ", p->value);
    else
      printf("%c ", p->op);
    
    if (p->r != NULL) {
      if ( ( (p->op == '-') && ( ((p->r)->op == '+') || ((p->r)->op == '-') ) )
           || ( (p->op == '/') && ((p->r)->is_op) )
           ||  ( (p->op == '*') && ((p->r)->is_op) && ((p->r)->op != '*')) )
        printf("( ");
    }
    normalna_filled(p->r);
    if (p->r != NULL) {
      if ( ( (p->op == '-') && ( ((p->r)->op == '+') || ((p->r)->op == '-') ) )
           || ( (p->op == '/') && ((p->r)->is_op) )
           ||  ( (p->op == '*') && ((p->r)->is_op) && ((p->r)->op != '*')) )
        printf(") ");
    }
  }
}




/* oblicza wartosc wyrazenia liczbowego*/
/* schemat jak azciweisakul - eval(left) eval(right) i ich suma/iloczyn */
int eval(node* p) {
  int l, r;
  if (p != NULL) {
    if (!p->is_op)
      return p->value;
    else {
      l = eval(p->l);
      r = eval(p->r);

      switch (p->op) {
      case '+' :
        return l+r;
      case '-':
        return l-r;
      case '*':
        return l*r;
      case '/':
        return l/r;
      default:
        printf("unknown operator\n");
        break;
      }
    }
  } return 0;
}


/* uzupelnienie zmiennych nie liczbowych liczbami */
void fill(node* p) {
  if (p == NULL)
    return;
  if (p->is_op) {
    fill(p->l);
    fill(p->r);
  } else {
    int val;
    printf("%c = ", p->op);
    scanf("%d", &val);
    p->value = val;
  }
}

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include "run.h"
#include "expressions.h"
#include "onp.h"

/*
Programik analizujacy wyrazenia matematyczne oraz
(jezeli sa liczbowe) obliczajacy ich wartosc. Zapisuje
je w strukturze drzewa i nastepnie umie wypisac NP, ONP
oraz po prostu.
przyklady:
    symbolny: a*(b/c+d)-(e+f)*g
    liczebny: 2*(21/7+4)-(5+2)*2
*/

void run(char* str, int len) {
  node* root;
  root = expr(str, 0, len);
  if (!if_nums(root)) {                    /* wariant symboliczny */
    printf("Lukasiewicz:\n");
    np(root);
    printf("\n");
    
    printf("Azciweisakul:\n");
    onp(root);
    printf("\n");
    
    printf("reminder, ze bylo to:\n");
    normalna(root);
    printf("\n");
  }
  else {                                   /* wariant liczbowy */    
    printf("Lukasiewicz:\n");
    np_filled(root);
    printf("\n");
    
    printf("Azciweisakul:\n");
    onp_filled(root);
    printf("\n");
    
    printf("reminder, ze bylo to:\n");
    normalna_filled(root);
    printf("= %d\n", eval(root));
  }
  
  /* clean up */
  delete_tree(&root);
}

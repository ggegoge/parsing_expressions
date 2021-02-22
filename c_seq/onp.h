#ifndef ONP_H_   /* Include guard */
#define ONP_H_

/* string p w indeksach od l do r zmienia w int */
int stoi(char* p, int len, int sign);

/* tryb wyrażenia znakowego czy liczbowej kalkulacji */
int if_nums(node* p);

/* notacja czysto znakowo-symboliczne: */
/* lukasiewicz */
void onp(node* p);
/* azciweisakul */
void np(node* p);
/* normalna */
void normalna(node* p);

/* jw ale dla liczb */
void onp_filled(node* p);
void np_filled(node* p);
void normalna_filled(node* p);

/* obliczenie wartosci calego wyrazenia */
int eval(node* p);

/* wypelnionko zmiennych liczbami */
void fill(node* p);



#endif 

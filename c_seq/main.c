#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include "run.h"

int main(int argc, char** argv) {
  char wyr[40];
  
  if (argc < 2) {
    printf("Podaj wyrazenie matematyczne:\n");
    scanf("%s", wyr);
    run(wyr);
  }
  else 
    run(argv[1]);
  return 0;
}

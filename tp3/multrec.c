#include <stdio.h>

/* ***********************************************************
 * multiplication :  donnee a, b : entier positif, un resultat f : entier
 *
 * apres l'execution de multiplication(a, b, f) : f = a * b
 * *********************************************************** */

void multiplication (int a, int b, int *f) {
int r;

  if (b==1)
     { *f = a; }
  else
     { multiplication (a, b-1, &r); *f = a + r; }
}

int main () {
int n, t, res;

   printf ("Donnez deux entiers positifs : \n");
   scanf ("%d %d", &n, &t);
        multiplication (n,t , &res);
   printf (" %d * %d = %d\n", n, t, res);
}


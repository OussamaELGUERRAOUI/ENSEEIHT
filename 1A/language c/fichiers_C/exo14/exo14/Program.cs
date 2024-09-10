# include <stdlib.h>
# include <stdio.h>
# include <assert.h>
#include <math.h>
struct coordonee { int abscisse; int ordonnee };
int main()
{
    // Déclarer deux variables ptA et ptB de types Point
struct coordonee ptA, ptB;
// Initialiser ptA à (0,0)
ptA.abscisse = 0;
ptA.ordonnee = 0;
// Initialiser ptB à (10,10)
ptB.abscisse = 10;
ptB.ordonnee = 10;
// Calculer la distance entre ptA et ptB.
float distance = pow(pow(ptB.abscisse - ptA.abscisse, 2) + pow(ptB.ordonnee - ptA.ordonnee, 2), 0.5);

assert((int)(distance * distance) == 200);


return EXIT_SUCCESS;

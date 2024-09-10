
#include <stdlib.h>
#include <stdio.h>
#include <assert.h>
#include <math.h>
// Definition du type Point
struct coordonnee {int abs, int ord }

int main(){
    // Déclarer deux variables ptA et ptB de types Point
    struct coordonnee ptA, ptB;
    
    // Initialiser ptA à (0,0)
    ptA.abs = 0;
    ptA.ord = 0;
    // Initialiser ptB à (10,10)
    ptB = {10, 10};
    
    // Calculer la distance entre ptA et ptB.
    float distance = pow(pow(10,2) + pow(10,2),0.5);
    
    assert( int (distance*distance) == 200);
    
    return EXIT_SUCCESS;
}

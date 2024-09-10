
#include <assert.h>
#include <stdlib.h>
#include <stdio.h>

// Consignes pour une obtenir une exécution sans erreur : 
//     - compléter les instruction **** TODO **** 
// Attention : toutes les variables sont ici allouées et libérées dynamiquent

int main(){

    int* ptr_int; //un entier en mémoire dynamique 
    ptr_int = malloc(sizeof(int));
    *ptr_int = 100;
     printf("Donnée enregistrée : %d\n", *ptr_int);


    // Allocation et initialisation à la valeur 100;


    assert(*ptr_int == 100);

        
    
    free(ptr_int);
    ptr_int = NULL;
    //Libérer toute la mémoire dynamique
    
    assert(!ptr_int);

    printf("%s", "Bravo ! Tous les tests passent.\n");
    return EXIT_SUCCESS;
}

#include <stdlib.h> 
#include <stdio.h>
#include <assert.h>
#include <stdbool.h>

// Definition du type monnaie
 struct monnaie{
      float valeur;
      char devise;} ;
    typedef struct monnaie monnaie;
    typedef monnaie* T_monnaie;

/**
 * \brief Initialiser une monnaie 
 * \param[out]  monnaie à initialiser
 * \param[in] valeur c'est la valeur de monnaie
 * \param[in] caractere c'est devise
 \*pre monnaie > 0 */
 

void initialiser(T_monnaie m, float valeur , char devise)
{
    
    assert( valeur >=0);
    m->valeur = valeur;
    m->devise = devise;

}


/**
 * \brief Ajouter une monnaie m2 à une monnaie m1 
 * \param[in] m1 monnaie 1
//  *\param[in out] m2 */

bool ajouter(T_monnaie m1 , T_monnaie m2) {
    bool T = true;
    if( m1->devise == m2->devise){
         m2->valeur = m2->valeur+m1->valeur;}
    else{T= false;}
    return T ;
}


/**
 * \brief Tester Initialiser 
 * \param[]
 * // TODO
 */ 
void tester_initialiser(){
    T_monnaie m1=NULL;
    T_monnaie m2=NULL;
    initialiser(m1, 200, 'MAD');
    initialiser(m2, 40, 'e');
    assert(m1->valeur ==200);
    assert(m2->valeur ==40);
    assert(m1->devise =='MAD');
    assert(m2->devise =='$');
}

/**
 * \brief Tester Ajouter 
 * \param[]
 * // TODO
 */ 
void tester_ajouter(){

    T_monnaie m1=NULL;
    T_monnaie m2=NULL;
    m1->valeur = 40; 
    m1->devise = 'e';
    m2->valeur = 100 ; 
    m2->devise = 'e';
    ajouter(m1 , m2);
    assert(m2->valeur == 140);
    assert( m1->valeur ==40);
}



int main(void){
    // Un tableau de 5 monnaies
    
    typedef monnaie porte_monnaie [5];
     porte_monnaie T ;
     float valeur; 
     char devise;
    //Initialiser les monnaies
    printf("Bonjour, Vous entrez 5 monnaies.\n ");
    for (int i=0 ;i<=4 ;i++){ 
    printf("la valeur de monnaie %d : ",i+1);
    scanf("%f", &valeur);
    printf("Sa devise : ");
    scanf(" %c", &devise);
    initialiser(&T[i] , valeur , devise);}

 
    // Afficher la somme des toutes les monnaies qui sont dans une devise entrée par l'utilisateur.
    char d;
    printf("Entrer la devise  : "); 
    scanf("%s",&d);
    monnaie m ;
    initialiser(&m , 0.0 ,d);
    for (int i=0 ;i<= 4 ;i++){ 
    if( T[i].devise ==d){ajouter(&T[i],&m);} 
    }
   
    printf("la somme de toutes les monnaies de cette devise est: %1.2f",m.valeur);
    printf( "%c\n",d);
    return EXIT_SUCCESS;
}

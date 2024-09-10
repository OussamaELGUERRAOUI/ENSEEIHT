/**
 *  \author Xavier Cr�gut <nom@n7.fr>
 *  \file file.c
 *
 *  Objectif :
 *	Implantation des op�rations de la file
*/

#include <malloc.h>
#include <assert.h>

#include "file.h"


void initialiser(File *f)
{
    f = malloc(sizeof(File));
    f -> queue = NULL;
    f -> tete = NULL;
    
    assert(est_vide(*f));
}


void detruire(File *f)
{
   free(f);
   f = NULL;
   assert(f == NULL);
}


char tete(File f)
{
    assert(! est_vide(f));    
    return f.tete -> valeur;
}


bool est_vide(File f)
{
    
    return f.tete == NULL && f.queue == NULL;
}

/**
 * Obtenir une nouvelle cellule allou�e dynamiquement
 * initialis�e avec la valeur et la cellule suivante pr�cis� en param�tre.
 */
static Cellule * cellule(char valeur, Cellule *suivante)
{
    Cellule *c = malloc(sizeof(Cellule));
    c -> valeur = valeur;
    c -> suivante = suivante;
    return c;
}


void inserer(File *f, char v)
{
    assert(f != NULL);
    Cellule *c = cellule(v, NULL);
    f -> queue = c;
    f -> queue -> suivante = c;
   
    

    
}

void extraire(File *f, char *v)
{
    assert(f != NULL);
    assert(! est_vide(*f));
    *v = f -> tete -> valeur;
    Cellule *c_suivant = f -> tete -> suivante;
    if (longueur(*f) == 1) {
        detruire(f);
    } else {
        f -> tete = c_suivant;
    }
    

    
}


int longueur(File f)
{
    int s = 0;
    Cellule *c = f.tete;
    while (c != NULL) {
        s++;
        c = c -> suivante;
    }
    return s;
}

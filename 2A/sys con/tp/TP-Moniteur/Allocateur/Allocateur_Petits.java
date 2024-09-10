// Time-stamp: <28 oct 2022 10:31 queinnec@enseeiht.fr>

import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;
import java.util.concurrent.locks.Condition;

/**
 * Allocateur de ressources,
 * stratégie d'ordonnancement: priorité aux petits demandeurs,
 *
 * Implantation: moniteur (java 5), une var condition par taille de demande.
 */
public class Allocateur_Petits implements Allocateur {

    // Nombre total de ressources.
    private final int nbRessources;

    // Nombre de ressources actuellement disponibles
    // invariant 0 <= nbLibres <= nbRessources
    private int nbLibres;

    // Protection des variables partagées
    private Lock moniteur;

    // Une condition de blocage par taille de demande
    // tableau [nbRessources+1] dont on n'utilise pas la case 0
    private Condition[] classe;

    // Le nombre de processus en attente à chaque étage
    // tableau [nbRessources+1] dont on n'utilise pas la case 0
    private int[] tailleClasse;

    /** Initilialise un nouveau gestionnaire de ressources pour nbRessources. */
    public Allocateur_Petits(int nbRessources) {
        this.nbRessources = nbRessources;
        this.nbLibres = nbRessources;
        this.moniteur = new ReentrantLock();
        this.tailleClasse = new int[nbRessources + 1];
        this.classe = new Condition[nbRessources + 1];

        for (int i = 1; i <= nbRessources; i++) {
            classe[i] = moniteur.newCondition();
            tailleClasse[i] = 0;
        }

    }

    private void reveiller_suivant() {
        int i = 1;
        while (i <= nbLibres && tailleClasse[i] == 0 ){
            i++;
        }
        if (i <= nbLibres ){
            classe[i].signal();
        }


    }

    /** Demande à obtenir `demande' ressources. */
    public void allouer(int demande) throws InterruptedException {
        moniteur.lock();
        while (demande > nbLibres) {
            tailleClasse[demande]++;
            classe[demande].await();
            tailleClasse[demande]--;
        }  
        nbLibres -= demande;
        reveiller_suivant();
        moniteur.unlock();

    }

    /** Libère `rendu' ressources. */
    public void liberer(int rendu) throws InterruptedException {
        moniteur.lock();
        nbLibres += rendu;
        reveiller_suivant();
        moniteur.unlock();
    }

    /** Chaîne décrivant la stratégie d'allocation. */
    public String nomStrategie() {
        return "Priorité aux petits demandeurs";
    }

}

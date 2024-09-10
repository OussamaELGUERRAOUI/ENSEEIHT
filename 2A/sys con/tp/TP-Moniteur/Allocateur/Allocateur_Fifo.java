import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;
import java.util.Queue;
import java.util.concurrent.locks.Condition;
import java.util.LinkedList;

public class Allocateur_Fifo implements Allocateur {
    // Nombre de ressources actuellement disponibles
    // invariant 0 <= nbLibres <= nbRessources
    private int nbLibres;
    private final int nbRessources;

    // Protection des variables partagées
    private Lock moniteur;

    // Une condition de blocage par taille de demande
    // tableau [nbRessources+1] dont on n'utilise pas la case 0
    private Condition[] classe;

    // Le nombre de processus en attente à chaque étage
    private Queue<Integer> fileAttente;

    public Allocateur_Fifo (int nbRessources) {
        this.nbRessources = nbRessources;
        this.nbLibres = nbRessources;
        this.moniteur = new ReentrantLock();
        this.classe = new Condition[nbRessources + 1];

        for (int i = 1; i <= nbRessources; i++) {
            classe[i] = moniteur.newCondition();
        }
        this.fileAttente = new LinkedList<>();

    }

    private void reveiller_suivant(){
        if (!fileAttente.isEmpty()){
            Integer premierDemande = fileAttente.poll(); 
            classe[premierDemande].signal();
        }
    }
    
    @Override
    public void allouer(int demande) throws InterruptedException {
        moniteur.lock();
        fileAttente.add(demande);
        while (demande > nbLibres){
            classe[demande].await();
        }
        nbLibres -= demande;
        fileAttente.remove(demande);
        reveiller_suivant();
        moniteur.unlock();         
    }

    @Override
    public void liberer(int rendu) throws InterruptedException {
        moniteur.lock();
        nbLibres+= rendu;
        reveiller_suivant();
        moniteur.unlock();
        
    }

    @Override
    public String nomStrategie() {
        // TODO Auto-generated method stub
        return "Unimplemented method 'nomStrategie'";
    }
    
}

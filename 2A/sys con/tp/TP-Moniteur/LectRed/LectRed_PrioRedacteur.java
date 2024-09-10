// Time-stamp: <28 oct 2022 09:24 queinnec@enseeiht.fr>

import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;
import Synchro.Assert;

/** Lecteurs/rédacteurs
 * stratégie d'ordonnancement: priorité aux rédacteurs,
 * implantation: avec un moniteur. */
public class LectRed_PrioRedacteur implements LectRed
{

    // Nombre de lecteurs actuellement actifs
    // invariant 0 <= nbLecteurs    
    private int nbLecteurs;


    // Nombre de redecteurs actuellement actifs
    
    private boolean ecritureEncours;


    private Condition lecture;
    private Condition ecrturePossible;

    // Protection des variables partagées
    private Lock moniteur;

    

    public LectRed_PrioRedacteur() {
        this.nbLecteurs = 0;
        this.ecritureEncours = false;
        this.moniteur = new ReentrantLock();
        this.lecture = this.moniteur.newCondition();
        this.ecrturePossible = this.moniteur.newCondition();

        };


        


    

    public void demanderLecture() throws InterruptedException {
        moniteur.lock();
        if(this.ecritureEncours){
            lecture.await();    
        }
        nbLecteurs ++;
        moniteur.unlock();
    }

    public void terminerLecture() throws InterruptedException {
        moniteur.lock();
        while ((nbLecteurs != 0) ){
            nbLecteurs--;
        }
        ecrturePossible.signal();;
        moniteur.unlock();
    }

    public void demanderEcriture() throws InterruptedException {
        moniteur.lock();
        if(!(ecritureEncours) & (nbLecteurs == 0)  ){
            ecrturePossible.await();
        }
        else{
            ecrturePossible.signal();
        }
        ecritureEncours = true;
        moniteur.unlock();

    }

    public void terminerEcriture() throws InterruptedException {
        moniteur.lock();
        if (ecritureEncours){
            ecrturePossible.await();
        }else {
            lecture.signal();
        }
        ecritureEncours = false;
        moniteur.unlock();
    }

    public String nomStrategie() {
        return "Stratégie: Priorité Rédacteurs.";
    }
}

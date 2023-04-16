package allumettes;

/**
 * Ce class permet de créer une procuration pour un joueur qui triche avec un
 * etat d'arbitre non confiant. 
 * @author ELGUERRAOUI Oussama.
 */
public class Procuration implements Jeu {
    // Attributs
    int nombreAllumettes;
    // Nombre d'allumettes restantes.

    // Constructeur
    /**
     * @param nb_allu nombre d'allumettes restantes.
     */
    public Procuration(int nb_allu) {
        this.nombreAllumettes = nb_allu;
    }

    // Methodes

    /**
     * Obtenir le nombre d'allumettes encore en jeu.
     * @return nombre d'allumettes encore en jeu
     */
    public int getNombreAllumettes() {
        return this.nombreAllumettes;
    }

    /**
     * Modifier le nombre d'allumettes encore en jeu.
     * @param nombreAllumettes nouveau nombre d'allumettes
     */
    public void setNombreAllumettes(int nombreAllumettes) {
        this.nombreAllumettes = nombreAllumettes;
    }

    /**
     * arrêter le jeu, si un joueur triche, avec l'etat de l'arbitre non confiant.
     * @param nbPrises nombre d'allumettes prises.
     * @throws CoupInvalideException       tentative de prendre un nombre invalide
     *                                     des allumettes
     * @throws OperationInterditeException tentative de tricher avec un etat
     *                                     d'arbitre non confiant.
     */
    public void retirer(int nbPrises) throws CoupInvalideException {
        throw new OperationInterditeException("");

    }

}

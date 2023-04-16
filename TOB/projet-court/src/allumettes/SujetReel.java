package allumettes;

/**
 * Cette class permet de créer un sujet réel qui gére les allumettes prises.
 * @author ELGUERRAOUI Oussama.
 */

public class SujetReel implements Jeu {
    int nombreAllumettes;
    // le nombre d'allumettes restantes.

    /**
     * @param nombreAllumettes le nombre d'allumettes restantes.
     */
    public SujetReel(int nombreAllumettes) {
        this.nombreAllumettes = nombreAllumettes;
    }

    /**
     * @return le nombre d'allumettes restantes.
     */
    public int getNombreAllumettes() {
        return this.nombreAllumettes;
    }

    /**
     * gérer le nombre d'allumettes restantes.
     * @param nombreAllumettes le nombre d'allumettes restantes.
     */

    public void setNombreAllumettes(int nombreAllumettes) {
        this.nombreAllumettes = nombreAllumettes;
    }

    /**
     * permet de retirer des allumettes.
     * @param nbPrises le nombre d'allumettes à prendre par un joueur.
     * @throws CoupInvalideException
     */

    public void retirer(int nbPrises) throws CoupInvalideException {

        if (nbPrises > this.nombreAllumettes) {
            throw new CoupInvalideException(nbPrises, "> " + this.nombreAllumettes);
        } else if (nbPrises < 1) {
            throw new CoupInvalideException(nbPrises, "< 1");
        } else if (nbPrises > Jeu.PRISE_MAX) {
            throw new CoupInvalideException(nbPrises, "> " + Jeu.PRISE_MAX);
        }

        this.nombreAllumettes -= nbPrises;

    }

}

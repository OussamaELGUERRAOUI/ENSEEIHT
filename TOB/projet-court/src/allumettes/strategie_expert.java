package allumettes;

import java.util.Random;

/**
 * Cette class permet de créer une strategie experte qui permet de faire ganger
 * un joueur si possible.
 * @author ELGUERRAOUI Oussama.
 */

public class strategie_expert implements Strategie {
    // Methodes
    /**
     * @param jeu le jeu en cours
     * @return nombre d'allumettes à prendre qui est entre un et trois. ça dépend du
     * nombre d'allumettes restantes.
     */
    public int getPrise(Jeu jeu) {
        assert jeu != null;
        int nb_allumettes = jeu.getNombreAllumettes();
        int prise = 1;

        if (nb_allumettes % (Jeu.PRISE_MAX + 1) == 0) {
            prise = Jeu.PRISE_MAX;
        } else if (nb_allumettes % (Jeu.PRISE_MAX + 1) == 1
                || nb_allumettes % (Jeu.PRISE_MAX + 1) == Jeu.PRISE_MAX - 1) {
            prise = 1;

        } else {
            prise = Jeu.PRISE_MAX - 1;
        }
        return prise;

    }

    

}
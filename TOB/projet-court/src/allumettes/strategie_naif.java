package allumettes;

import java.util.Random;

/**
 * Cette class permet de créer une strategie naive pour un joueur. Ce joueur
 * peut gagner ou perdre, ça dépend de le nombre aléatoire.
 * @author ELGUERRAOUI Oussama.
 */

public class strategie_naif implements Strategie {
    // Methodes

    /**
     * @param jeu le jeu en cours
     * @return nombre d'allumettes à prendre .
     */
    public int getPrise(Jeu jeu) {
        assert jeu != null;
        Random random = new Random();
        int nombre_alea_13 = random.nextInt(Jeu.PRISE_MAX) + 1;
        // un nombre aléatoire entre un et trois.
        int nombre_alea_12 = random.nextInt(Jeu.PRISE_MAX) + 1;
        // un nombre aléatoire entre un et deux.
        int nb_allumettes = jeu.getNombreAllumettes();
        // le nombre d'allumettes restantes.

        if (nb_allumettes >= Jeu.PRISE_MAX) {
            return nombre_alea_13;
        } else if (nb_allumettes == Jeu.PRISE_MAX - 1) {
            return nombre_alea_12;
        } else {
            return 1;
        }
    }

   

}

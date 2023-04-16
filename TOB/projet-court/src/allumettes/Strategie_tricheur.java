package allumettes;

/**
 * Cette class permet de créer une strategie tricheur qui fait gagner un joueur
 * si l'arbitre est confiant.
 * @author ELGUERRAOUI Oussama.
 */

public class Strategie_tricheur implements Strategie {
    // Methodes
    /**
     * @param jeu peut etre sujetreel ou procuration, ça dépend de l'arbitre.
     * @return nombre d'allumettes à prendre qui est 1, car on a laissé deux allumettes
     * pour que ce joueur gagne.
     * @throws CoupInvalideException
     */

    public int getPrise(Jeu jeu) throws CoupInvalideException {
        assert jeu != null;

        System.out.println("[Je triche...] ");
        while (jeu.getNombreAllumettes() > 2) {
            jeu.retirer(1);
        }

        System.out.println("[Allumettes restantes : " + jeu.getNombreAllumettes() + "]");
        return 1;

    }

    public String getStrategie() {
        return "tricheur";
    }

}

package allumettes;

/**
 * Cette class permet de créer une strategie rapide pour un joueur. Pour finir
 * une partie plus rapidement.
 * @author ELGUERRAOUI Oussama.
 */

public class strategie_rapide implements Strategie {
    // Methodes
    /**
     * @param jeu
     * @return nombre d'allumettes à prendre qui est trois ou deux ou un.
     */
    public int getPrise(Jeu jeu) {
        assert jeu != null;
        int nb_allumettes = jeu.getNombreAllumettes();
        // nombre d'allumettes restantes.
        if (nb_allumettes >= Jeu.PRISE_MAX) {
            return Jeu.PRISE_MAX;
        } else if (nb_allumettes == Jeu.PRISE_MAX - 1) {
            return Jeu.PRISE_MAX - 1;
        } else {
            return 1;
        }
    }

   

}

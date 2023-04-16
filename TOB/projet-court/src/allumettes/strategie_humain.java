package allumettes;

import java.util.Scanner;
import javax.lang.model.util.ElementScanner6;

/**
 * Cette class permet de créer une strategie humaine pour un joueur.
 * @author ELGUERRAOUI Oussama.
 */

public class strategie_humain implements Strategie {
    private String nom_joueur;
    private String etat;
    private static Scanner scanner = new Scanner(System.in);

    /**
     * constructeur de la class strategie_humaine
     * @param nom  nom du joueur
     * @param etat etat de l'arbitre (confiant ou non confiant)
     */
    public strategie_humain(String nom, String etat) {
        this.nom_joueur = nom;
        this.etat = etat;
    }

    /**
     * @param jeu le jeu en cours
     * @return nombre d'allumettes à prendre.
     * @throws CoupInvalideException si le nombre d'allumettes
     * à prendre est invalide.
     * @throws OperationInterditeException si le joueur triche
     * mais avec les conditions de l'arbitre.
     */
    public int getPrise(Jeu jeu) throws CoupInvalideException {
        assert jeu != null;
        String nb_prise = scanner.nextLine();
        int allumettesprises = 0;

        try {

            allumettesprises = Integer.parseInt(nb_prise);

            return allumettesprises;
        } catch (NumberFormatException e) {
            if (nb_prise.equals("triche") && this.etat.equals("confiant")) {
                // si l'arbitre est confiant, le joueur peut tricher et on laisse quatre allumettes
                // afin que ce joueur retire
                // trois allumettes et gagne la partie.
                while (jeu.getNombreAllumettes() > Jeu.PRISE_MAX + 1) {
                    jeu.retirer(1);
                }
                System.out.println("[Une allumette en moins, plus que 4. Chut !]");
                System.out.print(this.nom_joueur + ", combien d'allumettes ? ");

                return getPrise(jeu);

            } else {
                System.out.println("Vous devez donner un entier.");
                System.out.print(nom_joueur + ", combien d'allumettes ? ");
                return getPrise(jeu);
            }

        }

    }

}

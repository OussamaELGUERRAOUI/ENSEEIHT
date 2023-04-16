package allumettes;

/**
 * arbitre qui gérer le jeu.
 * @author ELGUERRAOUI Oussama
 */

public class Arbitre {
    // Attributs
    private Joueur joueur1;
    // premièr Joueur 
    private Joueur joueur2;
    // deuxième Joueur 
    private String etatarbitre;
    // Etat de l'arbitre : confiant nonconfaint
    private String strategie1;
    // Strategie du premièr joueur 
    private String strategie2;
    // Strategie du deuxième joueur
    int tour = 1;
    // Compteur de tour pour savoir qui joue.

    // Constructeur
    /**
     * @param joueur1     Joueur 1
     * @param joueur2     Joueur 2
     * @param etatarbitre Etat de l'arbitre
     * @param str1        Strategie du joueur 1
     * @param str2        Strategie du joueur 2
     */
    public Arbitre(Joueur joueur1, Joueur joueur2, String etatarbitre, String str1, String str2) {
        this.joueur1 = joueur1;
        this.joueur2 = joueur2;
        this.etatarbitre = etatarbitre;
        this.strategie1 = str1;
        this.strategie2 = str2;

    }

    // Methodes
    /**
     * arbitrer le jeu entre deux joueurs en définant l'état de l'arbitre et les
     * stratégies des joueurs 
     * @param jeu Jeu
     * @throws CoupInvalideException
     */

    public void arbitrer(Jeu jeu) throws CoupInvalideException {

        int prise = 0;

        try {
            while (jeu.getNombreAllumettes() > 0) {
                System.out.println("Allumettes restantes : " + jeu.getNombreAllumettes());
                if (this.etatarbitre.equals("confiant")) {
                    if (this.strategie1.equals("tricheur")) {
                        if (tour % 2 == 1) {

                            prise = joueur1.getPrise(jeu);
                            System.out.println(joueur1.getNom() + " prend 1 allumette");
                            System.out.println(" ");
                            jeu.retirer(prise);
                            tour++;
                        } else {
                            sys_jeu(joueur2, prise, strategie2, jeu);
                            tour++;
                        }
                    } else if (this.strategie2.equals("tricheur")) {
                        if (tour % 2 == 1) {
                            sys_jeu(joueur1, prise, strategie1, jeu);
                            tour++;
                        } else {
                            prise = joueur2.getPrise(jeu);
                            System.out.println(joueur2.getNom() + " prend 1 allumette.");
                            System.out.println(" ");
                            jeu.retirer(prise);
                            tour++;
                        }
                    } else {
                        if (tour % 2 == 1) {
                            sys_jeu(joueur1, prise, strategie1, jeu);
                            tour++;
                        } else {
                            sys_jeu(joueur2, prise, strategie2, jeu);
                            tour++;
                        }
                    }
                } else {
                    if (this.strategie1.equals("tricheur")) {
                        prise = joueur1.getPrise(jeu);
                        tour++;

                    } else if (this.strategie2.equals("tricheur")) {

                        if (tour % 2 == 1) {
                            Jeu jeu2 = new SujetReel(jeu.getNombreAllumettes());
                            int save = sys_jeu(joueur1, prise, strategie1, jeu2);
                            jeu.setNombreAllumettes((jeu.getNombreAllumettes() - save));
                            tour++;
                        } else {
                            prise = joueur2.getPrise(jeu);
                            tour++;
                        }

                    } else {
                        if (tour % 2 == 1) {
                            sys_jeu(joueur1, prise, strategie1, jeu);
                            tour++;
                        } else {
                            sys_jeu(joueur2, prise, strategie2, jeu);
                            tour++;
                        }
                    }
                }
            }
            if (tour % 2 == 1 && jeu.getNombreAllumettes() == 0) {
                System.out.println(joueur2.getNom() + " perd !");
                System.out.println(joueur1.getNom() + " gagne !");
            } else if (tour % 2 == 0 && jeu.getNombreAllumettes() == 0) {
                System.out.println(joueur1.getNom() + " perd !");
                System.out.println(joueur2.getNom() + " gagne !");
            }

        } catch (OperationInterditeException e) {
            if (this.strategie1.equals("tricheur") || this.strategie1.equals("humain")) {
                System.out.println("Abandon de la partie car " + this.joueur1.getNom() + " triche !");
            } else {
                System.out.println("Abandon de la partie car " + this.joueur2.getNom() + " triche !");
            }
        } catch (CoupInvalideException e) {
            System.out.println("Impossible ! Nombre invalide : " + e.getCoup() + " (" + e.getProbleme() + ")");
            System.out.println(" ");

            arbitrer(jeu);

        }

    }

    /**
     * Méthode pour jouer le jeu.
     * @param joueur pour récupérer le nom du joueur
     * @param prise  pour récupérer le nombre d'allumettes prises
     */

    public int sys_jeu(Joueur joueur, int prise, String strategie, Jeu jeu) throws CoupInvalideException {

        if (strategie.equals("humain")) {
            System.out.print(joueur.getNom() + ", combien d'allumettes ? ");
        }
        prise = joueur.getPrise(jeu);
        System.out.println(joueur.getNom() + " prend " + prise + " allumette" + (prise > 1 ? "s" : "") + ".");
        jeu.retirer(prise);
        System.out.println(" ");
        return prise;
    }

}
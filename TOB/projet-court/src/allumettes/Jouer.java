package allumettes;

import javax.sql.rowset.spi.SyncFactoryException;

/**
 * Lance une partie des 13 allumettes en fonction des arguments fournis
 * sur la ligne de commande.
 * 
 * @author Xavier Crégut
 * @version $Revision: 1.5 $
 */
public class Jouer {

	public final static int nombre_allu = 13;

	/**
	 * Lancer une partie. En argument sont donnés les deux joueurs sous
	 * la forme nom@stratégie.
	 * 
	 * @param args la description des deux joueurs
	 */
	public static void main(String[] args) {
		Strategie strategie1;
		// Strategie du premier joueur .
		Strategie strategie2;
		// Strategie du deuxieme joueur.
		Jeu systemejeu = new SujetReel(nombre_allu);
		// le jeu qui sera arbitré.
		Jeu Procuration = new Procuration(nombre_allu);
		// le jeu qui permet d'éviter la triche du joueur si l'arbitre est non confiant.
		try {
			verifierNombreArguments(args);

			if (args.length == Jeu.PRISE_MAX - 1) {
				String etat = "nonconfiant";
				String[] Arg1 = soussplit(args[0]);
				String[] Arg2 = soussplit(args[1]);
				Arbitre arbitre = sousjouer(etat, Arg1[0], Arg2[0], Arg1[1], Arg2[1]);
				if (Arg1[1].equals("tricheur") || Arg2[1].equals("tricheur")) {
					arbitre.arbitrer(Procuration);
				} else {
					arbitre.arbitrer(systemejeu);
				}
			} else if (args.length == Jeu.PRISE_MAX) {
				if (args[0].equals("-confiant")) {
					String etat = "confiant";
					String[] Arg1 = soussplit(args[1]);
					String[] Arg2 = soussplit(args[2]);
					Arbitre arbitre = sousjouer(etat, Arg1[0], Arg2[0], Arg1[1], Arg2[1]);
					arbitre.arbitrer(systemejeu);

				} else {
					throw new ConfigurationException("Erreur de configuration");
				}
			}
		} catch (ConfigurationException e) {
			System.out.println();
			System.out.println("Erreur : " + e.getMessage());
			afficherUsage();
		} catch (CoupInvalideException e) {
			System.out.println();
			System.out.println("Erreur : " + e.getMessage());
			afficherUsage();
		} catch (ArrayIndexOutOfBoundsException e) {
			System.out.println();
			System.out.println("Erreur : " + e.getMessage());
			afficherUsage();
		} catch (NullPointerException e) {
			System.out.println();
			System.out.println("Erreur : " + e.getMessage());
			afficherUsage();
		}
	}

	/**
	 * @param etat
	 * @param nom1
	 * @param nom2
	 * @param strat1
	 * @param strat2
	 * @return arbitre
	 */
	public static Arbitre sousjouer(String etat, String nom1, String nom2, String strat1, String strat2) {
		Strategie strategie1 = Jouer.choixstrategie(strat1, nom1, etat);
		Joueur joueur1 = new Joueur(nom1, strategie1);
		Strategie strategie2 = Jouer.choixstrategie(strat2, nom2, etat);
		Joueur joueur2 = new Joueur(nom2, strategie2);
		return new Arbitre(joueur1, joueur2, etat, strat1, strat2);

	}

	/**
	 * @param nomstr le nom du joueur et sa stratégie, sous la forme nom@stratégie.
	 * @return un tableau de deux éléments, le premier étant le nom du joueur, le
	 * second étant la stratégie.
	 */
	public static String[] soussplit(String nomstr) {
		String[] Arg = nomstr.split("@");
		if (Arg.length != Jeu.PRISE_MAX - 1 || Arg[0].equals("")) {
			throw new ConfigurationException("Erreur de configuration");
		} else {
			return Arg;
		}
	}

	/**
	 * @param strategie la stratégie du joueur.
	 * @param nom le nom du joueur.
	 * @param etat l'état de l'arbitre.
	 * @return la stratégie du joueur.
	 */

	public static Strategie choixstrategie(String strategie, String nom, String etat) {
		if (strategie.equals("naif")) {
			return new strategie_naif();
		} else if (strategie.equals("rapide")) {
			return new strategie_rapide();
		} else if (strategie.equals("humain")) {
			return new strategie_humain(nom, etat);
		} else if (strategie.equals("expert")) {
			return new strategie_expert();
		} else if (strategie.equals("tricheur")) {
			return new Strategie_tricheur();
		} else {
			return null;
		}

	}

	/**
	 * Vérifier le nombre d'arguments. Il faut au moins 2 arguments pour un etat
	 * d'arbitre non triche, et au plus
	 * Trois arguments pour un etat d'arbitre triche.
	 * 
	 * @param args
	 */

	private static void verifierNombreArguments(String[] args) {
		final int nbJoueurs = 2;
		if (args.length < nbJoueurs) {
			throw new ConfigurationException("Trop peu d'arguments : "
					+ args.length);
		}
		if (args.length > nbJoueurs + 1) {
			throw new ConfigurationException("Trop d'arguments : "
					+ args.length);
		}
	}

	/** Afficher des indications sur la manière d'exécuter cette classe. */
	public static void afficherUsage() {
		System.out.println("\n" + "Usage :"
				+ "\n\t" + "java allumettes.Jouer joueur1 joueur2"
				+ "\n\t\t" + "joueur est de la forme nom@stratégie"
				+ "\n\t\t" + "strategie = naif | rapide | expert | humain | tricheur"
				+ "\n"
				+ "\n\t" + "Exemple :"
				+ "\n\t" + "	java allumettes.Jouer Xavier@humain "
				+ "Ordinateur@naif"
				+ "\n");
	}

}

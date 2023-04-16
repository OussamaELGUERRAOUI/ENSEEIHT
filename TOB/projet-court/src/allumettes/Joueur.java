package allumettes;

/**
 * définer les données d'un joueur.
 * @author ELGUERRAOUI Oussama
 */

public class Joueur {
	// Attributs
	private String nom_joueur;
	// Nom du joueur.
	private Strategie strategie;
	// Strategie du joueur.
	// Constructeur
	/**
	 * @param nom du joueur.
	 * @param strategie strategie du joueur.
	 */
	public Joueur(String nom, Strategie strategie) {
		this.nom_joueur = nom;
		this.strategie = strategie;
	}

	// Methodes
	/**
	 * récupérer le nom du joueur.
	 * @return le nom du joueur.
	 */
	public String getNom() {
		return this.nom_joueur;
	}

	/**
	 * récupérer la strategie du joueur
	 * @return la strategie du joueur
	 */
	public Strategie getStrategie() {
		return this.strategie;
	}

	/**
	 * modifier la strategie du joueur
	 * @param strategie
	 */

	public void setStrategie(Strategie strategie) {
		this.strategie = strategie;
	}

	/**
	 * récupérer le nombre d'allumettes que le joueur veut prendre
	 * @param jeu jeu
	 * @return le nombre d'allumettes que le joueur veut prendre
	 * @throws CoupInvalideException
	 */
	public int getPrise(Jeu jeu) throws CoupInvalideException {

		return this.strategie.getPrise(jeu);

	}

}

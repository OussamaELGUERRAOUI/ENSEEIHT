import java.io.*;
import java.nio.file.Path;
import java.util.*;
import java.io.IOException;
import java.nio.file.DirectoryStream;
import java.nio.file.Files;
import java.nio.file.Paths;

/** Analyser des donnÃ©es d'un fichier, une donnÃ©e par ligne avec 4 informations
 * sÃ©parÃ©es par des blancs : x, y, ordre (ignorÃ©e), valeur.
 */
public class Analyseur {
	/** Conserve la somme des valeurs associÃ©es Ã  une position. */
	private Map<Position, Double> cumuls;
	private List<String> fichiers ;

	/** Construire un analyseur vide. */
	public Analyseur() {
		cumuls = new HashMap<>();
		fichiers = new ArrayList<>();

	}

	/** Charger l'analyseur avec les donnÃ©es du fichier "donnees.java". */
	public void charger() {
		for (String fichier : getFichiers()) {
			System.out.println(fichier);
			Map<Position, Double> temp = new HashMap<>();
			try (BufferedReader in = new BufferedReader(new FileReader( fichier ))) {
				String ligne = null;
				while ((ligne = in.readLine()) != null) {
					String[] mots = ligne.split("\\s+");
					assert mots.length == 4;	// 4 mots sur chaque ligne
					int x;
					int y;
					double valeur;
					if (isF2(fichier)){
						x = Integer.parseInt(mots[1]);					 
						y = Integer.parseInt(mots[2]);
						valeur = Double.parseDouble(mots[4]);
					}else{
						x = Integer.parseInt(mots[0]);
						y = Integer.parseInt(mots[1]);
						valeur = Double.parseDouble(mots[3]);
					}
					Position p = new Position(x, y);

					if (valIsPos(x, y, valeur)){
						temp.put(p, valeur);
					}else{
						throw new MalformedFileException("le fichiet contient des valeurs négatives");
					}
					// cumuls.put(p, valeur(p) + valeur);
					// p.setY(p.getY() + 1);	//  p.y += 1;
				}
				cumuls.putAll(temp);
			} catch (IOException e) {
				throw new RuntimeException(e);
			} catch (MalformedFileException e) {
				System.out.println(e.getMessage());
			}
		}
	}

	public Boolean valIsPos(int x, int y, double v){
		return (x >= 0 && y >= 0 && v >= 0);
	}

	/** verfier un mot finit avec -f2.txt */
	public Boolean isF2(String mot){
		return mot.endsWith("-f2.txt");
	}

	public List<String> getFichiers() {
		Path dossier = Paths.get(".");
		try (DirectoryStream<Path> stream = Files.newDirectoryStream(dossier, "*.txt")) {
			for (Path fichier : stream) {
				fichiers.add(fichier.getFileName().toString());
			}
		} catch (IOException e) {
			throw new RuntimeException(e);
		}
		return fichiers;
	}

	/** Obtenir la valeur associÃ©e Ã  une position. */
	public double valeur(Position position) {
		Double valeur = cumuls.get(position);
		return valeur == null ? 0.0 : valeur;
	}

	/** Obtenir toutes les donnÃ©es. */
	public Map<Position, Double> donnees() {
		return Collections.unmodifiableMap(this.cumuls);
	}

	/** Affichier les donnÃ©es. */
	public static void main(String[] args) {
		Analyseur a = new Analyseur();
		a.charger();
		System.out.println(a.donnees());
		System.out.println("Nombres de positions : " + a.donnees().size());
	}
}

import java.rmi.Naming;

public class Client {
    public static void main(String[] args) {
        try {
            // Obtention de la référence à l'objet distant de la vidéothèque
            Videotheque videotheque = (Videotheque) Naming.lookup("//localhost/VideothequeService");

            // Création d'un film et enregistrement
            Film film = new FilmImpl("Titre du film", "localhost", 8080);
            videotheque.enregistrer(film);

            // Recherche d'un film
            Film filmRecherche = videotheque.rechercher("Titre du film");
            if (filmRecherche != null) {
                System.out.println("Film trouvé : " + filmRecherche.getTitre());
                System.out.println("Hôte : " + filmRecherche.getHost());
                System.out.println("Port : " + filmRecherche.getPort());
            } else {
                System.out.println("Film non trouvé.");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

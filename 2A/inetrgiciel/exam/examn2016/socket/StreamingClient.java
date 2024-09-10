import java.io.InputStream;
import java.net.Socket;

public class StreamingClient {
    public static void main(String[] args) {
        if (args.length != 1) {
            System.out.println("Usage: java StreamingClient <Titre>");
            return;
        }
        String titre = args[0];
        Videotheque videotheque = new VideothequeImpl();
        try {
            // Recherche du film dans la vidéothèque
            Film film = videotheque.rechercher(titre);
            if (film == null) {
                System.out.println("Film \"" + titre + "\" non trouvé dans la vidéothèque.");
                return;
            }
            System.out.println("Connecting to StreamingServer for film \"" + titre + "\"");

            // Connexion au serveur de streaming
            Socket socket = new Socket(film.getHost(), film.getPort());
            InputStream is = socket.getInputStream();

            // Affichage du film (supposons que VLC.show(buffer) est une méthode statique existante)
            byte[] buffer = new byte[1024];
            int bytesRead;
            while ((bytesRead = is.read(buffer)) != -1) {
                VLC.show(buffer); // Méthode statique pour afficher le contenu du film
            }

            // Fermeture de la connexion
            socket.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

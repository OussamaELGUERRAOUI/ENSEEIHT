import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.ServerSocket;
import java.net.Socket;

public class StreamingServer extends Thread {
    private String titre;
    private String fichier;
    private int port;
    private Videotheque videotheque;

    public StreamingServer(String titre, String fichier, int port, Videotheque videotheque) {
        this.titre = titre;
        this.fichier = fichier;
        this.port = port;
        this.videotheque = videotheque;
    }

    @Override
    public void run() {
        try {
            // Enregistrement du film dans la vidéothèque
            Film film = new FilmImpl(titre, "localhost", port);
            videotheque.enregistrer(film);

            // Création du serveur socket
            ServerSocket serverSocket = new ServerSocket(port);
            System.out.println("StreamingServer running on port " + port + " for film \"" + titre + "\"");

            while (true) {
                // Attente d'une connexion
                Socket clientSocket = serverSocket.accept();
                System.out.println("Client connected");

                // Envoi du contenu du fichier au client
                FileInputStream fis = new FileInputStream(fichier);
                OutputStream os = clientSocket.getOutputStream();
                byte[] buffer = new byte[1024];
                int bytesRead;
                while ((bytesRead = fis.read(buffer)) != -1) {
                    os.write(buffer, 0, bytesRead);
                }

                // Fermeture des flux et de la connexion
                fis.close();
                clientSocket.close();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        if (args.length != 3) {
            System.out.println("Usage: java StreamingServer <Titre> <Fichier> <Port>");
            return;
        }
        String titre = args[0];
        String fichier = args[1];
        int port = Integer.parseInt(args[2]);
        Videotheque videotheque = new VideothequeImpl();
        new StreamingServer(titre, fichier, port, videotheque).start();
    }
}

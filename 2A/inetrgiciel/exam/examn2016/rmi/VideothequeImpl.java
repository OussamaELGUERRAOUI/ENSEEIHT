import java.rmi.RemoteException;
import java.rmi.server.UnicastRemoteObject;
import java.util.HashMap;
import java.util.Map;

public class VideothequeImpl extends UnicastRemoteObject implements Videotheque {
    private Map<String, Film> films;

    public VideothequeImpl() throws RemoteException {
        super();
        films = new HashMap<>();
    }

    @Override
    public synchronized void enregistrer(Film f) throws RemoteException {
        films.put(f.getTitre(), f);
        System.out.println("Film \"" + f.getTitre() + "\" enregistré avec succès.");
    }

    @Override
    public synchronized Film rechercher(String titre) throws RemoteException {
        return films.get(titre);
    }
}

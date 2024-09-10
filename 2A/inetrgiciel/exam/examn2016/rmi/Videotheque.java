import java.rmi.Remote;
import java.rmi.RemoteException;

public interface Videotheque extends Remote {
    void enregistrer(Film f) throws RemoteException;
    Film rechercher(String titre) throws RemoteException;
}

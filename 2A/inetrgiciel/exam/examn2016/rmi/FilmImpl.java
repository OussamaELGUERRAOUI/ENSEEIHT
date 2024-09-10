import java.rmi.RemoteException;
import java.rmi.server.UnicastRemoteObject;

public class FilmImpl extends UnicastRemoteObject implements Film {
    private String titre;
    private String host;
    private int port;

    public FilmImpl(String titre, String host, int port) throws RemoteException {
        this.titre = titre;
        this.host = host;
        this.port = port;
    }

    @Override
    public String getTitre() throws RemoteException {
        return titre;
    }

    @Override
    public String getHost() throws RemoteException {
        return host;
    }

    @Override
    public int getPort() throws RemoteException {
        return port;
    }
}


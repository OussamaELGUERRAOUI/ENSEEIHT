import java.rmi.Remote;
import java.rmi.RemoteException;

public interface Film extends Remote {
    String getTitre() throws RemoteException;
    String getHost() throws RemoteException;
    int getPort() throws RemoteException;
}

import java.rmi.RemoteException;
import java.rmi.registry.Registry;
import java.rmi.registry.LocateRegistry;
import java.rmi.server.UnicastRemoteObject;
import java.util.HashMap;

public class CarnetImpl extends UnicastRemoteObject implements Carnet {	
	
    HashMap<String, RFiche> carnet = new HashMap<>();

	protected CarnetImpl() throws RemoteException {
		super();
	}

	@Override
	public void Ajouter(SFiche sf) throws RemoteException {
		carnet.put(sf.getNom(), new RFicheImpl(sf.getNom(), sf.getEmail()) );
		
		
		
	}

	@Override
	public RFiche Consulter(String n, boolean forward) throws RemoteException {

		return carnet.get(n);
	}
	
	public static void main (String[] arg) {
		
		try {
			Carnet c = new CarnetImpl();
			
			Registry registry = LocateRegistry.createRegistry(1099);
			
			registry.rebind("carnet", c);
		} 
		catch(Exception e) {
			e.printStackTrace();
		}
		

}
}
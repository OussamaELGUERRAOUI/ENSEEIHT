import java.rmi.RemoteException;
import java.rmi.server.UnicastRemoteObject;

public class RFicheImpl extends UnicastRemoteObject implements RFiche {
	
	private String nom ;
	private String mail;
	
	
	
	protected RFicheImpl(String n, String m) throws RemoteException {
		this.nom = n;
		this.mail = m;
	}


	
	

	@Override
	public String getNom() throws RemoteException {
		
		return this.nom;
	}

	@Override
	public String getEmail() throws RemoteException {
		
		return this.mail;
	}
	

}

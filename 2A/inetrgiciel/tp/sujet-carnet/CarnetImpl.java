
import java.rmi.RemoteException;
import java.rmi.registry.Registry;
import java.rmi.registry.LocateRegistry;
import java.rmi.server.UnicastRemoteObject;
import java.rmi.Naming;
import java.util.*;

public class CarnetImpl extends UnicastRemoteObject implements Carnet{
    private Hashtable<String, RFiche> carnet;
    private int nServ ;


    public CarnetImpl(int n) throws RemoteException {
        this.carnet = new Hashtable<>();
        this.nServ = n;
    }

    public void Ajouter(SFiche sf) throws RemoteException {
        RFiche rf = new RFicheImpl(sf.getNom(), sf.getEmail());
        this.carnet.put(sf.getNom(), rf);
    }


    public RFiche Consulter(String n, boolean forward) throws RemoteException {

        if(this.carnet.containsKey(n)){
            return this.carnet.get(n);
        }
        else{ 
            if(forward){
                try{
                    Registry registry = LocateRegistry.getRegistry("localhost", 1234);
                    int nServ = (1+this.nServ)%2;
                    String nomCarnet = "Carnet"+nServ;
                    Carnet c = (Carnet) registry.lookup(nomCarnet);
                    return c.Consulter(n, false);
                }
                catch(Exception e){
                    return null;
                }
            }
            else{
                return null;
            }
            
        }
       
    }


    public static void main(String[] args) {
        try{
            Carnet c0 = new CarnetImpl(0);

            Registry registry = LocateRegistry.createRegistry(1234);
            registry.rebind("Carnet0", c0);
            System.out.println("Carnet0 enregistre");

            Carnet c1 = new CarnetImpl(1);
            registry.rebind("Carnet1", c1);
            System.out.println("Carnet1 enregistre");
        }
        catch(Exception e){
            e.printStackTrace();
        }
    }
    
}

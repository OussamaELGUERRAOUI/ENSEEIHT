import java.rmi.*;
import java.rmi.server.*;
import java.util.*;
 
public class ChatServer {
public static void main (String[] argv) {
    try {
	    	System.setSecurityManager(new RMISecurityManager());
	    	Scanner s = new Scanner(System.in);
	    	System.out.println("Entrez votre nom et appuyez sur Entrée:");
	    	String name=s.nextLine().trim();
 
	    	Chat server = new Chat(name);	
 
	    	Naming.rebind("rmi://localhost/CHAT", server);
 
	    	System.out.println("[System] Le CHAT est prêt:");
 
	    	while(true){
	    		String msg = s.nextLine().trim();
	    		if (server.getClient() != null){
	    			ChatInterface client = server.getClient();
	    			msg = "["+server.getName()+"] "+msg;
	    			client.send(msg);
	    		}	
	    	}
 
    	}catch (Exception e) {
    		e.printStackTrace();
    	}
	}
}
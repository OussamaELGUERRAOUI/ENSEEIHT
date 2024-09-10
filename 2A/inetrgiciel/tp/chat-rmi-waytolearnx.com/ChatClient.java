import java.rmi.*;
import java.rmi.server.*;
import java.util.*;
 
public class ChatClient {
	public static void main (String[] argv) {
	    try {
		    	System.setSecurityManager(new RMISecurityManager());
		    	Scanner s = new Scanner(System.in);
		    	System.out.println("Entrez votre nom et appuyez sur Entrée:");
		    	String name = s.nextLine().trim();		    		    	
		    	ChatInterface client = new Chat(name);
 
		    	ChatInterface server = (ChatInterface)Naming.lookup("rmi://localhost/CHAT");
		    	String msg = "["+client.getName()+"] s'est connecté";
		    	server.send(msg);
		    	System.out.println("[System] Le CHAT est prêt:");
		    	server.setClient(client);
 
		    	while(true){
		    		msg = s.nextLine().trim();
		    		msg = "["+client.getName()+"] "+msg;		    		
	    			server.send(msg);
		    	}
 
	    	}catch (Exception e) {
	    		e.printStackTrace();
	    	}
		}
}
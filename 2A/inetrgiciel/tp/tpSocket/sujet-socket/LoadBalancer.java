import java.net.ServerSocket;
import java.net.Socket;

public class LoadBalancer {

    public static void main (String args[]) {
        ServerSocket serv = new  ServerSocket(8080) ;       
        try {
            Socket s = serv.accept();
            Slave slave = new Slave(s);
            slave.start();
        } catch(Exception e){
            System.out.println("An error");
        }
    }
}
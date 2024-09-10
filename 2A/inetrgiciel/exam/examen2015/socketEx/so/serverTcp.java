package so;
import java.io.*;
import java.net.*;


public class serverTcp {

    public static void main(String[] args) {
        try {
            // Create a server socket
            ServerSocket serverSocket = new ServerSocket(8080);

            while(true) {
                // Listen for a connection request
                Socket socket = serverSocket.accept();
                System.out.println("Client connected");

                clientTcp client = new clientTcp(socket);
                client.start();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
              
}

package so;
import java.io.*;
import java.net.*;



public class clientTcp extends Thread {

    private Socket socket;
    private static final int PORT = 1234;
    private static final String HOST = "localhost:C2";

    public clientTcp(Socket socket) {
        this.socket = socket;
    }

    public void run() {
        try {
            // Create a socket to connect to the server
            Socket serverSocket = new Socket(HOST, PORT);
            System.out.println("Connected to the server");

            // Create an input stream to receive data from the server
            InputStream fromServer = serverSocket.getInputStream();
            OutputStream toServer = serverSocket.getOutputStream();

            InputStream fromClient = socket.getInputStream();
            OutputStream toClient = socket.getOutputStream();

            Thread serverToClient = new Thread( new streamMsg(fromServer, toClient));
            Thread clientToServer = new Thread( new streamMsg(fromClient, toServer));

            serverToClient.start();
            clientToServer.start();

            serverToClient.join();
            clientToServer.join();

            serverSocket.close();
            socket.close();

           
        } catch (Exception e) {
            e.printStackTrace();
        }
        
    }
    
}
package so;
import java.io.*;


public class streamMsg implements Runnable {
    private InputStream in;
    private OutputStream out;

    public streamMsg(InputStream in, OutputStream out) {
        this.in = in;
        this.out = out;
    }

    public void run() {
        try {
            byte[] buffer = new byte[1024];
            int bytesRead;
            while ((bytesRead = in.read(buffer)) != -1) {
                out.write(buffer, 0, bytesRead);
                System.out.println("Message received: " + new String(buffer, 0, bytesRead));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
}

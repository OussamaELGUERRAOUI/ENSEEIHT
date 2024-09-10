
public class demoThread {

    public static void main(String[] a) {

        Compteur c2 = new Compteur(10, 2);

        Compteur c3 = new Compteur(15, 3);

        new Thread(c2).start();

        new Thread(c3).start();
    }
}
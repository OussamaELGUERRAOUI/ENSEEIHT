import java.util.concurrent.∗;

public class ExecutorExampleOld {

    public static void main(String[] a) throws Exception {

        final int NB = 10;

        ExecutorService exec = Executors.newCachedThreadPool();

        Future<?>[] res = new Future<?>[NB];

        for (int i = 0; i < NB; i++) { // lancement des travaux

            int j = i;

            exec.execute(new Runnable() {

                public void run() {

                    System.out.println("hello" + j); }});

                    res[i] = exec.submit(new Callable<Integer>() {

                        public Integer call() { return 3 ∗ j; }});

                    }

                    // r´ecup´eration des r´esultats

                    for (int i = 0; i < NB; i++) {

                        System.out.println(res[i].get());

                    }
}
}

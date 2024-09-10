public class ExempleThreadLocal {

    // Déclaration d'une variable ThreadLocal
    private static ThreadLocal<Integer> threadLocalVariable = new ThreadLocal<>();

    public static void main(String[] args) {
        // Création de deux threads
        Thread thread1 = new Thread(() -> {
            // Affectation de la variable thread-local pour le thread 1
            threadLocalVariable.set(1);
            threadLocalVariable.set(3);
            threadLocalVariable.set(5);


            // Affichage de la valeur pour le thread 1
            System.out.println("Thread 1 : " + threadLocalVariable.get());
        });

        Thread thread2 = new Thread(() -> {
            // Affectation de la variable thread-local pour le thread 2
            threadLocalVariable.set(2);
            threadLocalVariable.set(4);

            // Affichage de la valeur pour le thread 2
            System.out.println("Thread 2 : " + threadLocalVariable.get());
        });

        // Démarrage des threads
        thread1.start();
        thread2.start();
    }
}

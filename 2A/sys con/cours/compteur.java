


class Compteur implements Runnable {
    private int max;
    private int step;

    public Compteur(int max, int step) {

        this.max = max;
        this.step = step;
    }

    public void run() {

        for (int i = 0; i < max; i += step)

            System.out.println(i);
    }
}


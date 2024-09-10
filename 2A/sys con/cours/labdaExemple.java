
interface Operation {
    int operate(int a, int b);
}

public class LambdaExample {
    public static void main(String[] args) {
        // Utilisation d'une expression lambda pour l'addition
        Operation addition = (a, b) -> a + b;
        System.out.println("Addition: " + addition.operate(5, 3));

        // Utilisation d'une expression lambda pour la multiplication
        Operation multiplication = (a, b) -> a * b;
        System.out.println("Multiplication: " + multiplication.operate(5, 3));
    }
}

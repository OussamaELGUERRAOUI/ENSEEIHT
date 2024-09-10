import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import java.util.Random;


public aspect Debiteleve {
	public static final double LIMITE = 450.0;

    // Pointcut pour sélectionner les débits dépassant la limite
    pointcut exceedLimit(double amount) :
        call(void CompteCourant.debiter(double)) && args(amount) && if (amount > LIMITE);

    // Advice pour afficher un message et simuler la confirmation du débit
    @Before("exceedLimit(amount)")
    public void confirmDebit(JoinPoint joinPoint, double amount) throws OperationNonConfirmeeException {
        System.out.println("Débit supérieur à la limite de " + LIMITE + " euros. Montant du débit : " + amount);
        
        // Simuler la confirmation du débit avec un tirage aléatoire
        Random random = new Random();
        int randomNumber = random.nextInt(10);
        try {
        
        	if (randomNumber <= 2) {
            
        		System.out.println("Débit confirmé.");
        }
    
        } catch(OperationNonConfirmeeException ex) {
        	System.out.println(ex.getMessage());
        }

}

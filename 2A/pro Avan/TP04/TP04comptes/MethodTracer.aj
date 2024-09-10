import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;

@Aspect
public class MethodTracer {
    // Pointcut pour sélectionner les méthodes à tracer
    pointcut publicMethod():
        (execution(public * CompteSimple.*(..)) || execution(public * CompteCourant.*(..)));

    // Conseil pour tracer les appels de méthode
    @Before("publicMethod()")
    public void traceMethodCall(JoinPoint joinPoint) {
        System.out.println("Méthode appelée : " + joinPoint.getSignature() + " avec les arguments : " + joinPoint.getArgs());
    }
}

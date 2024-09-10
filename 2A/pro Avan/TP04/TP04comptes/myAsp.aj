import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;

public aspect myAsp {
	pointcut publicMethod():
        (execution(public * CompteSimple.*(..)) || execution(public * CompteCourant.*(..)));

    // Conseil pour tracer les appels de méthode
    @Before("publicMethod()")
    public void traceMethodCall(JoinPoint joinPoint) {
        System.out.println("Méthode appelée : " + joinPoint.getSignature() + " avec les arguments : " + joinPoint.getArgs());
    }

}

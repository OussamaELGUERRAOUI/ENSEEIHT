#include <stdio.h>    
#include <unistd.h>  
#include <stdlib.h>  
#include <signal.h> 
#include <sys/types.h>
#include <sys/wait.h>  
  
  
      /* Traitant du signal SIGUSR1 et SIGURS2 */
      void handler_sig(int signal) {
          printf("Reception %d_\n" ,signal) ;
          return ;
      }
   

     
      }
  
      int main(){

        sigset_t ens_sig1 ;
        
        sigemptyset(&ens_sig1); /* initialiser l'ensemble à vide */
        

    
          
        /* associer un traitant au signal SIGUSR1 */
        signal(SIGUSR1, handler_sig) ;
            
        /* associer un traitant au signal SIGUSR2 */
        signal(SIGUSR2, handler_sig) ;

        /* ajouter SIGUSR1 et SIGINT à l'ensemble */   
        sigaddset(&ens_sig1, SIGINT) ;
        sigaddset(&ens_sig1, SIGUSR2) ;

        printf("Je masque SIGINT et SIGUSR2\n");

        /* masquer le signal SIGINT */
        sigprocmask(SIG_BLOCK, &ens_sig1, NULL) ;
        /* masquer le signal SIGUSR2 */
        sigprocmask(SIG_BLOCK, &ens_sig1, NULL) ;
        sleep(10);


        /* envoie du deux signaux */
        kill(getpid(), SIGUSR1) ;
        kill(getpid(), SIGUSR1) ;
        sleep(5) ;
        kill(getpid(), SIGUSR2) ;
        kill(getpid(), SIGUSR2) ;
        sleep(10) ;


        /* demasque SIGUSR1 */
        sigprocmask(SIG_UNBLOCK, &ens_sig1, NULL) ;
        dormir(10);
        /* demasque SIGUSR2 */
        sigprocmask(SIG_UNBLOCK, &ens_sig1, NULL) ;

        printf("Salut\n");
        




        return EXIT_SUCCESS ;
      }

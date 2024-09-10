#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>


void handler(int signal) {
    printf("Reception %d\n", signal);
}

int main() {
    signal(SIGUSR1, handler);
    signal(SIGUSR2, handler);

    // Boucle infinie pour que le programme ne se termine pas immédiatement
    while(1) {
        sleep(1);
    }

    return 0;
}

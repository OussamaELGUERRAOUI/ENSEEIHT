#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>

#define MAX_COMMAND_LENGTH 100

int main() {
    char command[MAX_COMMAND_LENGTH];
    char *args[MAX_COMMAND_LENGTH / 2 + 1];
    int should_run = 1;

    while (should_run) {
        printf("$ ");
        fflush(stdout);

        // Lecture de la commande entrée par l'utilisateur
        fgets(command, MAX_COMMAND_LENGTH, stdin);

        // Suppression du caractère de fin de ligne
        command[strcspn(command, "\n")] = '\0';

        // Analyse de la commande en arguments
        char *token = strtok(command, " ");
        int i = 0;
        while (token != NULL) {
            args[i] = token;
            token = strtok(NULL, " ");
            i++;
        }
        args[i] = NULL;

        // Traitement des commandes internes
        if (strcmp(args[0], "exit") == 0) {
            should_run = 0;
        }
        else if (strcmp(args[0], "cd") == 0) {
            if (chdir(args[1]) != 0) {
                printf("Erreur: répertoire introuvable\n");
            }
        }

        // Exécution de la commande externe
        else {
            pid_t pid = fork();
            if (pid == 0) {
                if (execvp(args[0], args) == -1) {
                    printf("Erreur: commande introuvable\n");
                    exit(EXIT_FAILURE);
                }
            }
            else if (pid < 0) {
                printf("Erreur: fork a échoué\n");
            }
            else {
                wait(NULL);
            }
        }
    }

    return 0;
}
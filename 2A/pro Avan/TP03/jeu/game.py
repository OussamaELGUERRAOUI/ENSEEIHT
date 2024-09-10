from lmdc import *

def main():
    # Initialisation du jeu
    board, red_villains, blue_villains, shrimps, traps_red, traps_blue = init_game()
    current_color = "R"  # Le joueur rouge commence
    game_over = False

    while not game_over:
        if current_color == "R":
            color = "Rouge (Bateau)"
            traps = traps_red
            vilain = red_villains.pop(0)
        else:
            color = "Bleu (Soleil)"
            traps = traps_blue
            vilain = blue_villains.pop(0)

        col = ask_col(board, current_color, traps, shrimps, vilain)

        put_vilain(board, vilain[1], col, vilain[0])

        row, col = ask_play(board, current_color, traps, shrimps)

        token_pos = find_token(board)
        board[token_pos[0]][token_pos[1]] = "   "
        board[row][col] = " X "

        # Vérification des conditions de fin de jeu
        # (ex : un joueur atterrit sur un piège, plus de crevettes...)
        # Mettre à jour la variable game_over si nécessaire

        # Changement de joueur
        current_color = "B" if current_color == "R" else "R"

    # Afficher le résultat de la partie

if __name__ == "__main__":
    main()

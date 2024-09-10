import random

OBJ_LIST = [("PS", 0), ("ME", 0), ("GC", 1), ("BE", 1), ("PN", 2), ("BM", 2),
            ("BC", 3), ("LG", 3), ("BV", 4), ("CT", 4), ("BL", 5), ("SP", 5)]

VIL_RED = [("TR", 4), ("TR", 3), ("TR", 2), ("TR", 0), ("TR", 5), ("HR", 5),
           ("HR", 1), ("TR", 0), ("HR", 3), ("TR", 2), ("TR", 4), ("TR", 1)]

VIL_BLU = [("TB", 0), ("TB", 3), ("TB", 1), ("HB", 0), ("HB", 2), ("TB", 2),
           ("TB", 5), ("TB", 4), ("TB", 3), ("TB", 5), ("HB", 4), ("TB", 1)]

def init_game():
    board = [["   " for _ in range(6)] for _ in range(6)]
    for row in range(6):
        for col in range(6):
            board[row][col] = "   "
    for obj, line in OBJ_LIST:
        col = random.randint(0, 5)
        while board[line][col] != "   ":
            col = random.randint(0, 5)
        board[line][col] = obj

    red_villains = random.sample(VIL_RED, len(VIL_RED))
    blue_villains = random.sample(VIL_BLU, len(VIL_BLU))

    traps_red = random.sample(OBJ_LIST, 2)
    traps_blue = random.sample(OBJ_LIST, 2)

    return board, red_villains, blue_villains, 5, traps_red, traps_blue

def str_game(board, shrimps):
    board_str = "A B C D E F\n"
    for i, row in enumerate(board):
        board_str += "-" * 19 + "\n"
        board_str += str(i) + " |" + "|".join(row) + "|\n"
    board_str += "-" * 19 + "\n"
    board_str += "Crevettes : " + str(shrimps) + "\n"
    return board_str

def find_token(board):
    for i, row in enumerate(board):
        for j, cell in enumerate(row):
            if cell.strip() == "X":
                return i, j

def is_free(board, irow, icol):
    return board[irow][icol].strip() == ""

def ask_col(board, color, traps, shrimps, vilain):
    row = vilain[1]
    print(str_game(board, shrimps))
    print(f"Vous êtes {'Bateau' if color == 'R' else 'Soleil'}")
    print(f"Les pièges sont {traps[0][0]} et {traps[1][0]}")
    print(f"Le vilain {vilain[0]} apparaît dans la ligne {row}.")
    while True:
        col_input = input("Dans quelle colonne souhaitez-vous le placer ? ").upper()
        if len(col_input) == 1 and "A" <= col_input <= "F":
            col = ord(col_input) - ord("A")
            if is_free(board, row, col):
                return col
            else:
                print("La case n'est pas libre. Veuillez choisir une autre colonne.")
        else:
            print("Veuillez entrer une lettre entre A et F.")

def put_vilain(board, irow, icol, vilain):
    board[irow][icol] = vilain

def is_valid_move(board, color, start, end):
    if color == "R":  # Bateau (rouge) se déplace verticalement
        return start[1] == end[1] and 0 <= end[0] <= 5
    else:  # Soleil (bleu) se déplace horizontalement
        return start[0] == end[0] and 0 <= end[1] <= 5

def ask_play(board, color, traps, shrimps):
    print(str_game(board, shrimps))
    print(f"Vous êtes {'Bateau' if color == 'R' else 'Soleil'}")
    print(f"Les pièges sont {traps[0][0]} et {traps[1][0]}")
    while True:
        move_input = input("Sur quelle case souhaitez-vous aller ? ").upper()
        if len(move_input) == 2 and "A" <= move_input[0] <= "F" and "0" <= move_input[1] <= "5":
            row = int(move_input[1])
            col = ord(move_input[0]) - ord("A")
            if is_valid_move(board, color, find_token(board), (row, col)):
                return row, col
            else:
                print("Mouvement non valide. Veuillez choisir une autre case.")
        else:
            print("Veuillez entrer une lettre entre A et F suivie d'un chiffre entre 0 et 5.")


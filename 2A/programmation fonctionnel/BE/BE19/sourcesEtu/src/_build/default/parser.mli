type token =
  | INT of (int)
  | LPAR
  | RPAR
  | SEMICOL
  | COMA
  | DOT
  | DIM
  | BARRIER
  | AVAILABLETARGET
  | ROBOT
  | INITIALPOS
  | RED
  | GREEN
  | BLUE
  | YELLOW
  | BLACK
  | ANY
  | MOON
  | SATURN
  | STAR
  | SUN
  | EOF

val file :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Be.Plateau.t * (Be.Plateau.robot * (int * int)) list

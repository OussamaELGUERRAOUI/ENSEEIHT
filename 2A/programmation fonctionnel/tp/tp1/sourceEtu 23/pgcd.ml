(*  Exercice à rendre **)

(*  pgcd : int*int -> int
    parametre -> a : entier
                 b : entier
    pre -> a != 0 et b != 0
    calcul pgcd de deux entiers
    
    resultat -> le plus grand diviseur de a et b *)

let rec pgcd a b =
  if a = b then
     a
  else if a > b then 
    pgcd (a-b) b
  else 
    pgcd a (b-a);;


let%test _ = pgcd 12 3 = 3
let%test _ = pgcd 24 32 = 8
let%test _ = pgcd 20 7 = 1
let%test _ = pgcd 10 10 = 10



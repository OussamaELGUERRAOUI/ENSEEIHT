(*  Exercice à rendre **)
(*  TO DO : contrat *)
let rec pgcd a b = 
  if a == b then
    a
  else if a > b then
    pgcd (a-b) b
  else
    pgcd a (b-a);;

(*  TO DO : tests unitaires *)

let test = pgcd 12 4
let test2 = pgcd 21 23 == 1



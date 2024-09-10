
(*  
   fact : int -> int
   calcule la factorielle
   Parametre n : int, le nombre dont on veut la factorielle
   Resultat : int, factorielle de n
   Précondition : n strictement positf
*)

let rec fact n  = 
  if n = 1
  then 1
  else n * (fact (n-1)) 

let a =  fact 5;;
let b =  fact 4 * 5;;
let test _ =  a = b;;


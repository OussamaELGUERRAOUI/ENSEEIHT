(* open Graphics *)
(* open Affichage *)

(* Exercice 2 *)
(*  
   coeff_directeur : float*float -> float*float -> float
   calcule le coefficient directeur de la droite représentée par deux points
   Parametre (x1, y1) : float*float, le premier point
   Parametre (x2, y2) : float*float, le second point
   Resultat : float, le coefficient directeur de la droite passant par
   (x1, y1) et (x2, y2)
*)

let coeff_directeur (x1,y1) (x2,y2) = 
   if x1 = x2 then 0.
   else (y2 -. y1) /. (x2 -. x1)


let%test _  = coeff_directeur (0., 0.) (1., 2.) = 2.
let%test _  = coeff_directeur (1., 2.) (0., 0.) = 2.
let%test _  = coeff_directeur (0., 0.) (2., 1.) = 0.5
let%test _  = coeff_directeur (0., 0.) (-2., 1.) = -0.5
let%test _ = coeff_directeur (1., 2.) (2., 1.) = -1


(* Exercice 3 *)
(* Les contrats et tests des fonctions ne sont pas demandés *)
(* f1 : int * int -> bool *)
let f1 (x,y) = x mod y = 0

(* f2 : int -> bool *)
let f2 x = x mod 2 = 0

(* f3 : 'a -> 'a *)
let f3 x = x

(* f4 : 'a * 'a -> bool *)
let f4 (x,y) = x = y

(* f5 : 'a * 'b -> 'a *)
let f5 (x,y) = x

(* f6 : 'a -> 'b -> 'a *)


(* Exercice 4 *)
(* ieme : TO DO type *)
(* renvoie le ième élément d'un triplet *)
(* t : le triplet *)
(* i : l'indice de l'élèment dans le triplet *)
(* renvoie le ième élément t *)
(* précondition : 1 =< i =< 3 *)

let ieme t i =  
   let (a,b,c) = t in
   if i == 1 then
      a
   else if i == 2 then 
      b
   else
      c;;




let test1 = ieme (5,60,7) 1 = 5
let test2 = ieme (5,60,17) 2 = 60
let%test _ = ieme (5,60,17) 3 = 17
let%test _ = ieme ('r','e','l') 1 = 'r'
let%test _ = ieme ('r','e','l') 2 = 'e'
let%test _ = ieme ('r','e','l') 3 = 'l'


(* Exercice 5 *)
(* PGCD -> pgcd.ml *)

(* Exercice 6 *)
(*  padovan : int -> int
Fonction qui calcule la nième valeur de la suite de Padovan : u(n+3) = u(n+1) + u(n); u(2)=1, u(1)=u(0)=0 
Paramètre n : un entier représentant la nième valeur à calculer
Précondition : n >=0
Résultat : un entier la nième valeur de la suite de Padovan 
*)

let rec padovan n = 
   if n = 0 || n = 1 then
      0
   else if n = 2 then 
      1
   else
      padovan (n-2) + padovan (n-3)


let test1 = padovan 0 == 0
let test2 = padovan 1 == 0 
let test3 = padovan 2 == 1
let test4 = padovan 3 == 0
let test5 = padovan 4 == 1
let test6 = padovan 5 == 1
let test7 = padovan 6 == 1
let test8 = padovan 7 == 2
let  test9 = padovan 8 == 2
let test10 = padovan 9 == 3
let test11 = padovan 10 == 4


(* Exercice 7 *)
(* estPremier : int -> bool
fonction qui indique si un nombre est premier
Paramètre n : un entier naturel dont on doit dire s'il est premier ou pas
Précondition : n >= 0
Résultat : l'information de si n est premier ou pas
*)

let estPremier n = 
   if n <= 1 then false
   else if n = 2 then true 
   else
      let rec est_pre_aux d =
         if d*d > n then true
         else if n mod d = 0 then false
         else est_pre_aux (d+1)

      in
      est_pre_aux 2



let test1 = estPremier 2
let test2  = estPremier 3 
let test3 = not (estPremier 4)
let test4 = estPremier 5
let test5  = estPremier 6
let test5 = estPremier 7
let test6  = not (estPremier 8)
let test7 = not (estPremier 9)
let test8 = not (estPremier 10)
let test8 = not (estPremier 0)
let test9 = not (estPremier 1)

let test21 = estPremier 1217


(*****************************)
(****** Bonus "ludique" ******)
(*****************************)


(*  Création de l'écran d'affichage *)
(* let _ = open_graph " 800x600" *)

(* Exercice 8 *)
(*  
   dragon : (int*int) -> (int*int) -> int -> unit
   Dessine la courbe du dragon à partir de deux points et d'une précision.
   Parametre (xa,ya) : (int*int), coordonnées de la première extrémité du dragon
   Paramètre (xb,yb) : (int*int), coordonnées de la seconde extrémité du dragon
   Paramètre n : nombre d'itération (plus n est grand, plus la courbe aura de détails)
   Resultat : unit, affichage de la courbe du dragon sur l'écran
   Précondition : n positif ou nul
*)

let dragon (xa,ya) (xb,yb) n = failwith "TO DO"

(* let%test_unit _ = dragon (200,350) (600,350) 20; *)

(*  Fermeture de l'écran d'affichage *)
(* close_graph() *)

(* Exercice 1*)

(* max : int list -> int  *)
(* Paramètre : liste dont on cherche le maximum *)
(* Précondition : la liste n'est pas vide *)
(* Résultat :  l'élément le plus grand de la liste *)
let max lis = 
  match lis with 
  | t :: q -> List.fold_left (fun t x -> if t < x then x else t) t q
  | [] -> failwith "lsite vide" 

let test1 = max [1;5;6;4;2]

(* TO DO : copier / coller les tests depuis conwayTests.txt *)

(* max_max : int list list -> int  *)
(* Paramètre : la liste de listes dont on cherche le maximum *)
(* Précondition : il y a au moins un élement dans une des listes *)
(* Résultat :  l'élément le plus grand de la liste *)
let max_max liste =
  let rec aux_list_max l =
    match l with
    | [] -> []
    | t :: q -> max t :: aux_list_max q 
  in
  max (aux_list_max liste)    

let test2 = max_max [ [ 1; 1; 1 ]; [ 2; 1; 2 ]; [ 3; 2; 1; 4; 2 ]; [ 1; 3; 2 ] ]


(* TO DO : copier / coller les tests depuis conwayTests.txt *)


(* Exercice 2*)

(* suivant : int list -> int list *)
(* Calcule le terme suivant dans une suite de Conway *)
(* Paramètre : le terme dont on cherche le suivant *)
(* Précondition : paramètre différent de la liste vide *)
(* Retour : le terme suivant *)

let suivant liste =
  let acc = 1 in
  let rec aux_list ac l =
    match l with
    | t1 :: t2 :: q -> if t1 = t2 then aux_list (ac+1) (t2 :: q)
                    else ac :: t1 :: aux_list acc (t2 :: q)
    |t :: [] ->  [ac; t]
    |[] -> []
  in
  aux_list acc liste 

let test3 = suivant [ 1; 3; 3; 4 ]


(* TO DO : copier / coller les tests depuis conwayTests.txt *)

(* suite : int -> int list -> int list list *)
(* Calcule la suite de Conway *)
(* Paramètre taille : le nombre de termes de la suite que l'on veut calculer *)
(* Paramètre depart : le terme de départ de la suite de Conway *)
(* Résultat : la suite de Conway *)
let rec suite indice term1 =
  match indice with
  | 1 -> [term1]
  | _ -> let pro_term = suivant term1 in
         term1 :: suite (indice-1) pro_term

let test4 = suite 5 [1] = [ [ 1 ]; [ 1; 1 ]; [ 2; 1 ]; [ 1; 2; 1; 1 ]; [ 1; 1; 1; 2; 2; 1 ] ]

(* TO DO : copier / coller les tests depuis conwayTests.txt *)

(* Tests de la conjecture *)
(* "Aucun terme de la suite, démarant à 1, ne comporte un chiffre supérieur à 3" *)
(* TO DO *)
(* Remarque : TO DO *)
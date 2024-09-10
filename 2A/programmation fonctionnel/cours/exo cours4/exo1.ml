
type  'a arbre_binaire = 
  | Empty
  | Node of 'a * 'a arbre_binaire * 'a arbre_binaire ;;



let x =  Node (1 ,
Node (2  ,
Node (3 ,Empty , Empty ) ,
Node (4 ,Node (1 ,Node (9 ,Empty , Empty ) , Empty ) , Node (1 ,Empty , Empty ) )
) ,
Node (5 ,
Node (1 ,Empty , Empty ) ,
Empty
)
)
;;

let rec cmpt_elt arbre_binaire =
  match arbre_binaire with
  | Empty -> 0
  | Node (_, g, d) -> 1 + cmpt_elt g + cmpt_elt d ;;

let test_cmpt = cmpt_elt x

(* Définir une fonction qui cherche si un élément x apparaît dans un arbre.*)

let rec aprt_elt x arbre_binaire =
  match arbre_binaire with
  | Empty -> false
  | Node(n,g,d) -> if n = x then true 
              else (aprt_elt x g) || (aprt_elt x d) 

let test_apt =  aprt_elt 10 x

(*Définir une fonction qui calcule les profondeurs minimum et maximum d’un arbre.*)

let rec profondeur_maxi arbre_binaire = 
  match arbre_binaire with
  | Empty -> 0
  | Node(_,g,d) -> 1 + max (profondeur_maxi g) (profondeur_maxi d) ;;

let test_prof_max = profondeur_maxi x

let rec occurre_elt x arbre_binaire = 
  match arbre_binaire with 
  | Empty -> 0
  | Node (n,g,d) -> if n = x then 1 + (occurre_elt x g) + (occurre_elt x d) 
                    else (occurre_elt x g) + (occurre_elt x d)

let test_occ = occurre_elt 1 x


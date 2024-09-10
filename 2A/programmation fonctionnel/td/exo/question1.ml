
(* Définition du type arbre *)
type 'a arbre = Vide | Node of 'a arbre * 'a * 'a arbre ;;

let a = Noeud(Noeud(Noeud(Vide,1,Noeud(Vide,2,Vide)),3,Noeud(Vide,4,Noeud(Vide,5,Vide))),6,Noeud(Vide,7,Noeud(Vide,8,Vide)));;

(* Fonction qui renvoie la racine de l'arbre *)
let rec racine a = match a with
  | Vide -> failwith "arbre vide"
  | Node(_, r, _) -> r ;;

let a = racine a;;
(*fonction renvoie les deux fils de l'arbre droit et gauche*)
let b = fils_g a;

let  fils_g a =
  match a with
  | Vide -> failwith "arbre vide"
  | Node(g,_,_) -> g ;;

let a = Noeud(Noeud(Noeud(Vide,1,Noeud(Vide,2,Vide)),3,Noeud(Vide,4,Noeud(Vide,5,Vide))),6,Noeud(Vide,7,Noeud(Vide,8,Vide)));;
let b = fils_g a;;
(*la fonction qui renvoie la taille de l'arbre*)

let rec taille a =
  match a with
  |Vide -> 0
  |Node(g,_,d) -> 1 + taille g + taille d ;;

let a = Node(Node(Node(Vide,1,Node(Vide,2,Vide)),3,Node(Vide,4,Node(Vide,5,Vide))),6,Node(Vide,7,Node(Vide,8,Vide)));;
let c = taille a;;
(*la fonction qui renvoie la hauteur de l'arbre*)

let rec hauteur a =
  match a with
  | Vide -> 0
  | Node(g,_,d) -> if taille g > taille d then 1 + hauteur g else 1 + hauteur d ;;

let h = hauteur a


(*q2 :  Écrire une fonction recherche: ’a -> ’a arbre -> bool qui teste si un élément x est présent dans un
arbre a. Modifier cette procédure pour qu’elle renvoie un sous-arbre de a enraciné en x (et l’arbre vide si x
n’est pas une clé de a).*)

let rec existe x arb = 
  match arb with
  | Vide -> false
  | Node(g,n,d) -> if x = n then true else (existe x g) || (existe x d) ;;

let exi = existe 5 a


let rec sous_arb x arb = 
  match arb with
  | Vide -> Vide
  | Node(g,n,d) -> if x = n then arb else if (existe x g) then sous_arb x g else if (existe x d) then sous_arb x d else Vide 

let s_arb = sous_arb 20 a


(*question 3*)

let trouve_mot cle arbre =
  if existe cle arbre then
    let rec aux_mots arbre =
      match arbre with
      | Vide -> [[]]
      | Node (g, n, d) ->
        if n = cle then
          if existe n g && existe n d then
            (List.map (fun li -> "d" :: li) (aux_mots (sous_arb cle d))) @
            (List.map (fun li -> "g" :: li) (aux_mots (sous_arb cle g)))
          else if existe n d then
            List.map (fun li -> "d" :: li) (aux_mots (sous_arb cle d))
          else if existe n g then
            List.map (fun li -> "g" :: li) (aux_mots (sous_arb cle g))
          else
            [[]]
        else
          [[]]
    in
    let liste_mot = aux_mots arbre in
    List.map (String.concat "") liste_mot 
  else
    failwith "L'élément n'est pas une clé de l'arbre";;

let b = Node(Node(Node(Vide,3,Node(Vide,3,Vide)),3,Node(Vide,4,Node(Vide,3,Vide))),3,Node(Vide,3,Node(Vide,8,Vide)));;
let test_rech = trouve_mot 3 b;;



                         




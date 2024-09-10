open Util

(* Type de base : arbre binaire avec information dans les feuilles. *)
type btree = Node of btree * btree | Leaf of char

(* Un exemple pour la suite *)
let bt1 =
    Node (
        Node (
            Node (
                Leaf 'a',
                Leaf 'b'
            ),
            Leaf _0
        ), Node (
            Leaf _0,
            Node (
                Leaf 'c',
                Leaf 'd'
            )
        )
    )

let _0 = Char.chr 0

(* empty_btree : btree
 * Retourne l'arbre vide (qui ne "contient que des _0")
 *)
let empty_btree = Node(Leaf _0, Leaf _0)

(* height : btree -> int
 * Calcule la hauteur d'un arbre binaire.
 *
 * Paramètre :
 *   tr : btree, arbre dont on veut la hauteur
 * Retour :
 *   hauteur de l'arbre
 *)
let rec height tr = 
    match tr with
    |Node(g,d) -> max (height g) (height d) + 1
    |Leaf _ -> 0 

let test  =
    height (Leaf _0) = 0
let test1 =
    height (Node (Leaf _0, Node (Leaf _0, Leaf _0))) = 2
let test2 =
    height bt1 = 3

(* num_nodes : btree -> int
 * Calcule le nombre de noeuds de l'arbre passé en paramètre
 *
 * Paramètres :
 *   tr : btree, arbre dont on veut le nombre de noeuds
 * Retour :
 *   nombre de noeuds
 *)
let rec num_nodes tr = 
    match tr with
    |Node(g,d) -> num_nodes g + num_nodes d + 1
    |Leaf _ -> 1

let test3 = (num_nodes (Leaf _0)) = 1
let test4= (num_nodes (Node (Leaf 'a', Leaf 'b'))) = 3
let test5  = (num_nodes bt1) = 11

(* num_values : btree -> int
 * Calcule le nombre de valeurs stockées dans l'arbre qui ne sont pas
 * égales à _0.
 *
 * Paramètres :
 *   tr : btree, arbre dont on veut compter les valeurs
 * Retour :
 *   nombre de valeurs non nulles
 *)
let rec num_values tr = 
    match tr with
    | Node(g,d) -> num_values g + num_values d 
    | Leaf a -> if a = _0 then 
                  0
                else
                  1 

let test6 = (num_values (Leaf _0)) = 0
let test7 = (num_values (Leaf 'a')) = 1
let test8 = (num_values (Node (Leaf 'a', Leaf 'b'))) = 2
let test8 = (num_values bt1) = 4

(* bits : int -> int -> int list
 * Transforme une nombre binaire en liste de 0 et 1 de la taille
 * désirée, du bit le plus faible (la puissance de deux la plus basse) au
 * bit le plus fort.
 *
 * Paramètres :
 *   n : int, taille de la liste résultante
 *   addr : int, adresse
 * Retour :
 *   liste de taille n contenant les bits de addr du plus faible au plus fort
 * Pré-conditions :
 *   addr peut être codé sur n bits
 *)
let rec bits n addr = 




let%test "bits-0" = (bits 0 546) = []
let%test "bits-1" = (bits 2   3) = [1; 1]
let%test "bits-2" = (bits 6  11) = [1; 1; 0; 1; 0; 0]
let%test "bits-3" = (bits 3 121) = [1; 0; 0]
let%test "bits-4" = (bits 0   6) = []
let%test "bits-5" = (bits 1   6) = [0]
let%test "bits-6" = (bits 2   6) = [0;1]
let%test "bits-7" = (bits 3   6) = [0;1;1]
let%test "bits-8" = (bits 4   6) = [0;1;1;0]
let%test "bits-9" = (bits 5   6) = [0;1;1;0;0]
let%test "bits-10" = (bits 4   12) = [0;0;1;1]
let%test "bits-11" = (bits 4   13) = [1;0;1;1]

(* search : btree -> int list -> char
 * Parcours un arbre binaire selon l'adresse donnée et récupère
 * la valeur au bout du chemin.
 *
 * Paramètre :
 *   tr : btree, arbre à parcourir
 *   addr : int list, addresse du chemin, sous forme de liste de bits
 * Retour :
 *   valeur à la feuille au bout du chemin, ou _0 si le chemin n'existe pas
 *
 * Pré-condition
 *   la taille de l'addresse est supérieure à la profondeur de l'arbre
 *   => traité avec une exception pour avoir un patter matching exhaustif...
 *)
let rec search tr addrl = 
    match (addrl,tr) with
    |(t::q, Node(g,d)) -> if t = 1 then search d q
                          else search g q
    |(_, Leaf a) -> a
    |([],_) -> _0

let test  =
    search bt1 [0; 0; 0] = 'a'
let test  =
    search bt1 [0; 1; 0] = _0
let test  =
    search bt1 [1; 0; 1] = _0
let test  =
    search bt1 [1; 1; 0] = 'c'

(* sprout : char -> int list -> btree
 * Crée un arbre contenant le chemin correspondant à l'addresse passée en
 * paramètre, au bout duquel se trouve la valeur passée en paramètre.
 * Le reste de l'arbre résultant ne contient que des _0.
 *
 * Paramètres :
 *   x : char, valeur à rajouter
 *   addrl : int list, adresse de la valeur, sous forme d'une liste de bits
 * Retour :
 *   arbre qui contient la valeur x au bout du chemin de addr et des _0 partout
 *   ailleurs
 *)



let rec sprout x addrl =
    match addrl with
    | t :: q -> if t = 0 then
                  Node(sprout x q, Leaf _0)
                else
                    Node(Leaf _0 ,sprout x q)  
    | [] -> Leaf x
                      
                      
                      
                      
                      
                      

let test  =
    let tr = sprout 'z' [] in
        height tr = 0 &&
        search tr [] = 'z'
let test2 =
    let tr = sprout 'z' [0] in
        height tr = 1 &&
        search tr [0] = 'z' &&
        search tr [1] = _0
let test3 =
    let tr = sprout 'z' [1;0;1] in
        height tr = 3 &&
        search tr [0;0;0] = _0  &&
        search tr [1;0;0] = _0  &&
        search tr [0;1;0] = _0  &&
        search tr [1;1;0] = _0  &&
        search tr [0;0;1] = _0  &&
        search tr [1;0;1] = 'z' &&
        search tr [0;1;1] = _0  &&
        search tr [1;1;1] = _0

(* update : btree -> char -> int list -> btree
 * Remplace une valeur au chemin donné par la valeur passée en paramètre, le
 * chemin étant spécifié par une adresses (sous forme de liste de bits).
 *
 * Si le chemin n'existe pas complètement, cette fonction le crée.
 *
 * Paramètres :
 *   tr : btree, arbre à mettre à jour
 *   x : char, valeur à changer
 *   addrl : int list, adresse à modifier, sous forme de liste de bits
 * Retour :
 *   arbre modifié
 *
 * Pré-condition :
 *   la taille de l'adresse est supérieure ou égale à la profondeur de l'arbre
 *   => assuré par une exception pour avoir le pattern-matching exhaustif, mais ne 
 *   devrait pas arriver !
 *)
let rec update tr x addrl = 
    match (tr,addrl) with
    | (Leaf _, []) -> Leaf x
    | (Node(_,_), []) -> failwith "l'adresse n'est pas compatible à cet arbre "
    | (Leaf _ , t :: q ) -> if t = 0 then
                              Node(sprout x q, tr)
                            else
                                Node(tr, sprout x q)
    | (Node(g,d), t::q) -> if t = 0 then 
                            Node(update g x q, d)
                           else
                            Node(g,update g x q)


let test  =
    let tr = update (Leaf _0) 'a' [] in
        height tr = 0 &&
        search tr [] = 'a'
let test =
    let tr = update (Node (Leaf _0, Leaf _0)) 'a' [1] in
        height tr = 1 &&
        search tr [0] = _0 &&
        search tr [1] = 'a'
let test =
    let tr = update bt1 'z' [0; 0; 0] in
        height bt1 = 3 &&
        search tr [0;0;0] = 'z' &&
        search tr [1;0;0] = _0  &&
        search tr [0;1;0] = _0  &&
        search tr [1;1;0] = 'c' &&
        search tr [0;0;1] = 'b' &&
        search tr [1;0;1] = _0  &&
        search tr [0;1;1] = _0  &&
        search tr [1;1;1] = 'd'
let test  =
    let tr = update bt1 'z' [0; 1; 1] in
        height bt1 = 3 &&
        search tr [0;0;0] = 'a' &&
        search tr [1;0;0] = _0  &&
        search tr [0;1;0] = _0  &&
        search tr [1;1;0] = 'c' &&
        search tr [0;0;1] = 'b' &&
        search tr [1;0;1] = _0  &&
        search tr [0;1;1] = 'z' &&
        search tr [1;1;1] = 'd'


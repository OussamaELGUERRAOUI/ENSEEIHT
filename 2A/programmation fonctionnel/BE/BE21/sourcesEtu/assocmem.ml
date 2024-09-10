open Util
open Mem

(* get_assoc: get_assoc : int -> (int*char) list -> char -> char
parametre : - e : clé
            - l : la liste des couples (cle,valeur)
            - def : resultat dans le cas le cle n'existe pas
 Resultat : valeur associe à la clé q'on a entré            
 *)
let rec get_assoc e l def =
    match l with 
    | (cle,valeur) :: q -> if cle = e then valeur 
                          else (get_assoc e q def)
    | [] -> def                      

(* Tests unitaires : TODO *)




(* set_assoc : TODO
 *)
let rec set_assoc e l x = 

    match l with
    |(cle,vale) :: q -> if (cle = e) then
                            (cle,x) :: q
                        else
                            (cle,vale) :: (set_assoc e q x)
    |[] -> [(e,x)]               

(* Tests unitaires : TODO *)






module AssocMemory : Memory =
struct
    (* Type = liste qui associe des adresses (entiers) à des valeurs (caractères) *)
    type mem_type = (int*char) list

    (* Un type qui contient la mémoire + la taille de son bus d'adressage *)
    type mem = int * mem_type

    (* Nom de l'implémentation *)
    let name = "assoc"

    (* Taille du bus d'adressage *)
    let bussize (bs, _) = bs

    (* Taille maximale de la mémoire *)
    let size (bs, _) = pow2 bs

    (* Taille de la mémoire en mémoire *)
    let allocsize (bs, m) = pow2 (List.length m) 


    (* Nombre de cases utilisées *)
    let busyness (bs, m) = List.length m

    (* Construire une mémoire vide *)
    let clear bs = (bs,[])

    (* Lire une valeur *)
    let read (bs, m) addr = get_assoc addr m _0

    (* Écrire une valeur *)
    let write (bs, m) addr x = (bs, set_assoc addr m x)

end

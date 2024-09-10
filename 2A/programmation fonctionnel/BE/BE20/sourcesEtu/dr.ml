(*  Module qui permet la décomposition et la recomposition de données **)
(*  Passage du type t1 vers une liste d'éléments de type t2 (décompose) **)
(*  et inversement (recopose).**)
module type DecomposeRecompose =
sig
  (*  Type de la donnée **)
  type mot
  (*  Type des symboles de l'alphabet de t1 **)
  type symbole

  val decompose : mot -> symbole list
  val recompose : symbole list -> mot
end

(*question 1*)
module DRstring : DecomposeRecompose with type mot = string and type symbole = char  = 
struct
  
  type mot = string
  type symbole = char

  let decompose mot = 
    
    let taille_mot = String.length mot in

    let rec aux indice list =
      if indice < 0 then 
        list
      else
        aux (indice-1) (mot.[indice] :: list)
    in

    aux (taille_mot-1) []
  
  
  
  let rec recompose list = 
    match list with
    | [] -> ""
    | t :: q -> Char.escaped t ^ (recompose q)

end




(*question 2*)
module DRNat : DecomposeRecompose with type mot = int and type symbole = int =
struct

  type mot = int
  type symbole = int

  let decompose mot = 
    let rec aux mot list =
      let reste = mot mod 10 in
      if mot < 10 then
        mot :: list
      else
        aux ((mot-reste)/10) (reste :: list)
  in
  aux mot []

  
  let rec recompose list =
    let taille = List.length list in
    let rec aux_zero nombre_zero stri =
      if nombre_zero = 0 then
        (Char.escaped '1' ^ stri)
      else
        ((aux_zero (nombre_zero-1) stri)) ^ Char.escaped '0'
    
    in
    
    match list with 
    | [] -> 0
    | t :: q ->  t*(int_of_string (aux_zero (taille-1) "")) + recompose q

end



    
    
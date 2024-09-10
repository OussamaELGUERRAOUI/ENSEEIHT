(* Exercice 3 *)
module type Expression = sig
  (* Type pour représenter les expressions *)
  type exp


  (* eval : exp -> int*)
  (*parametre : expression qu'on veut calculer *)
  (*Resultat : la valeur du calcul *)
  val eval : exp -> int
end

(* Exercice 4 *)

module  ExpAvecArbreBinaire : Expression =
struct
  type op = Moins | Plus | Mult | Div
  type exp = Binaire of exp * op * exp | Entier of int

  let rec eval arb = 
    match arb with 
    | Entier a -> a
    | Binaire(arb_g, op, arb_d) -> match op with
                                   | Moins -> (eval arb_g) - (eval arb_d)
                                   | Plus ->  (eval arb_g) + (eval arb_d)
                                   | Mult -> (eval arb_g) * (eval arb_d)
                                   | Div -> (eval arb_g) / (eval arb_d)

 let arb = Binaire(Binaire(Entier 3, Plus, Entier 4),Moins, Entier 12)
 let test1 = eval arb
(* TO DO avec l'aide du fichier  expressionArbreBinaire.txt *)

(* Exercice 5 *)

module ExpAvecArbreNaire : Expression =
struct 
  type op = Moins | Plus | Mult | Div
  type exp = Naire of op * (exp list) | Entier of int


  let rec bienforme arbre =
    match arbre with
    | Naire (op, operands) ->
      (match op with
      | Mult | Plus -> (List.length operands >= 2)
      | Moins | Div -> (List.length operands = 2)
      ) && List.for_all bienformee operands
    | Entier _ -> true
    

  
  let en1 = Naire (Plus, [ Entier 3; Entier 4; Entier 12 ])
  let en2 = Naire (Moins, [ en1; Entier 5 ])
  let en3 = Naire (Mult, [ en1; en2; en1 ])
  let arb = Naire (Div, [ en3; Entier 2; Entier 3 ])
  let test = bienforme arb



  (* eval : exp-> int *)
(* Calcule la valeur d'une expression n-aire *)
(* Paramètre : l'expression dont on veut calculer la valeur *)
(* Précondition : l'expression est bien formée *)
(* Résultat : la valeur de l'expression *)
let rec eval_bienformee arb =
  if (bienforme arb) then
    match arb with 
     | Naire(op,t1::t2::q) -> (match op with 
                          | Plus -> List.fold_left (fun y x -> y + (eval_bienformee x)) 0 (t1::t2::q)
                          | Moins -> (eval_bienformee t1) - (eval_bienformee t2) 
                          | Mult -> List.fold_left (fun y x -> y * (eval_bienformee x)) 1 (t1::t2::q)
                          | Div -> (eval_bienformee t1)/(eval_bienformee t2) )
     | Entier a -> a
  else 
    failwith "Malexprimé"


let test1 = eval_bienformee en2  

(* TO DO avec l'aide du fichier  expressionArbreNaire.txt *)

module type Regle =
sig
  
  (*identifiants de la régle*)
  type tid = int

  (*type de donnée de la régle*)
  type td = char list

  (*identificateur de la régle*)
  (*signature : id : int
   resultat : identificateur de la régle*)
  val id : tid  
  
  (*appliquer la regle sur le terme
     signature : appliquer : td -> td list
     resultat : liste des charactaires généré selon la régle*)
  val appliquer : td -> td list
end


module Regle1 : Regle = struct
  type tid = int 
  type td = char list

  let id = 1

  let appliquer td =
    match List.rev td with
    | 'O' :: q -> [List.rev q @ ['O'; 'A']]
    | _ -> [td] 
    
end

let test1 = Regle1.appliquer ['B';'O'] = [['B'; 'O'; 'A']] 
let test2 = Regle1.appliquer ['B';] = [['B']] 





module Regle2 : Regle = struct
  type tid = int 
  type td = char list

  let id = 2

  let appliquer td = 
    match td with 
    | 'B' :: q -> [td @ q]
    | _ -> [td];;
end

let test3 = Regle2.appliquer ['B'; 'O'; 'A'] = [['B'; 'O'; 'A'; 'O'; 'A']]



(* Regle III ` : A partir d’une cha ` ˆıne contenant les sous-chaˆınes [’O’;’O’;’O] ou [’A’;’O’;’A’],
vous pouvez gen´ erer une cha ´ ˆıne ou ces sous-cha ` ˆınes ont et´ e remplac ´ ees par un ´ ’A’.
Par exemple [’B’;’O’;’O’;’O’;’O’] permet de gen´ erer ´ [’B’;’O’;’A’] et [’B’;’A’;’O’].*)
module Regle3 : Regle with type td = char list = 
struct
  type tid = int 
  type td = char list

  let id = 3
   
  let rec appliquer td =
  
    match td with
    | [] -> []
    | a :: b :: c :: q -> if [a ; b; c] = ['O'; 'O'; 'O'] || [a ; b; c] = ['A'; 'O'; 'A'] then (('A') :: q) :: (List.map (fun lis -> a :: lis) (appliquer ( b :: c :: q)))
                          else (List.map (fun l -> a :: l) (appliquer ( b :: c :: q))) 
    | a :: q -> List.map (fun l -> a :: l) (appliquer q)

end


let test4 = Regle3.appliquer ['B'; 'O'; 'O'; 'O'; 'O'; 'B'; 'A'; 'O'; 'A'] 


module Regle4 : Regle with type td = char list = 
struct 
  type tid = int
  type td = char list

  let id = 4

  let rec appliquer td = 
    match td with 
    | [] -> [[]]
    | 'A' :: 'A' :: q -> appliquer q
    | t :: q -> List.map (fun l -> t :: l) (appliquer q)

end

let test5 = Regle4.appliquer ['B'; 'A'; 'O'; 'A'; 'A'; 'B'; 'A'; 'A'; 'A'] 


module type ArbreReecriture =
sig
  
  type tid = int
  type td
  type arbre_reecriture = Noeud of td  * (branche list) and
  branche = tid * arbre_reecriture

  val creer_noeud : td -> tid -> branche list -> arbre_reecriture

  val racine : arbre_reecriture -> td
  val fils : arbre_reecriture -> branche list

  val appartient : td -> arbre_reecriture -> bool
  
end

(*module ArbreReecritureBOA : ArbreReecriture with type td = char list =
struct
  type tid = int 
  type td = char list
  type type arbre_reecriture = Noeud of td * (branche list) and
  branche = tid* arbre_reecriture


  let creer_noeud td tid brl = Noeud(td, tid, brl)
  
  let racine arb = 
    match arb with 
    | Noeud(td, _, _) -> td

  let fils arb =
    match arb with 
    |Noeud(_,brl) -> brl

  let rec appartient td arb =

    let rec aux_apprat td liste =
      match liste with 
      | [] -> false
      | t :: q -> if t = td then true 
                  else aux_appart q  
                in 

    match arb with 
    |Noeud(td1,brl) -> if td = td1 then true 
                      else match brl with 
                      | [] -> false
                      | (tid,sous_arb) :: q - > (appartient sous_arb) || ()*) 

   
    





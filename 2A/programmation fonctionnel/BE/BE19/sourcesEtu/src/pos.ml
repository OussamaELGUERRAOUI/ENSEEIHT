(* Exercice 1 *)

(* 1. Compléter. *)
open Plateau

let tous_les_robots : Plateau.robot list = [Rrouge; Rvert; Rbleu; Rjaune; Rnoir](* À FAIRE *)

let toutes_les_directions : Plateau.dir list = [Dhaut; Dgauche; Dbas; Ddroite](* À FAIRE *)

(* Exercice 2 *)

module type P = sig
  (*  Type pour représer les positions des cinq robots sur le plateau.
     Deux valeurs [p1] et [p2] de type [t] qui représentent les même
     positions de robot (i.e., pour tout robot [r], [get p1 r]
     et [get p2 r] retournent la même position) doivent être égales
     (i.e., [p1 = p2] retourne [true]). *)
  type t

  (*  Une valeur quelconque. *)
  val quelconque : t 

  (*  La position des robots dans la Figure 1 du sujet. *)
  val positions_sujet : t

  (*  [get pos robot] retourne la position (x, y) (c.f. Plateau.mli)
     de [robot] dans [pos]. *)
  val get : t -> Plateau.robot -> int * int

  (*  [set pos robot (x, y)] retourne la position [pos] avec le robot
     [robot] maintenant à la position ([x], [y])
     (c.f. Plateau.mli). *)
  val set : t -> Plateau.robot -> int * int -> t
end

(* 1. Décommenter et compléter. *)

module PosSimple : P with type t = (Plateau.robot*(int*int)) list   = 
struct 
   type t = (Plateau.robot*(int*int)) list

   let quelconque  = [(Rvert, (8,1)); (Rrouge, (8,3)); (Rnoir, (4,5)); (Rjaune, (14,9)); (Rbleu, (6,15))]

   let positions_sujet = [(Rvert, (8,1)); (Rrouge, (8,3)); (Rnoir, (4,5)); (Rjaune, (14,9)); (Rbleu, (6,15))]

   let rec get t rb = 
      match t with
      | [] -> (16,16) (* comme le robot n'existe pas*)
      | v::q -> match v with
               | (r,p) -> if r = rb then p 
               else (get q rb)  
   
   
   let set t rb pos = 
      let a = (rb , pos) in 
      t @ [a]

     
end

let t = PosSimple.positions_sujet
let test1 = PosSimple.get t Rrouge


 
  (*(\* Ne pas modifier la ligne suivante avant l'exercice 4 *\)
 * module Pos : P = PosSimple *)

(* Exercice 3 *)

module type NP = sig
  type t

  (*  [voisin (x, y) dir] retourne les coordonnées de la case
     adjacente à [(x, y)] dans la direction [dir]. Les coordonnées
     retournées peuvent être en dehors du plateau (ou même
     négatives). *)
  val voisin : int * int -> Plateau.dir -> int * int

  (*  [libre pos (x, y)] retourne [true] ssi aucun des robots dans
     [pos] n'occupe la case [(x, y)]. *)
  val libre : t -> int * int -> bool

  (*  [prochain_xy_dir plateau pos (x, y) dir] retourne [(x', y')], la
     position la plus lointaine qu'un robot en [(x, y)] peut atteindre
     dans la direction [dir] sans traverser de mur du [plateau] ni de
     robot dans [pos]. [(x', y')] est égal à [(x, y)] si le robot ne
     peut pas bouger dans la direction [dir]. [(x, y)] peut être dans [pos]. *)
  val prochain_xy_dir : Plateau.t -> t -> int * int -> Plateau.dir -> int * int

  (*  [prochaines_pos_dir plateau pos robot] retourne la liste des
     positions atteignables par un mouvement valide de [robot] sur
     [plateau] avec tous les robots (y compris [robot]) dans le
     spositions [pos]. Tous les éléments d ela liste retournée sotn de
     la forme [((r, d), p)] avec [r] = [robot], [d] la direction dans
     laquelle [robot] a bougé et [p] la nouvelle position atteinte par
     c emouvement ([p] doit être différent de [pos]). *)
  val prochaines_pos_robot :
    Plateau.t -> t -> Plateau.robot -> ((Plateau.robot * Plateau.dir) * t) list

  (*  [prochaines_pos plateau pos] retourne la liste de toutes les
     positions atteignables sur [plateau] en exactement un mouvement
     depuis [pos]. Le résultat enregistre également quel robot bouge
     et dans quelle direction. *)
  val prochaines_pos : Plateau.t -> t -> ((Plateau.robot * Plateau.dir) * t) list
end

(* 1. Décommenter et compléter. *)

 module MakeNextPos (Pos : P) : NP with type t = (Plateau.robot*(int*int)) list  = 
 struct

 let voisin position d = 
   match (d, position) with
   | (Dhaut, (x,y)) -> (x, y - 1)
   | (Dbas, (x,y)) -> (x, y +1)
   | (Dgauche, (x,y)) -> (x - 1, y)
   | (Ddroite, (x,y)) -> (x + 1, y)

 let rec libre t pos =
   match t with
   |[] -> false
   |r :: q -> match r with 
             | (_, p) -> if p = pos then true 
             else (libre q pos)


 let prochain_xy_dir pt t posi pd = 
   let dim = pt.dim
   let carres = pt.walls
   let target = pt.targets
   let rec voisin_libre t targets pos dir =          (*on verifie est-ce que la place prochaine est vide ou non*)
      if (libre t pos) then 
         match targets with 
         | tar :: q -> match tar with 
                       (x,y,_,_) -> if (fst (voisin pos dir) = x ) and (snd (voisin pos dir) = y) then false
                                   else (voisin_libre t q posi pd )
         |[] -> false
      else false 
   in   
   
   let  mur_pas pt pos dir =
      let mur = pt.walls
      match (dir,pos) with
      | (Dhaut,(x,y)) -> not (mur [x][y]).top 
      | (Ddroite,(x,y)) -> not (mur [x][y]).right
      | (Dgauche,(x,y)) -> not (mur [x][y]).left 
      | (Dbas,(x,y)) -> not (mur [x][y]).bottom  
   in

   if (fst posi < dim) and (snd posi < dim) then
      

      




 
 
    
 let positions_sujet = Pos.positions_sujet
 let plateau_vide = Plateau.make 16 [] []
 let plateau_sujet = Plateau.exemple
  end 

(* Exercice 4 *)

(* 1. Décommenter et compléter. *)

(* module PosMasque : P = struct
 *   (\* À FAIRE *\)
 * end *)

(* 2. Pour pouvoir compiler le programme complet avec PosMasque,
   décommenter la ligne suivante et commenter la ligne
   "module Pos : P = PosSimple" plus haut. *)
(* module Pos : P = PosMasque *)

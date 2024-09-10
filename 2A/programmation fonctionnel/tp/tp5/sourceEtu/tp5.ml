(* Evaluation des expressions simples *)


(* Module abstrayant les expressions *)
module type ExprSimple =
sig
  type t
  val const : int -> t
  val plus : t -> t -> t
  val mult : t-> t -> t
end

(* Module réalisant l'évaluation d'une expression *)
module EvalSimple : ExprSimple with type t = int =
struct
  type t = int
  let const c = c
  let plus e1 e2 = e1 + e2
  let mult e1 e2 = e1 * e2
end


(* Solution 1 pour tester *)
(* A l'aide de foncteur *)

(* Définition des expressions *)
module ExemplesSimples (E:ExprSimple) =
struct
  (* 1+(2*3) *)
  let exemple1  = E.(plus (const 1) (mult (const 2) (const 3)) )
  (* (5+2)*(2*3) *)
  let exemple2 =  E.(mult (plus (const 5) (const 2)) (mult (const 2) (const 3)) )
end

(* Module d'évaluation des exemples *)
module EvalExemples =  ExemplesSimples (EvalSimple)

let test1 = (EvalExemples.exemple1 = 7)
let test2 = (EvalExemples.exemple2 = 42)

(*question 1*)


module PrintSimple : ExprSimple with type t = string =
struct
  type t = string
  let const c = string_of_int c 
  let plus e1 e2 = "("^e1^ "+" ^e2^ ")"
  let mult e1 e2 = "("^e1^ "*" ^e2^ ")"
end

(* Module d'évaluation des exemples *)
module PrintExemple =  ExemplesSimples (PrintSimple)

let test3 = PrintExemple.exemple1 
let test4 = PrintExemple.exemple2 




(*question 2:  Écrire un module CompteSimple, conforme à ExprSimple, qui permet de compter les opérations
d’une expression.*)

module CompteSimple : ExprSimple with type t = int = 
struct
  type t = int
  let const c = 0
  let plus e1 e2 =  e1 + e2 + 1
  let mult e1 e2 =  e1 + e2 + 1
end


(* Module d'évaluation des exemples *)
module CompteExemple =  ExemplesSimples (CompteSimple)

let test5 = CompteExemple.exemple1 
let test6 = CompteExemple.exemple2


(*question 3: interface ExprVar*)

module type ExprVar =
sig
  type t
  type tvar
  val var : tvar -> t
  val def : (tvar*t) -> t -> t
end 

(*module Expr*)

module type Expr =
sig
  include ExprSimple
  include (ExprVar with type t:=t)
end


(*question 4: module Printer*)

module PrinterVar : ExprVar with type t = string =
struct
  type t = string
  type tvar = string

  let var c = c
  let def (tv, e1) e2 = "let " ^ tv ^ " = " ^ e1 ^ " in " ^ e2
end



module Print : Expr with type t = string =
struct 
  include PrintSimple
  include (PrinterVar : ExprVar with type t := t )
end

module ExemplesVars (E : Expr) =
struct
  include ExemplesSimples(E)
  let exemple3 = E.def ("x", E.plus (E.const 1) (E.const 2)) (E.mult (E.var "x") (E.const 3))
end



   


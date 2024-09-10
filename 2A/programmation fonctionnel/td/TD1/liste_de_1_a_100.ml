let rec n_a_zero n =
  match n with
  | 0 -> [0]
  |_ -> n :: n_a_zero (n - 1) ;;

let liste_a = n_a_zero 10 ;;

let rec zero_a_n n =
  match n with
  | 0 -> [0]
  |_ -> zero_a_n (n - 1) @ [n] ;;

let liste_a = zero_a_n 10 ;;

let position e l =
  n = length l
  for i = 0 to n - 1 do
    match l with
     | [] -> failwith "liste vide"
     | h::t -> if h = e then n else position e t


    

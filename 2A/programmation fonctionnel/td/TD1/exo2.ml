let rec map (f x -> x + 1) l =
  match l with
  | [] -> []
  | h::t -> (f h)::(map f t)

let f x = x + 1

let y = f 1

let liste1 = [1;2;30]
let liste = map liste1
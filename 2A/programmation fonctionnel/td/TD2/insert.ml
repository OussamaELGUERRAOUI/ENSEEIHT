let rec insert_everywhere x lst =
  match lst with
  | [] -> [[x]]
  | hd::tl -> (x::lst) :: (List.map (fun l -> hd::l) (insert_everywhere x tl));;



let resultat = insert_everywhere 5 [1; 2; 3] 
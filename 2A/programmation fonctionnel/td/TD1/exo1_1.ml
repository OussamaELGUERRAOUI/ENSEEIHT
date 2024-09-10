let deuieme_elt list =
  match list with
  | _ :: x :: _ -> x
  

let a = deuieme_elt ["1"; "2"; "3"; "4"; "5"]
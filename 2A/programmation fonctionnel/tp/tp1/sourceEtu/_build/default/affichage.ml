(* ouverture des modules a utiliser			*)
open Graphics

let dessine_segment (xa,ya) (xb,yb) =
  open_graph " 800x600";;
  moveto xa ya;
  lineto xb yb;;


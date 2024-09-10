let calcul_racine FilsGauche FrereDroit = let n = vect_length FilsGauche  in let V = make_vect n true in
for i = 0 to n-1 do
   match FilsGauche.(i),FrereDroit.(i) with
      (-1,-1) -> ()
      |(-1,j) -> V.(j) <- false
      |(j,-1) -> V.(j) <- false
      |(j1,j2) -> V.(j1) <- false; V.(j2) <- false
done;
let j=ref 0 in
   while not V.(!j) do
      incr j
   done;
   !j;;      
   
let FilsGauche1=[|5;-1;-1;-1;2;6;-1;0;-1|] and FrereDroit1=[|1;4;3;-1;-1;-1;8;-1;-1|];;
let FilsGauche2=[|-1;5;-1;1;10;-1;-1;-1;4;-1;-1|] and FrereDroit2=[|6;9;-1;-1;0;2;7;-1;-1;8;-1|];;      
 
calcul_racine FilsGauche1 FrereDroit1;; 
calcul_racine FilsGauche2 FrereDroit2;; 

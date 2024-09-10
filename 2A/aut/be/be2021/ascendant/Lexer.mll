{

(* Partie recopiée dans le fichier CaML généré. *)
(* Ouverture de modules exploités dans les actions *)
(* Déclarations de types, de constantes, de fonctions, d'exceptions exploités dans les actions *)

  open Parser 
  exception LexicalError

}

(* Déclaration d'expressions régulières exploitées par la suite *)
let chiffre = ['0' - '9']
let minuscule = ['a' - 'z']
let majuscule = ['A' - 'Z']
let alphabet = minuscule | majuscule
let alphanum = alphabet | chiffre | '_'
let commentaire =
  (* Commentaire fin de ligne *)
  "#" [^'\n']*

rule lexer = parse
  | ['\n' '\t' ' ']+					{ (lexer lexbuf) }
  | commentaire						{ (lexer lexbuf) }
  | "("              { UL_PAROUV }
  | ")"              { UL_PARFER }
  | "["              { UL_CROOUV }    
  | "]"              { UL_CROFER }
  | "{"							{ UL_ACCOUV }
  | "}"							{ UL_ACCFER }
  (*separateur*)
  | ","							{ UL_VIRG }
  | ";"							{ UL_PTVIRG }
  | ":"							{ UL_DEUXP }
  | "."              { UL_POINT }
 
  (*mot clé*)
  | "model"						{ UL_MODEL }
  |"int"              { UL_INT }
  |"float"              { UL_FLOAT }
  | "to"              { UL_TO }
  |"system"						{ UL_SYSTEM }
  |"bloc"						{ UL_BLOC }
  |"flow"						{ UL_FLOW }
  |"from"						{ UL_FROM }
  |"in"							{ UL_IN }
  |"out"							{ UL_OUT }
  |"true"							{ (UL_BOOLEEN true) }
  |"false"							{ (UL_BOOLEEN false) }
  (*nombre entier*)
  | (['1' - '9'] chiffre*) as texte			{ (UL_ENTIER (int_of_string nombre)) }
  (*nombre reel*)
  | (chiffre+ "." chiffre+)  as texte	{ (UL_FLOTTANT (float_of_string nombre)) }
  (*chaine de caractere*)
  | "\"" (['a' - 'z' 'A' - 'Z' '0' - '9' ' ' '_'])* "\"" as texte	{ (UL_CHAINE texte) }
  (*identificateur*)
  | majuscule alphabet* as texte		{ (UL_IDENT texte) }
  | minuscule alphabet* as texte		{ (UL_iDENT texte) }
  | eof							{ UL_FIN }
  | _ as texte				 		{ (print_string "Erreur lexicale : ");(print_char texte);(print_newline ()); raise LexicalError }

{

}

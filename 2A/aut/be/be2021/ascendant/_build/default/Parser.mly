%{

(* Partie recopiee dans le fichier CaML genere. *)
(* Ouverture de modules exploites dans les actions *)
(* Declarations de types, de constantes, de fonctions, d'exceptions exploites dans les actions *)

%}

/* Declaration des unites lexicales et de leur type si une valeur particuliere leur est associee */
%token UL_ACCOUV UL_ACCFER
%token UL_CROUV UL_CROFER
%token UL_PAROUV UL_PARFER
%token UL_MODEL UL_TO UL_SYSYTEM UL_BLOC UL_IN UL_OUT UL_FLOW UL_FROM
%token UL_ENTIER UL_FLOTTANT UL_CHAINE UL_BOOLEEN
%token UL_IDENT UL_iDENT 
%token UL_PTVIRG UL_VIRG UL_POINT UL_DEUXP


/* Defini le type des donnees associees a l'unite lexicale */
%token <int> UL_ENTIER
%token <float> UL_FLOTTANT
%token <string> UL_CHAINE
%token <bool> UL_BOOLEEN
%token <string> UL_IDENT


/* Unite lexicale particuliere qui represente la fin du fichier */

%token UL_FIN

/* Type renvoye pour le nom terminal document */
%type <unit> modele

/* Le non terminal document est l'axiome */
%start modele

%% /* Regles de productions */

modele : UL_MODEL UL_IDENT UL_ACCOUV boucleModel UL_ACCFER UL_FIN { (print_endline "modele : UL_MODEL IDENT { sous_modele } UL_FIN ") }

boucleModel : /* mot vide */ { (print_endline "sous_modele : /* mot vide */ ") }
            | sous_modele boucleModel { (print_endline "sous_modele : sous_modele { sous_modele } ") }

sous_modele : bloc
             | systeme 
             | flot 

bloc : UL_BLOC UL_IDENT parametres UL_PTVIRG { (print_endline "bloc : UL_BLOCK IDENT parametres UL_PVIRG ") }

systeme : UL_SYSYTEM UL_IDENT parametres UL_ACCOUV boucleMod UL_ACCFER { (print_endline "systeme : UL_SYSTEM IDENT parametres UL_ACCOUV { sous_systeme } UL_ACCFER ") }

parametres : /* mot vide */ { (print_endline "parametres : /* mot vide */ ") }
           | UL_PAROUV bouclePort UL_PARFER { (print_endline "parametres : UL_PAROUV bouclePort UL_PARFER ") }
    
bouclePort : /* mot vide */ { (print_endline "bouclePort : /* mot vide */ ") }
           | UL_VIRG port bouclePort { (print_endline "bouclePort : UL_VIRG port bouclePort ") }

port : UL_iDENT UL_DEUXP UL_IN type { (print_endline "port : IDENT UL_DEUXP UL_IN type ") }
     | UL_iDENT UL_DEUXP UL_OUT type { (print_endline "port : IDENT UL_DEUXP UL_OUT type ") }

type : sousType UL_CROUV bouclEntier UL_CROFER { (print_endline "type : sousType UL_CROUV bouclEntier UL_CROFER ") }
     | sousType  { (print_endline "type : sousType s ") }
     
bouclEntier : /* mot vide */ { (print_endline "bouclEntier : /* mot vide */ ") }
            | UL_VIRG UL_ENTIER bouclEntier { (print_endline "bouclEntier : UL_VIRG UL_ENTIER bouclEntier ") }

sousType : UL_ENTIER { (print_endline "sousType : UL_ENTIER ") }
         | UL_FLOTTANT { (print_endline "sousType : UL_FLOTTANT ") }
         | UL_BOOLEEN { (print_endline "sousType : UL_BOOLEEN ") }

flot : UL_FLOW UL_iDENT UL_FROM UL_iDENT UL_TO UL_PVIRG { (print_endline "flot : UL_FLOW IDENT UL_FROM IDENT UL_TO UL_PVIRG ") }
      | UL_FLOW UL_iDENT UL_FROM UL_iDENT UL_TO boucleFlot UL_PVIRG  { (print_endline "flot : UL_FLOW IDENT UL_FROM IDENT UL_TO boucleFlot UL_PVIRG  ") }
      | UL_FLOW UL_iDENT UL_FROM UL_iDENT UL_POINT UL_iDENT UL_TO UL_PVIRG  { (print_endline "flot : UL_FLOW IDENT UL_FROM IDENT UL_POINT IDENT UL_TO UL_PVIRG ") }
      | UL_FLOW UL_iDENT UL_FROM UL_iDENT UL_POINT UL_iDENT UL_TO boucleFlot UL_PVIRG { (print_endline "flot : UL_FLOW IDENT UL_FROM IDENT UL_POINT IDENT UL_TO boucleFlot UL_PVIRG ") }

boucleFlot : /* mot vide */ { (print_endline "boucleFlot : /* mot vide */ ") }
           | UL_VIRG identPoint  UL_iDENT  boucleFlot  { (print_endline "boucleFlot : UL_VIRG identPoint  UL_iDENT  boucleFlot ") }

identPoint : UL_POINT UL_iDENT { (print_endline "identPoint : UL_POINT UL_iDENT ") }


%%

%{

(* Partie recopiee dans le fichier CaML genere. *)
(* Ouverture de modules exploites dans les actions *)
(* Declarations de types, de constantes, de fonctions, d'exceptions exploites dans les actions *)

(* let nbrVariables = ref 0;; *)

let nbrFonctions = ref 0;;

%}

/* Declaration des unites lexicales et de leur type si une valeur particuliere leur est associee */

%token IMPORT
%token <string> IDENT TYPEIDENT
%token INT FLOAT BOOL CHAR VOID STRING
%token ACCOUV ACCFER PAROUV PARFER CROOUV CROFER
%token PTVIRG VIRG
%token SI SINON TANTQUE RETOUR
/* Defini le type des donnees associees a l'unite lexicale */
%token <int> ENTIER
%token <float> FLOTTANT
%token <bool> BOOLEEN
%token <char> CARACTERE
%token <string> CHAINE
%token VIDE
%token NOUVEAU
%token ASSIGN
%token OPINF OPSUP OPINFEG OPSUPEG OPEG OPNONEG
%token OPPLUS OPMOINS OPOU
%token OPMULT OPMOD OPDIV OPET
%token OPNON
%token OPPT
/* Unite lexicale particuliere qui represente la fin du fichier */
%token FIN

/* Declarations des regles d'associative et de priorite pour les operateurs */
/* La priorite est croissante de haut en bas */
/* Associatif a droite */
%right ASSIGN /* Priorite la plus faible */
/* Non associatif */
%nonassoc OPINF OPSUP OPINFEG OPSUPEG OPEG OPNONEG
/* Associatif a gauche */
%left OPPLUS OPMOINS OPOU
%left OPMULT OPMOD OPDIV OPET
%right OPNON
%left OPPT PAROUV CROOUV /* Priorite la plus forte */

/* Type renvoye pour le nom terminal fichier */
%type <unit> fichier
%type <int> variables

/* Le non terminal fichier est l'axiome */
%start fichier

%% /* Regles de productions */

fichier : programme FIN { (print_endline "fichier : programme FIN");(print_string "Nombre de fonctions : ");(print_int !nbrFonctions);(print_newline()) }

programme : /* Lambda, mot vide */ { (nbrFonctions := 0); (print_endline "programme : /* Lambda, mot vide */") }
          | fonction programme { (nbrFonctions := !nbrFonctions + 1);(print_endline "programme : fonction programme") }

typeStruct : typeBase declTab { (print_endline "typeStruct : typeBase declTab") }

typeBase : INT { (print_endline "typeBase : INT") }
         | FLOAT { (print_endline "typeBase : FLOAT") }
         | BOOL { (print_endline "typeBase : BOOL") }
         | CHAR { (print_endline "typeBase : CHAR") }
         | STRING { (print_endline "typeBase : STRING") }
         | TYPEIDENT { (print_endline "typeBase : TYPEIDENT") }

declTab : /* Lambda, mot vide */ { (print_endline "declTab : /* Lambda, mot vide */") }
        | CROOUV CROFER { (print_endline "declTab : CROOUV CROFER") }

fonction : entete bloc  { (print_endline "fonction : entete bloc") }

entete : typeStruct IDENT PAROUV parsFormels PARFER { (print_endline "entete : typeStruct IDENT PAROUV parsFormels PARFER") }
       | VOID IDENT PAROUV parsFormels PARFER { (print_endline "entete : VOID IDENT PAROUV parsFormels PARFER") }

parsFormels : /* Lambda, mot vide */ { (print_endline "parsFormels : /* Lambda, mot vide */") }
            | typeStruct IDENT suiteParsFormels { (print_endline "parsFormels : typeStruct IDENT suiteParsFormels") }

suiteParsFormels : /* Lambda, mot vide */ { (print_endline "suiteParsFormels : /* Lambda, mot vide */") }
                 | VIRG typeStruct IDENT suiteParsFormels { (print_endline "suiteParsFormels : VIRG typeStruct IDENT suiteParsFormels") }

bloc : ACCOUV /* $1 */ variables /* $2 */ instructions /* $3 */ ACCFER /* $4 */
     {
	(print_endline "bloc : ACCOUV variables instructions ACCFER");
	(print_string "Nombre de variables = ");
	(print_int $2);
	(print_newline ())
	}

variables : /* Lambda, mot vide */
	  {
		(print_endline "variables : /* Lambda, mot vide */");
		0
		}
          | variable /* $1 */ variables /* $2 */
	  {
		(print_endline "variables : variable variables");
		($2 + 1)
		}

variable : typeStruct IDENT PTVIRG { (print_endline "variable : typeStruct IDENT PTVIRG") }

/* A FAIRE : Completer pour decrire une liste d'instructions eventuellement vide */
instructions : /* Lambda, mot vide */ { (print_endline "instructions : /* Lambda, mot vide */") }
			 | instruction  { (print_endline "instructions : instruction ") }

/* A FAIRE : Completer pour ajouter les autres formes d'instructions */
instruction : expression PTVIRG { (print_endline "instruction : expression PTVIRG") }
            | SI PARFOUV expression PARFER corps elseCorps  { (print_endline "instruction : SI PARFER expression PAROUV corps elseCorps") }
			| TANTQUE PARFOUV expression PARFER corps { (print_endline "instruction : TANTQUE PARFER expression PAROUV corps") }
			| RETOUR expression PTVIRG { (print_endline "instruction : RETOUR expression PTVIRG") }


elseCorps : /* Lambda, mot vide */ { (print_endline "elseCorps : /* Lambda, mot vide */") }
		  | SINON corps { (print_endline "elseCorps : SINON corps") }

corps : /* Lambda, mot vide */ { (print_endline "corps : /* Lambda, mot vide */") }
	  | ACCOUV boucleVariable boucleInstruction ACCFER { (print_endline "corps : ACCOUV instructions ACCFER") }

boucleInstruction : /* Lambda, mot vide */ { (print_endline "boucleInstruction : /* Lambda, mot vide */") }
				  | instruction boucleInstruction { (print_endline "boucleInstruction : instruction boucleInstruction") }

boucleVariable : /* Lambda, mot vide */ { (print_endline "boucleVariable : /* Lambda, mot vide */") }
				  | variables boucleVariable { (print_endline "boucleVariable : variables boucleVariable") }

/* A FAIRE : Completer pour ajouter les autres formes d'expressions */
expression : /* Lambda, mot vide */ { (print_endline "expression : /* Lambda, mot vide */") }
            | boucleUnaire newExpression { (print_endline "expression : boucleUnaire newExpression") }
			|binaire { (print_endline "expression : binaire") }

binaire : ASSIGN { (print_endline "binaire : ASSIGN")}
         | OPPT { (print_endline "binaire : OPPT") }
		 | OPPLUS { (print_endline "binaire : OPPLUS") }
		 | OPMOINS { (print_endline "binaire : OPMOINS") }
		 | OPPMULT { (print_endline "binaire : OPPMULT") }
		 | OPPDIV { (print_endline "binaire : OPPDIV") }
		 | OPPMOD { (print_endline "binaire : OPPMOD") }
		 | OPOU { (print_endline "binaire : OPOU") }
		 | OPET { (print_endline "binaire : OPET") }
		 | OPEG { (print_endline "binaire : OPEG") }



unaire : PAROUV typeStruct PARFER { (print_endline "unaire : PAROUV typeStruct PARFER") }
        | OPPLUS { (print_endline "unaire : OPPLUS") }
		| OPMOINS {(print_endline "unaire : OPMOINS")}
        | OPPNON	{(print_endline "unaire : OPPNON")}



suffixe : PAROUV sousExpression PARFER { (print_endline "suffixe : PAROUV sousExrpression PARFER") }
         | CROOUV expression CROFER { (print_endline "suffixe : CROOUV expression CROFER") }

sousExpression :  /* Lambda, mot vide */ { (print_endline "parsFormels : /* Lambda, mot vide */") }
			   | suiteSousExpression { (print_endline "parsFormels :  suiteSousExpression") }

suiteSousExpression : /* Lambda, mot vide */ { (print_endline "suiteSousExpression : /* Lambda, mot vide */") }
					| VIRG expression suiteSousExpression { (print_endline "suiteSousExpression : VIRG expression suiteSousExpression") }

newExpression : /* Lambda, mot vide */ { (print_endline "newExpression : /* Lambda, mot vide */") }
			  | INT { (print_endline "newExpression : INT") }
			  |FLOAT { (print_endline "newExpression : FLOAT") }
			  |CHAR { (print_endline "newExpression : CHAR") }
			  |BOOL { (print_endline "newExpression : BOOL") }
			  |VIDE { (print_endline "newExpression : VIDE") }
			  |soussousExpression1 { (print_endline "newExpression : soussousExpression1") }
			  |soussousExpression2 { (print_endline "newExpression : soussousExpression2") }

soussousExpression1 : NOUVEAU IDENT exp1 { (print_endline "soussousExpression1 : NOUVEAU IDENT EXP1") }

exp1 : PARFOUV PARFER { (print_endline "exp1 : PARFOUV PARFER") }
     | CROOUV expression CROFER { (print_endline "exp1 : CROOUV expression CROFER") }

soussousExpression2 : exp2 boucleSuffixe { (print_endline "soussousExpression2 : exp2 boucleSuffixe") }

exp2 ; IDENT { (print_endline "exp2 : IDENT") }
	  | PARFOUV expression PARFER { (print_endline "exp2 : PARFOUV expression PARFER") }

boucleSuffixe : /* Lambda, mot vide */ { (print_endline "boucleSuffixe : /* Lambda, mot vide */") }
			  | suffixe boucleSuffixe { (print_endline "boucleSuffixe : suffixe boucleSuffixe") } 



%%

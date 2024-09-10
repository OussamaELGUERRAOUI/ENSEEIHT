with LCA;
-- Définition de structures de données associatives sous forme d'un tableau
-- de hachage (TH).
generic
	
   Capacity : Integer ; -- Capacite du tableau de hachage;
   type T_Cle is private;
   type T_Donnee is private;
   with function traiter_cle_hachage (Cle : in T_Cle) return Integer;
package TH is

	type T_TH is limited private;

	-- Initialiser un tableau de hachage. Le tableau de hachage est vide.
	procedure Tinitialiser(Sda_tab: out T_TH) with
		Post => Test_vide (Sda_tab);


	-- Est-ce qu'un tableau de hachage est vide ?
	function Test_Vide(Sda_tab : T_TH) return Boolean;


	-- Obtenir la taille d'un tableau de hachage. 
   function Ttaille (Sda_tab : in T_TH) return Integer with 
     Post => Ttaille'Result >= 0
            and (Ttaille'Result = 0) = Test_Vide (Sda_tab)
            and Ttaille'Result <= Capacity;

    function Ttaille_cellule (Sda_tab : in T_TH; Cle : in T_Cle) return Integer;

	-- Enregistrer une Donnée associée à une Clé dans un tableau de hachage.
	-- Si la clé est déjà présente dans le tableau de hachage, sa donnée est changée.
   procedure Tenregistrerr (Sda_tab : in out T_TH ; Cle : in T_Cle ; Donnee : in T_Donnee) with
     	Post => Tcle_Present (Sda_tab, Cle) and (Tla_Donnee (Sda_tab, Cle) = Donnee)
            and (not (Tcle_Present (Sda_tab, Cle)'Old) or Ttaille_Cellule (Sda_tab, Cle) = Ttaille_Cellule (Sda_tab, Cle)'Old)
            and (Tcle_present (Sda_tab, Cle)'Old or Ttaille_cellule (Sda_tab, Cle) = Ttaille_cellule (Sda_tab, Cle)'Old + 1);

	
   

	-- Supprimer la Donnée associée à une Clé dans un tableau de hachage.
	-- Exception : Cle_Absente_Exception si Clé n'est pas utilisée dans le tableau de hachage.
   procedure Tsupprimer (Sda_tab : in out T_TH ; Cle : in T_Cle) with
     Post =>  Ttaille_cellule (Sda_tab, Cle) = Ttaille_cellule (Sda_tab, Cle)'Old - 1
			and not tcle_present (Sda_tab, Cle);
		         


	-- Savoir si une Clé est présente dans un tableau de hachage.
   function Tcle_Present (Sda_tab : in T_TH; Cle : in T_Cle) return Boolean;


	-- Obtenir la donnée associée à une Cle dans le tableau de hachage.
	-- Exception : Cle_Absente_Exception si Clé n'est pas utilisée dans le tableau de hachage.
	function Tla_Donnee (Sda_tab : in T_TH ; Cle : in T_Cle) return T_Donnee;


	-- Supprimer tous les éléments du tableau de hachage.
	procedure Tvider (Sda_tab : in out T_TH) with
		Post => Test_vide (Sda_tab);


	-- Appliquer un traitement (Traiter) pour chaque couple d'un tableau de hachage.

	generic
		with procedure Traiter(Cle : in T_Cle; Donnee: in T_Donnee);
	procedure Tpour_chaque (Sda_tab : in out T_TH);


private
    package LCA_TH is new LCA(T_Cle => T_Cle, T_Donnee => T_Donnee);
   use LCA_TH;
   

   type T_TH is array(1..Capacity) of LCA_TH.T_LCA;

end TH;


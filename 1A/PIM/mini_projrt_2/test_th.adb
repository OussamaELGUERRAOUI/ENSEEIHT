with Ada.Text_IO;           use Ada.Text_IO;
with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;
with SDA_Exceptions; 		use SDA_Exceptions;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
	--! Les Unbounded_String ont une capacit� variable, contrairement au String
	--! pour lesquelles une capacit� doit �tre fix�e.

with TH;


procedure Test_TH is

    Capacity : Constant Integer := 11;

    function fonction_hachage (Cle: in Unbounded_String) return Integer is
    begin
        return (Length(Cle) mod Capacity) + 1;
    end fonction_hachage;

	package TH_String_Integer is
		new TH (T_Cle => Unbounded_String, T_Donnee => Integer, Capacity => Capacity ,traiter_cle_hachage => fonction_hachage);
	use TH_String_Integer;


	-- Retourner une cha�ne avec des guillemets autour de S
	function Avec_Guillemets (S: Unbounded_String) return String is
	begin
		return '"' & To_String (S) & '"';
   end Avec_Guillemets;

	-- Utiliser & entre String � gauche et Unbounded_String � droite.  Des
	-- guillemets sont ajout�es autour de la Unbounded_String
	-- Il s'agit d'un masquage de l'op�rateur `&` d�fini dans Strings.Unbounded
	function "&" (Left: String; Right: Unbounded_String) return String is
	begin
		return Left & Avec_Guillemets (Right);
	end;


	-- Surcharge l'op�rateur unaire "+" pour convertir une String
	-- en Unbounded_String.
	-- Cette astuce permet de simplifier l'initialisation
	-- de cles un peu plus loin.
	function "+" (Item : in String) return Unbounded_String
		renames To_Unbounded_String;


	-- Afficher une Unbounded_String et un entier.
	procedure Afficher (S : in Unbounded_String; N: in Integer) is
	begin
		Put (Avec_Guillemets (S));
		Put (" : ");
		Put (N, 1);
		New_Line;
	end Afficher;

	-- Afficher la TH.
	procedure Afficher is
		new Tpour_chaque (Afficher);


	Nb_Cles : constant Integer := 7;
	Cles : constant array (1..Nb_Cles) of Unbounded_String
			:= (+"un", +"deux", +"trois", +"quatre", +"cinq",
				+"quatre-vingt-dix-neuf", +"vingt-et-un");
	Inconnu : constant  Unbounded_String := To_Unbounded_String ("Inconnu");

	Donnees : constant array (1..Nb_Cles) of Integer
			:= (1, 2, 3, 4, 5, 99, 21);
	Somme_Donnees : constant Integer := 135;
	Somme_Donnees_Len4 : constant Integer := 7; -- somme si Length (Cle) = 4
	Somme_Donnees_Q: constant Integer := 103; -- somme si initiale de Cle = 'q'


	-- Initialiser l'annuaire avec les Donnees et Cles ci-dessus.
	-- Attention, c'est � l'appelant de lib�rer la m�moire associ�e en
	-- utilisant Vider.
	-- Si Bavard est vrai, les insertions sont trac�es (affich�es).
	procedure Construire_Exemple_Sujet (Annuaire : out T_TH; Bavard: Boolean := False) is
	begin
		TInitialiser (Annuaire);
		pragma Assert (TEst_Vide (Annuaire));
		pragma Assert (TTaille (Annuaire) = 0);

		for I in 1..Nb_Cles loop
			Tenregistrerr (Annuaire, Cles (I), Donnees (I));

			if Bavard then
				Put_Line ("Apr�s insertion de la cl� " & Cles (I));
				Afficher (Annuaire); New_Line;
			else
				null;
			end if;

			pragma Assert (not TEst_Vide (Annuaire));
			pragma Assert (TTaille (Annuaire) = I);

			for J in 1..I loop
				pragma Assert (TLa_Donnee (Annuaire, Cles (J)) = Donnees (J));
			end loop;

			for J in I+1..Nb_Cles loop
				pragma Assert (not Tcle_present (Annuaire, Cles (J)));
			end loop;

		end loop;
	end Construire_Exemple_Sujet;


	procedure Tester_Exemple_Sujet is
		Annuaire : T_TH;
	begin
		Construire_Exemple_Sujet (Annuaire, True);
		TVider (Annuaire);
	end Tester_Exemple_Sujet;


	-- Tester suppression en commen�ant par les derniers �l�ments ajout�s
	procedure Tester_Supprimer_Inverse is
		Annuaire : T_TH;
	begin
		Put_Line ("=== Tester_Supprimer_Inverse..."); New_Line;

		Construire_Exemple_Sujet (Annuaire);

		for I in reverse 1..Nb_Cles loop

			TSupprimer (Annuaire, Cles (I));

			Put_Line ("Apr�s suppression de " & Cles (I) & " :");
			Afficher (Annuaire); New_Line;

			for J in 1..I-1 loop
				pragma Assert (Tcle_present (Annuaire, Cles (J)));
				pragma Assert (Tla_donnee (Annuaire, Cles (J)) = Donnees (J));
			end loop;

			for J in I..Nb_Cles loop
				pragma Assert (not TCle_Present (Annuaire, Cles (J)));
			end loop;
		end loop;

		Tvider (Annuaire);
	end Tester_Supprimer_Inverse;


	-- Tester suppression en commen�ant les les premiers �l�ments ajout�s
	procedure Tester_Supprimer is
		Annuaire : T_TH;
	begin
		Put_Line ("=== Tester_Supprimer..."); New_Line;

		Construire_Exemple_Sujet (Annuaire);

		for I in 1..Nb_Cles loop
			Put_Line ("Suppression de " & Cles (I) & " :");

			Tsupprimer (Annuaire, Cles (I));

			Afficher (Annuaire); New_Line;

			for J in 1..I loop
				pragma Assert (not TCle_Present (Annuaire, Cles (J)));
			end loop;

			for J in I+1..Nb_Cles loop
				pragma Assert (Tcle_Present (Annuaire, Cles (J)));
				pragma Assert (TLa_Donnee (Annuaire, Cles (J)) = Donnees (J));
			end loop;
		end loop;

		Tvider (Annuaire);
	end Tester_Supprimer;


	procedure Tester_Supprimer_Un_Element is

		-- Tester supprimer sur un �l�ment, celui � Indice dans Cles.
		procedure Tester_Supprimer_Un_Element (Indice: in Integer) is
			Annuaire : T_TH;
		begin
			Construire_Exemple_Sujet (Annuaire);

			Put_Line ("Suppression de " & Cles (Indice) & " :");
			Tsupprimer (Annuaire, Cles (Indice));

			Afficher (Annuaire); New_Line;

			for J in 1..Nb_Cles loop
				if J = Indice then
					pragma Assert (not Tcle_Present (Annuaire, Cles (J)));
				else
					pragma Assert (Tcle_Present (Annuaire, Cles (J)));
				end if;
			end loop;

			Tvider (Annuaire);
		end Tester_Supprimer_Un_Element;

	begin
		Put_Line ("=== Tester_Supprimer_Un_Element..."); New_Line;

		for I in 1..Nb_Cles loop
			Tester_Supprimer_Un_Element (I);
		end loop;
	end Tester_Supprimer_Un_Element;


	procedure Tester_Remplacer_Un_Element is

		-- Tester enregistrer sur un �l�ment pr�sent, celui � Indice dans Cles.
		procedure Tester_Remplacer_Un_Element (Indice: in Integer; Nouveau: in Integer) is
			Annuaire : T_TH;
		begin
			Construire_Exemple_Sujet (Annuaire);

			Put_Line ("Remplacement de " & Cles (Indice)
					& " par " & Integer'Image(Nouveau) & " :");
			Tenregistrerr (Annuaire, Cles (Indice), Nouveau);

			Afficher (Annuaire); New_Line;

			for J in 1..Nb_Cles loop
				pragma Assert (Tcle_present (Annuaire, Cles (J)));
				if J = Indice then
					pragma Assert (Tla_donnee (Annuaire, Cles (J)) = Nouveau);
				else
					pragma Assert (Tla_donnee (Annuaire, Cles (J)) = Donnees (J));
				end if;
			end loop;

			Tvider (Annuaire);
		end Tester_Remplacer_Un_Element;

	begin
		Put_Line ("=== Tester_Remplacer_Un_Element..."); New_Line;

		for I in 1..Nb_Cles loop
			Tester_Remplacer_Un_Element (I, 0);
			null;
		end loop;
	end Tester_Remplacer_Un_Element;


	procedure Tester_Supprimer_Erreur is
		Annuaire : T_TH;
	begin
		begin
			Put_Line ("=== Tester_Supprimer_Erreur..."); New_Line;

			Construire_Exemple_Sujet (Annuaire);
			Tsupprimer (Annuaire, Inconnu);

		exception
			when Cle_Absente_Exception =>
				null;
			when others =>
				pragma Assert (False);
		end;
		Tvider (Annuaire);
	end Tester_Supprimer_Erreur;


	procedure Tester_La_Donnee_Erreur is
		Annuaire : T_TH;
		Inutile: Integer;

	begin
		begin
			Put_Line ("=== Tester_La_Donnee_Erreur..."); New_Line;

			Construire_Exemple_Sujet (Annuaire);
			Inutile := TLa_Donnee (Annuaire, Inconnu);

		exception
			when Cle_Absente_Exception =>
				null;
			when others =>
				pragma Assert (False);
		end;
		Tvider (Annuaire);
	end Tester_La_Donnee_Erreur;


	procedure Tester_Pour_chaque is
		Annuaire : T_TH;

		Somme: Integer;

		procedure Sommer (Cle: Unbounded_String; Donnee: Integer) is
		begin
			Put (" + ");
			Put (Donnee, 2);
			New_Line;

			Somme := Somme + Donnee;
		end;

		procedure Sommer is
        new TPour_Chaque (Sommer);
      begin
		Put_Line ("=== Tester_Pour_Chaque..."); New_Line;
		Construire_Exemple_Sujet(Annuaire);
		Somme := 0;
		Sommer (Annuaire);
		pragma Assert (Somme = Somme_Donnees);
		Tvider(Annuaire);
		New_Line;
	end Tester_Pour_chaque;


	procedure Tester_Pour_chaque_Somme_Si_Cle_Commence_Par_Q is
		Annuaire : T_TH;

		Somme: Integer;

		procedure Sommer_Cle_Commence_Par_Q (Cle: Unbounded_String; Donnee: Integer) is
		begin
			if To_String (Cle) (1) = 'q' then
				Put (" + ");
				Put (Donnee, 2);
				New_Line;

				Somme := Somme + Donnee;
			else
				null;
			end if;
		end;

		procedure Sommer is
			new Tpour_chaque (Sommer_Cle_Commence_Par_Q);

	begin
		Put_Line ("=== Tester_Pour_Chaque_Somme_Si_Cle_Commence_Par_Q..."); New_Line;
		Construire_Exemple_Sujet(Annuaire);
		Somme := 0;
		Sommer (Annuaire);
		pragma Assert (Somme = Somme_Donnees_Q);
		Tvider(Annuaire);
		New_Line;
	end Tester_Pour_chaque_Somme_Si_Cle_Commence_Par_Q;



	procedure Tester_Pour_chaque_Somme_Len4_Erreur is
		Annuaire : T_TH;

		Somme: Integer;

		procedure Sommer_Len4_Erreur (Cle: Unbounded_String; Donnee: Integer) is
			Nouvelle_Exception: Exception;
		begin
			if Length (Cle) = 4 then
				Put (" + ");
				Put (Donnee, 2);
				New_Line;

				Somme := Somme + Donnee;
			else
				raise Nouvelle_Exception;
			end if;
		end;

		procedure Sommer is
			new Tpour_chaque (Sommer_Len4_Erreur);

	begin
		Put_Line ("=== Tester_Pour_Chaque_Somme_Len4_Erreur..."); New_Line;
		Construire_Exemple_Sujet(Annuaire);
		Somme := 0;
		Sommer (Annuaire);
		pragma Assert (Somme = Somme_Donnees_Len4);
		TVider(Annuaire);
		New_Line;
	end Tester_Pour_chaque_Somme_Len4_Erreur;



begin
	Tester_Exemple_Sujet;
	Tester_Supprimer_Inverse;
	Tester_Supprimer;
	Tester_Supprimer_Un_Element;
	Tester_Remplacer_Un_Element;
	Tester_Supprimer_Erreur;
	Tester_La_Donnee_Erreur;
	Tester_Pour_chaque;
	Tester_Pour_chaque_Somme_Si_Cle_Commence_Par_Q;
	Tester_Pour_chaque_Somme_Len4_Erreur;
	Put_Line ("Fin des tests : OK.");
end Test_th;

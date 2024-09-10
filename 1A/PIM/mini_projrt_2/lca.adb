with Ada.Text_IO;            use Ada.Text_IO;
with SDA_Exceptions;         use SDA_Exceptions;
with Ada.Unchecked_Deallocation;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
package body LCA is

	procedure Free is
		new Ada.Unchecked_Deallocation (Object => T_Cellule, Name => T_LCA);


	procedure Initialiser(Sda: out T_LCA) is
	begin
		Sda := Null;
	end Initialiser;


	function Est_Vide (Sda : T_LCA) return Boolean is
   begin
      return Sda = Null;
   end;


	function Taille (Sda : in T_LCA) return Integer is
	s : Integer := 0 ;
   sda1: T_LCA ;
	begin
		sda1 := Sda ;
		while sda1 /= Null loop
			s := s + 1 ;
			sda1 := sda1.all.suivant ;
		end loop;
		return s ;
	end Taille;



	procedure Enregistrer (Sda : in out T_LCA ; Cle : in T_Cle ; Donnee : in T_Donnee) is
      Newc : T_LCA;
   begin
      if Sda = null then
         Newc := new T_Cellule;
         Newc.all.Cle := Cle;
         Newc.all.Donnee := Donnee;
         Newc.all.suivant := Null;
         Sda := Newc;
      else
         if Sda.all.Cle = Cle then
            Sda.all.Donnee := Donnee;
         else
            Enregistrer(Sda.all.suivant, Cle, Donnee);
         end if;
      end if;

   end Enregistrer;


	function Cle_Presente (Sda : in T_LCA ; Cle : in T_Cle) return Boolean is
        begin
	if Sda = Null then
		return False;
	else
		if Sda.all.Cle = Cle then
			return True;
		else
			return Cle_Presente(Sda.all.Suivant, Cle);
		end if;
	end if;
	end Cle_Presente;





	function La_Donnee (Sda : in T_LCA ; Cle : in T_Cle) return T_Donnee is
	sda1 : T_LCA;
	begin
	sda1 := Sda;
	   if not Est_Vide(sda1)  then
		   while sda1/= Null loop
		   	   if sda1.all.Cle = Cle then
			   	   return sda1.all.Donnee ;
		   	   end if;
		   	   sda1 := sda1.all.Suivant ;
	       	   end loop;
               	   raise Cle_Absente_Exception ;
          end if;

	end La_Donnee;


	procedure Supprimer (Sda : in out T_LCA ; Cle : in T_Cle) is
	Detr : T_LCA;
   begin
      if Sda = Null then
         Put_Line( "la_cle_etait_absent_de_la_sda");
      else
         if Sda.all.Cle = Cle then
            Detr := Sda;
            Sda := Sda.all.suivant;
            free(Detr);
         else
            Supprimer(Sda.all.suivant, Cle);
         end if;
      end if;

   end Supprimer;


	procedure Vider (Sda : in out T_LCA) is
	begin
         if Not est_Vide(Sda) then
            Vider(Sda.all.suivant);
            free(Sda);
         else
            Null;
         end if;



	end Vider;


	procedure Pour_Chaque (Sda : in T_LCA) is
   begin
      if Sda /= Null then
         Traiter(Sda.all.Cle, Sda.all.Donnee);
         Pour_Chaque(Sda.all.suivant);
      else
         Null;
      end if;
   exception
         When others => Null;

	end Pour_Chaque;


end LCA;

with Ada.Text_IO;            use Ada.Text_IO;
with SDA_Exceptions;         use SDA_Exceptions;
with Ada.Integer_Text_IO;       use Ada.Integer_Text_IO;
with Ada.Unchecked_Deallocation;

package body TH is


   procedure Tinitialiser(Sda_tab: out T_TH) is
   begin
      for i in 1..Capacity loop
        Initialiser(Sda => Sda_tab(i));
      end loop;

   end Tinitialiser;



   function Test_Vide (Sda_tab : T_TH) return Boolean is
      v : Boolean;
      i : Integer;

   begin
      V := True;
      i := 1;

      while v and i <= Capacity loop
         if not Est_Vide(Sda => Sda_tab(i)) then
            v :=False;
         end if;
         i := i + 1;

      end loop;
      return v;


   end Test_Vide;




   function Ttaille (Sda_tab : in T_TH) return Integer is
	begin
		return Sda_tab'Last ;
   end  Ttaille;

    function Ttaille_cellule(Sda_Tab: in T_TH; Cle: in T_Cle ) return Integer is
        i: Integer;
    begin
        i:= traiter_cle_hachage(Cle);
        return Taille(Sda => Sda_tab(i));
    end Ttaille_cellule;



   procedure Tenregistrerr (Sda_tab : in out T_TH ; Cle : in T_Cle ; Donnee : in T_Donnee) is
      i : Integer ; -- Valeur de hachage de la Cle
    begin
         i := traiter_cle_hachage(Cle);
         Enregistrer (Sda => Sda_tab(i), Cle => Cle, Donnee => Donnee);
   end Tenregistrerr;



   function Tcle_present (Sda_tab : in T_TH ; Cle : in T_Cle) return Boolean is
    p : Boolean;
    i : Integer ;
   begin
      p := False;
      i := 1;
      while not p and i <= Capacity loop
         if Cle_Presente(Sda_tab(i), Cle) then
            p := True;
         end if ;
         i := i +1;
      end loop;
      return p;

    end Tcle_present;


	function Tla_donnee (Sda_tab : in T_TH ; Cle : in T_Cle) return T_Donnee is
         i : Integer ;
    begin
            i := traiter_cle_hachage(Cle);
            return La_Donnee(Sda_tab(i), Cle);
    end Tla_donnee;



	procedure Tsupprimer (Sda_tab : in out T_TH ; Cle : in T_Cle) is
          i : Integer ;
    begin
            i := traiter_cle_hachage(Cle) ;
            Supprimer(Sda_tab(i), Cle);

    end Tsupprimer;



   procedure Tvider (Sda_tab : in out T_TH) is
	begin
            for i in Sda_tab'range loop
               Vider(Sda_tab(i));
            end loop;
    end Tvider;




   procedure Tpour_chaque (Sda_tab: in out T_TH) is

       procedure LCA_Pour_Chaque is new LCA_TH.Pour_Chaque(Traiter);
    begin
        for indice in Sda_tab'Range loop
            Put ("la Case ");
            Put (indice, 1);
            Put (" :");
            New_Line;
            LCA_Pour_Chaque(Sda_tab(indice));
            New_Line;
            New_Line;
        end loop;

   end Tpour_chaque;



end TH;

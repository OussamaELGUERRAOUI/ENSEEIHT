with LCA;
with Ada.Text_IO;               use Ada.Text_IO;
with Ada.Integer_Text_IO;       use Ada.Integer_Text_IO;
with Ada.Strings;               use Ada.Strings;
with Ada.Strings.Unbounded;     use Ada.Strings.Unbounded;
with Ada.Text_IO.Unbounded_IO;  use  Ada.Text_IO.Unbounded_IO;

procedure lca_sujet is

   package LCA_character_integer is
     new LCA(T_Cle => Unbounded_String, T_Donnee => Integer);
   use LCA_character_integer;

    procedure Affichage (Cle : in Unbounded_String; Donnee: in Integer)is
    begin
       Put("le clé : " & Cle);
       Put(" /\ sa donnee associee : ");
       Put(Donnee, 1);
       New_Line;
    end Affichage;
    procedure Afficher is new Pour_Chaque(Traiter => Affichage);

    Sda : T_LCA;
begin
    Initialiser(Sda);
    Enregistrer(Sda, To_Unbounded_String("un"), 1);
    Enregistrer(Sda, To_Unbounded_String("deux"), 2);
    Enregistrer(Sda,  To_Unbounded_String("trois"), 3);
    Enregistrer(Sda, To_Unbounded_String("quatre"), 4);
    Afficher(Sda);

end lca_sujet;

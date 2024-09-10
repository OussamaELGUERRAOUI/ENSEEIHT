with TH;
with Ada.Text_IO;               use Ada.Text_IO;
with Ada.Integer_Text_IO;       use Ada.Integer_Text_IO;
with Ada.Strings;               use Ada.Strings;
with Ada.Strings.Unbounded;     use Ada.Strings.Unbounded;
with Ada.Text_IO.Unbounded_IO;  use  Ada.Text_IO.Unbounded_IO;

procedure th_sujet is



    function fonction_hachage (Cle: in Unbounded_String) return Integer is
    begin
        return (Length(Cle) mod 11) + 1;
    end fonction_hachage;



   package TH_str_integer is
     new TH(T_Cle=> Unbounded_String, T_Donnee => Integer, Capacity=> 11, traiter_cle_hachage => fonction_hachage);
    use TH_str_integer;

    procedure Affichage (Cle : in Unbounded_String; Donnee: in Integer)is
    begin
       Put("Le clé  : " & Cle);
       Put(" /\ sa donnee associee : ");
       Put(Donnee, 1);
       New_Line;
    end Affichage;
    procedure Afficher is new Tpour_chaque(Traiter => Affichage);

    Sda_Tab : T_TH;

begin
    Tinitialiser(Sda_Tab);
    Tenregistrerr(Sda_Tab, To_Unbounded_String("un"), 1);
    Tenregistrerr(Sda_Tab, To_Unbounded_String("deux"), 2);
    Tenregistrerr(Sda_Tab, To_Unbounded_String("trois"), 3);
    Tenregistrerr(Sda_Tab, To_Unbounded_String("quatre"), 4);
    Tenregistrerr(Sda_Tab, To_Unbounded_String("cinq"), 5);
    Tenregistrerr(Sda_Tab, To_Unbounded_String("quatre-vingt-dix-neuf"), 99);
    Tenregistrerr(Sda_Tab, To_Unbounded_String("vingt-et-un"), 21);
    Afficher(Sda_Tab);

end th_sujet;


%%%%% SET ENV %%%%%

addpath('matlab_bgl');      %load graph libraries
addpath('matlab_tpgraphe'); %load tp ressources

load TPgraphe.mat;          %load data

%%%%%% DISPLAY INPUT DATA ON TERMINAL %%%%%

cities %names of cities
D      %distance matrix bw cities
pos    %x-y pos of the cities

%%%%%%EXO 1 (modeliser et afficher le graphe) %%

A=zeros(size(D)) ; %adj matrix
for i = 1:size(D,1)
    for j = 1:size(D,2)
        if (D(i,j) <= 1000) & ~(i==j) 
            A(i,j) = 1;
        end
    end
end
viz_adj(D,A,pos,cities);

A1 = graphPower(A,10);
viz_adj(D, A1 ,pos,cities);

%%%%%% EXO 2 %%%%%

%Q1 - existence d'un chemin de longueur 3

A_carre = bmul(A,A);
A_cube = bmul(A_carre,A);

viz_adj(D, A_cube ,pos,cities);

%Q2 - nb de chemins de 3 sauts
 nb_chemin = sum(A_cube,"all")/2


%Q3 - nb de chemins <=3

A1 = A - A_carre - A_cube
A2 = A_carre - A_cube
A3 = A_cube

nb_chemin3 = (sum(A,"all") + sum(A_carre,"all") + sum(A_cube,"all"))/2


%%%%%%%% EXO 3 %%%%%


c=[18 13 9]; %la chaine 18 13 9 est t dans le graphe?
app1 =possedechaine(A,c)
c=[18 6 3]; %la chaine 18 6 3 est t dans le graphe?
app2=possedechaine(A,c)
c=[26 5 17]; %la chaine 26 5 17 est t dans le graphe?
app3 = possedechaine(A,c)

%%%%%%%% EXO 4%%%%%
isEulerien(A)

%%%%%%%% EXO 5%%%%%
d = [1,4,10,15,20,30,60,80,100,150,200, 250,300,400,500]
eur = []

for n = d
    if Eulerien(D,n)
        eur(length(eur)+1) = n 
    end 
end


porteeEulerien(D)

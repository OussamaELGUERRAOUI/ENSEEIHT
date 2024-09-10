%--------------------------------------------------------------------------
% ENSEEIHT - 1SN - Analyse de donnees
% TP4 - Reconnaissance de chiffres manuscrits par k plus proches voisins
% fonction kppv.m
%--------------------------------------------------------------------------
function [Partition] = kppv(DataA,DataT,labelA,K,ListeClass,labelT)

[Na,~] = size(DataA);
[Nt,~] = size(DataT);

Nt_test = Nt/1000; % A changer, pouvant aller de 1 jusqu'à Nt

% Initialisation du vecteur d'étiquetage des images tests
Partition = zeros(Nt_test,1);

disp(['Classification des images test dans ' num2str(length(ListeClass)) ' classes'])
disp(['par la methode des ' num2str(K) ' plus proches voisins:'])

% Boucle sur les vecteurs test de l'ensemble de l'évaluation
for i = 1:Nt_test
    
    disp(['image test n°' num2str(i)])

    % Calcul des distances entre les vecteurs de test 
    % et les vecteurs d'apprentissage (voisins)
    % A COMPLÉTER
       distance = sqrt(sum((ones(Na,1)*DataT(i,:)-DataA).^2 ,2));
       %sum((ones(Nt,1)*DataT(i,:)-DataA).^2 ,2) ; 
    % On ne garde que les indices des K + proches voisins
    % A COMPLÉTER
       [vec,indi]=sort(distance.');
       indi=indi(1:K);
       %labelA = labelA(:,indi);
       vecteur=labelA(indi);
    
    % Comptage du nombre de voisins appartenant à chaque classe
    % A COMPLÉTER
    for i = 1 :K
        T=zeros(1,10);
        l=find(vecteur(i)==ListeClass);
        T(l)=T(l)+1;
    end
    % Recherche de la classe contenant le maximum de voisins
    % A COMPLÉTER
    M = max(T);
    I=find(M==T);
    if (length(I)==1)
        classe_plus_voisins = ListeClass(I);
    else 
        for j =1:length(I)
            classe_plus_voisins =zeros(1,length(I));
            classe_plus_voisins (j)=ListeClass(I(j))
        end
    end
    
    % Si l'image test a le plus grand nombre de voisins dans plusieurs  
    % classes différentes, alors on lui assigne celle du voisin le + proche,
    % sinon on lui assigne l'unique classe contenant le plus de voisins 
    % A COMPLÉTER
    M = max(T);
    I=find(M==T);
    if (length(I)==1)
        classe_plus_voisins=ListeClass(I);
    else
        if (length(I)==1)
            I=vecteur(1);
            classe_plus_voisins=ListClass(I);
        end
    end
    
    
    % Assignation de l'étiquette correspondant à la classe trouvée au point 
    % correspondant à la i-ème image test dans le vecteur "Partition" 
    % A COMPLÉTER
    Partition(i)=classe_plus_voisins;
    
end


confusion = zeros(length(ListeClass));

for i = 1:Nt_test

confusion( labelT(i) +1, Partition(i)+1) = confusion( labelT(i) +1, Partition(i)+1) + 1;

end

taux = (Nt_test - sum(diag(confusion))) / Nt_test


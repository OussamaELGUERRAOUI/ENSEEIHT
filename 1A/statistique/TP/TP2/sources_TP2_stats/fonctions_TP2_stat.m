
% TP2 de Statistiques : fonctions a completer et rendre sur Moodle
% Nom :
% Prénom : 
% Groupe : 1SN-

function varargout = fonctions_TP2_stat(nom_fonction,varargin)

    switch nom_fonction
        case 'tirages_aleatoires_uniformes'
            [varargout{1},varargout{2}] = tirages_aleatoires_uniformes(varargin{:});
        case 'estimation_Dyx_MV'
            [varargout{1},varargout{2}] = estimation_Dyx_MV(varargin{:});
        case 'estimation_Dyx_MC'
            [varargout{1},varargout{2}] = estimation_Dyx_MC(varargin{:});
        case 'estimation_Dyx_MV_2droites'
            [varargout{1},varargout{2},varargout{3},varargout{4}] = estimation_Dyx_MV_2droites(varargin{:});
        case 'probabilites_classe'
            [varargout{1},varargout{2}] = probabilites_classe(varargin{:});
        case 'classification_points'
            [varargout{1},varargout{2},varargout{3},varargout{4}] = classification_points(varargin{:});
        case 'estimation_Dyx_MCP'
            [varargout{1},varargout{2}] = estimation_Dyx_MCP(varargin{:});
        case 'iteration_estimation_Dyx_EM'
            [varargout{1},varargout{2},varargout{3},varargout{4},varargout{5},varargout{6},varargout{7},varargout{8}] = ...
            iteration_estimation_Dyx_EM(varargin{:});
    end

end

% Fonction centrage_des_donnees (exercice_1.m) ----------------------------
function [x_G, y_G, x_donnees_bruitees_centrees, y_donnees_bruitees_centrees] = ...
                centrage_des_donnees(x_donnees_bruitees,y_donnees_bruitees)
x_G = mean(x_donnees_bruitees)
y_G = mean(y_donnees_bruitees)
x_donnees_bruitees_centrees = x_donnees_bruitees - x_G
y_donnees_bruitees_centrees = y_donnees_bruitees - y_G


end

% Fonction tirages_aleatoires_uniformes (exercice_1.m) ------------------------
function [tirages_angles,tirages_G] = tirages_aleatoires_uniformes(n_tirages,taille)

    tirages_angles = pi*(rand(n_tirages,1) - 0.5) 

    % Tirages aleatoires de points pour se trouver sur la droite (sur [-20,20])
    tirages_G = 2*taille*(rand(n_tirages,2) - 0.5); % A MODIFIER DANS L'EXERCICE 2

end

% Fonction estimation_Dyx_MV (exercice_1.m) -------------------------------
function [a_Dyx,b_Dyx] = ...
           estimation_Dyx_MV(x_donnees_bruitees,y_donnees_bruitees,tirages_psi)
[x_G, y_G, x_donnees_bruitees_centrees, y_donnees_bruitees_centrees] = centrage_des_donnees(x_donnees_bruitees,y_donnees_bruitees)


resi_mat_y = repmat(y_donnees_bruitees_centrees,length(tirages_psi),1)
tan_psi = tan(tirages_psi)
a_res = (resi_mat_y - tan_psi*x_donnees_bruitees_centrees).^2
somme_a = sum(a_res,2)
[~, indice] = min(somme_a)
psi = tirages_psi(indice)

a_Dyx = tan(psi)
b_Dyx = y_G - a_Dyx*x_G


end

% Fonction estimation_Dyx_MC (exercice_1.m) -------------------------------
function [a_Dyx,b_Dyx] = ...
                   estimation_Dyx_MC(x_donnees_bruitees,y_donnees_bruitees)

I = ones(1, length(x_donnees_bruitees));
A_sym = [x_donnees_bruitees; I];
B = y_donnees_bruitees';
A = A_sym' ;
A_inverse = inv(A_sym*A);
Aplus = A_inverse*A_sym;
X = Aplus*B;
a_Dyx = X(1,1);
a_Dyx = X(2,1);


end

% Fonction estimation_Dyx_MV_2droites (exercice_2.m) -----------------------------------
function [a_Dyx_1,b_Dyx_1,a_Dyx_2,b_Dyx_2] = ... 
         estimation_Dyx_MV_2droites(x_donnees_bruitees,y_donnees_bruitees,sigma, ...
                                    tirages_G_1,tirages_psi_1,tirages_G_2,tirages_psi_2)    

Y = repmat(y_donnees_bruitees,size(tirages_psi_1));
X = repmat(x_donnees_bruitees,size(tirages_psi_1));


r1 = (Y - tirages_G_1(:,2)) - tan(tirages_psi_1).*(X -  tirages_G_1(:,1));
r2 = (Y - tirages_G_2(:,2)) - tan(tirages_psi_2).*(X -  tirages_G_2(:,1));

L = log(exp(-(r1).^2)/(2*sigma^2) + exp(-(r2).^2)/(2*sigma^2));

somme = sum(L,2);

[~,indice] = max(somme);

a_Dyx_1 = tan(tirages_psi_1(indice));
b_Dyx_1 = tirages_G_1(indice,2) - a_Dyx_1*tirages_G_1(indice,1);

a_Dyx_2 = tan(tirages_psi_2(indice));
b_Dyx_2 = tirages_G_2(indice,2) - a_Dyx_2*tirages_G_2(indice,1);

end

% Fonction probabilites_classe (exercice_3.m) ------------------------------------------
function [probas_classe_1,probas_classe_2] = probabilites_classe(x_donnees_bruitees,y_donnees_bruitees,sigma,...
                                                                 a_1,b_1,proportion_1,a_2,b_2,proportion_2)
r1 = y_donnees_bruitees - a_1*x_donnees_bruitees - b_1;
r2 = y_donnees_bruitees - a_2*x_donnees_bruitees - b_2;

K1 = proportion_1*exp(-r1.^2/2*sigma^2);
K2 = proportion_2*exp(-r2.^2/2*sigma^2);
for i=1:length(K1)
    probas_classe_1(i) = K1(i)/(K1(i) + K2(i)) ;
    probas_classe_2(i) = K2(i)/(K1(i) + K2(i)) ;
end

end




% Fonction classification_points (exercice_3.m) ----------------------------
function [x_classe_1,y_classe_1,x_classe_2,y_classe_2] = classification_points ...
              (x_donnees_bruitees,y_donnees_bruitees,probas_classe_1,probas_classe_2)
for i=1:length(probas_classe_2)
    if probas_classe_2(i) > probas_classe_1(i)
        x_classe2(i) = x_donnees_bruitees(i);
        y_classe2(i) = y_donnees_bruitees(i);
    else
        x_classe1(i) = x_donnees_bruitees(i);
        y_classe1(i) = y_donnees_bruitees(i);
    end
end
x_classe_1 = x_classe1(x_classe1 ~= 0);
x_classe_2 = x_classe2(x_classe2 ~= 0);
y_classe_2 = y_classe2(y_classe2 ~= 0);
y_classe_1 = y_classe1(x_classe1 ~= 0);
      


end

% Fonction estimation_Dyx_MCP (exercice_4.m) -------------------------------
function [a_Dyx,b_Dyx] = estimation_Dyx_MCP(x_donnees_bruitees,y_donnees_bruitees,probas_classe)


    
end

% Fonction iteration_estimation_Dyx_EM (exercice_4.m) ---------------------
function [probas_classe_1,proportion_1,a_1,b_1,probas_classe_2,proportion_2,a_2,b_2] =...
         iteration_estimation_Dyx_EM(x_donnees_bruitees,y_donnees_bruitees,sigma,...
         proportion_1,a_1,b_1,proportion_2,a_2,b_2)



end

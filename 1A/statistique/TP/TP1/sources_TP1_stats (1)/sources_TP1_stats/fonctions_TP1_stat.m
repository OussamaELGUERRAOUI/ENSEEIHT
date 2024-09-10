
% TP1 de Statistiques : fonctions a completer et rendre sur Moodle
% Nom : ELGUERRAOUI
% Prénom : Oussama
% Groupe : 1SN-F

function varargout = fonctions_TP1_stat(nom_fonction,varargin)

    switch nom_fonction
        case 'tirages_aleatoires_uniformes'
            varargout{1} = tirages_aleatoires_uniformes(varargin{:});
        case 'estimation_Dyx_MV'
            [varargout{1},varargout{2}] = estimation_Dyx_MV(varargin{:});
        case 'estimation_Dyx_MC'
            [varargout{1},varargout{2}] = estimation_Dyx_MC(varargin{:});
        case 'estimation_Dorth_MV'
            [varargout{1},varargout{2}] = estimation_Dorth_MV(varargin{:});
        case 'estimation_Dorth_MC'
            [varargout{1},varargout{2}] = estimation_Dorth_MC(varargin{:});
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

% Fonction tirages_aleatoires (exercice_1.m) ------------------------------
function tirages_angles = tirages_aleatoires_uniformes(n_tirages)

tirages_angles = pi*(rand(n_tirages,1) - 0.5) 
    
  

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

a_Dyx = tan(psi);
b_Dyx = y_G - a_Dyx*x_G;




    
end

% Fonction estimation_Dyx_MC (exercice_2.m) -------------------------------
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

% Fonction estimation_Dorth_MV (exercice_3.m) -----------------------------
function [theta_Dorth,rho_Dorth] = ...
         estimation_Dorth_MV(x_donnees_bruitees,y_donnees_bruitees,tirages_theta)

x_donnees_bruitees_centrees = x_donnees_bruitees - mean(x_donnees_bruitees);
y_donnees_bruitees_centrees = y_donnees_bruitees - mean(y_donnees_bruitees);
VS = (x_donnees_bruitees_centrees*cos(tirages_theta) + y_donnees_bruitees_centrees*sin(tirages_theta)).^2;
% je n'ai pas compris pourquoi il y a un erreur sur le dimension, je pense il y a un probléme sur y_donnees_bruitees_ et x_donnees_bruitees_ 
sum_vs = sum(VS,2);

[~,indmin] = min(sum_vs);
theta_Dorth = tirages_theta(indmin);
rho_Dorth = mean(x_donnees_bruitees_centrees)*cos(tirages_theta(indmin)) + mean(y_donnees_bruitees_centrees)*sin(tirages_theta(indmin));




end

% Fonction estimation_Dorth_MC (exercice_4.m) -----------------------------
function [theta_Dorth,rho_Dorth] = ...
                 estimation_Dorth_MC(x_donnees_bruitees,y_donnees_bruitees)

x_centrees = x_donnees_bruitees - mean(x_donnees_bruitees);
y_centrees = y_donnees_bruitees - mean(y_donnees_bruitees);
C = [ x_centrees ; y_centrees]';
sym_C = C' * C;
[V, D] = eig(sym);
valeur_propre = diag(D);
[~,indice] = min(valeur_propre);
vect_propre = V(:,indice);
cos_theta = vect_propre(1);
sin_theta = vect_propre(2);
theta_Dorth = atan(sin_theta/cos_theta)
rho_Dorth = mean(x_donnees_bruitees)*cos_theta + mean(y_donnees_bruitees)*sin_theta;



end

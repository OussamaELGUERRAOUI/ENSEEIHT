
% TP3 de Statistiques : fonctions a completer et rendre sur Moodle
% Nom : Elguerraoui
% Prenom : Oussama
% Groupe : 1SN-F

function varargout = fonctions_TP3_stat(nom_fonction,varargin)

    switch nom_fonction
        case 'estimation_F'
            [varargout{1},varargout{2},varargout{3}] = estimation_F(varargin{:});
        case 'choix_indices_points'
            [varargout{1}] = choix_indices_points(varargin{:});
        case 'RANSAC_2'
            [varargout{1},varargout{2}] = RANSAC_2(varargin{:});
        case 'G_et_R_moyen'
            [varargout{1},varargout{2},varargout{3}] = G_et_R_moyen(varargin{:});
        case 'estimation_C_et_R'
            [varargout{1},varargout{2},varargout{3}] = estimation_C_et_R(varargin{:});
        case 'RANSAC_3'
            [varargout{1},varargout{2}] = RANSAC_3(varargin{:});
    end

end

% Fonction estimation_F (exercice_1.m) ------------------------------------
function [rho_F,theta_F,ecart_moyen] = estimation_F(rho,theta)

A = [cos(theta) sin(theta)]
X = pinv(A)*rho;
x_f = X(1);
y_f = X(2);
rho_F = sqrt(x_f^2 + y_f^2);
theta_F = tan(y_f/x_f);
ecart_moyen = (1/length(rho))*sum(abs(rho - rho_F*cos(theta - theta_F)));





end

% Fonction choix_indice_elements (exercice_2.m) ---------------------------
function tableau_indices_points_choisis = choix_indices_points(k_max,n,n_indices)
tableau_indices_points_choisis = ones(k_max,n_indices);
tirage = randperm(n,n_indices);
for i=1:k_max 
    tableau_indices_points_choisis(i, : ) = randperm(n,n_indices);
end



end

% Fonction RANSAC_2 (exercice_2.m) ----------------------------------------
function [rho_F_estime,theta_F_estime] = RANSAC_2(rho,theta,parametres,tableau_indices_2droites_choisies)
nind = 2;
emin = Inf;
S1 = parametres(1);
S2 = parametres(2);
kmax = parametres(3);
tableau_indices_2points_choisies = choix_indices_points(kmax,length(theta),nind);
for i = 1:kmax
    j = tableau_indices_2droites_choisies(i,:);
    [rhof,thetaf,emoyen] = estimation_F(rho(j),theta(j));
    ecart=abs(rho-rhof*cos(theta-thetaf));
    conforme =(ecart < S1);
    sumconforme = sum(conforme);
    if sumconforme/length(theta) > S2
        [rhof1,thetaf1,emoyen] = estimation_F(rho(conforme),theta(conforme));
        if emoyen < emin
            theta_F_estime = thetaf1;
            rho_F_estime = rhof1;
            emin = emoyen ;
        end
    end
end

        







end

% Fonction G_et_R_moyen (exercice_3.m, bonus, fonction du TP1) ------------
function [G, R_moyen, distances] = ...
         G_et_R_moyen(x_donnees_bruitees,y_donnees_bruitees)



end

% Fonction estimation_C_et_R (exercice_3.m, bonus, fonction du TP1) -------
function [C_estime,R_estime,critere] = ...
         estimation_C_et_R(x_donnees_bruitees,y_donnees_bruitees,n_tests,C_tests,R_tests)
     


end

% Fonction RANSAC_3 (exercice_3, bonus) -----------------------------------
function [C_estime,R_estime] = ...
         RANSAC_3(x_donnees_bruitees,y_donnees_bruitees,parametres,tableau_indices_3points_choisis)
     


end

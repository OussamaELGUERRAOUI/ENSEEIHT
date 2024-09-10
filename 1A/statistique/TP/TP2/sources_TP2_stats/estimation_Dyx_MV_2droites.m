function [a_Dyx_1,b_Dyx_1,a_Dyx_2,b_Dyx_2] = ... 
         estimation_Dyx_MV_2droites(x_donnees_bruitees,y_donnees_bruitees,sigma, ...
                                    tirages_G_1,tirages_psi_1,tirages_G_2,tirages_psi_2)
r_1=(repmat(y_donnees_bruitees,size(tirages_psi_1))-tirages_G_1(:,2))-tan(tirages_psi_1).*(repmat(x_donnees_bruitees,size(tirages_psi_1))-tirages_G_1(:,1));
r_2=(repmat(y_donnees_bruitees,size(tirages_psi_1))-tirages_G_2(:,2))-tan(tirages_psi_2).*(repmat(x_donnees_bruitees,size(tirages_psi_1))-tirages_G_2(:,1));
S=sum(log(exp(-(r_1).^2/(2*sigma.^2))+exp(-(r_2).^2/(2*sigma.^2))),2);
[M,I]=max(S);
a_Dyx_1=tan(tirages_psi_1(I));
b_Dyx_1=tirages_G_1(I,2)-a_Dyx_1*tirages_G_1(I,1);
a_Dyx_2=tan(tirages_psi_2(I));
b_Dyx_2=tirages_G_2(I,2)-a_Dyx_2*tirages_G_2(I,1);
end

function [a_Dyx_1,b_Dyx_1,a_Dyx_2,b_Dyx_2] = ... 
         estimation_Dyx_MV_2droites(x_donnees_bruitees,y_donnees_bruitees,sigma, ...
                                    tirages_G_1,tirages_psi_1,tirages_G_2,tirages_psi_2)    

Y = repmat(y_donnees_bruitees,length(y_donnees_bruitees),1);
X = repmat(x_donnees_bruitees,length(x_donnees_bruitees),1);

YG1 = repmat(tirages_G_1(:,2),length(tirages_G_1(:,2)),1);
XG1 = repmat(tirages_G_1(:,1),length(tirages_G_1(:,1)),1);


YG2 = repmat(tirages_G_2(:,2),length(tirages_G_2(:,2)));
XG2 = repmat(tirages_G_2(:,1),length(tirages_G_2(:,1)));

phi1 = repmat(tirages_psi_1,length(tirages_psi_1));
phi2 = repmat(tirages_psi_2,length(tirages_psi_2));

r1 = Y - YG1 - tan(phi1).*(X - X1);
r2 = Y - YG2 - tan(phi2).*(X - X2);

L = log(exp(-(r1).^2)/(2*sigma) + exp(-(r2).^2)/(2*sigma));

somme = sum(L,2);

[~,indice] = max(somme);

a_Dyx_1 = tan(tirages_psi_1(indice));
b_Dyx_1 = tirages_G_1(indice,2);

a_Dyx_2 = tan(tirages_psi_2(indice));
b_Dyx_2 = tirages_G_2(indice,2);

end
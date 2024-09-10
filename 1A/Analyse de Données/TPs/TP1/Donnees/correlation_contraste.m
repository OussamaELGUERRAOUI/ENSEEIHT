function [correlation,contraste] =...
    correlation_contraste(X)


n = length(X);
X_barre = (1/n)*(X')*(ones(n,1));
X_C = X - ones(n,1)*(X_barre') ;
sigma = (1/n)*(X_C')*X_C;

%variance de chaque couleur
var_R = sqrt(sigma(1,1));
var_V =sqrt(sigma(2,2));
var_B =sqrt(sigma(3,3));

%convariance de deux couleurs
conv_RV = sigma(2,1);
conv_RB = sigma(3,1);
conv_BV = sigma(2,3);

correlation(1) = conv_RV/(var_R*var_V);
correlation(2) = conv_RB/(var_R*var_B);
correlation(3) = conv_BV/(var_B*var_V);

contraste(1) = var_R^2/(var_R^2 + var_V^2 + var_V^2);
contraste(2) = var_V^2/(var_R^2 + var_V^2 + var_V^2);
contraste(3) = var_B^2/(var_R^2 + var_V^2 + var_V^2);

end



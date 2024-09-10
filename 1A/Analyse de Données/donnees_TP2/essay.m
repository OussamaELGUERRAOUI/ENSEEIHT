% Matrice A et vecteur b du système linéaire
A = [1 2 3; 4 5 6; 7 8 7];
b = [6; 15; 21];

% Décomposition SVD de A
[U, S, V] = svds(A,d);

% Calcul de c
c = U' * b;

% Résolution du système linéaire
d = zeros(size(b));
for i = 1:size(b)
    d(i) = c(i) / S(i, i);
end

% Calcul de la solution x
x = V * d;

% Affichage de la solution
disp('La solution du système linéaire Ax = b est :')
disp(x);

function [X_VS,w,c,code_retour] = SVMMargeSouple_2(X,Y,landa)

    % Variables
    eps = 1e-6;
    n = length(X);
    f = -ones(n,1);
    lb = zeros(n,1);
    ub = landa*ones(n,1);

    %contrainte d'inégalité
    

    % Resolution du probleme d'optimisation
    H = (Y.*X)*(Y.*X)';
    Aeq = Y';
    [alpha,~,code_retour] = quadprog(H,f,[],[],Aeq,0,lb,ub);

    % Calcul de w et c
    %alpha = alpha(alpha < landa);
    w = X'*(alpha.*Y);
    X_VS = X(alpha<landa, :);
    Y_VS = Y(alpha< landa,:);
    c = mean(X_VS*w - Y_VS);
end
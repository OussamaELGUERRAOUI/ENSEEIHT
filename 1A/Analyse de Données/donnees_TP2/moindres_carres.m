function beta = ...
    moindres_carres(d,X,Y,beta_0)

B = @(x,k) nchoosek(d,k)*x.^k.*(1-x).^(d-k);
%E = size(X);
p = length(X);
Aj = zeros(p,d);

for i=1:d
    Aj(:,i) = B(X',i);
end

Bj = Y - beta_0*(B(X,0));


[U,S,V] = svds(Aj,d);

%W = (U)'*Bj;


S_inv= zeros(d);
for i=1:d
    S_inv(i,i) = 1/S(i,i) ;
end


Z = V*S_inv 
beta = Z*(U)'*Bj;
end











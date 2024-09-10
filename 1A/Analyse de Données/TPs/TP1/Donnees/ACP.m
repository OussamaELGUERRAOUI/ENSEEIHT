function C =...
     ACP(X)

n = length(X);
X_barre = (1/n)*(X')*(ones(n,1));
X_C = X - ones(n,1)*(X_barre') ;
sigma = (1/n)*(X_C')*X_C;

[W,D] = eig(sigma);

[VP , I] = sort(diag(D),'descend');
VP_trie = diag(VP); 

M_passage = W(:,I);

C = X_C*VP_trie;
end

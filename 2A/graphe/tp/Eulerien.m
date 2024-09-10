function res = Eulerien(D,d)

A=zeros(size(D)) ; %adj matrix
for i = 1:size(D,1)
    for j = 1:size(D,2)
        if (D(i,j) <= d) & ~(i==j) 
            A(i,j) = 1;
        end
    end
end

if isEulerien(A)
    res = true;
else
    res = false
end
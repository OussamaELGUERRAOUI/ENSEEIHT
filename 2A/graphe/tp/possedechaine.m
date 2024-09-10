function res = possedechaine(A, c)  
    res = false;

    while length(c) >= 2
        i = c(1);
        j = c(2);

        if A(i, j) == 1
            c = c(2:end);
            res = true;
        else
            res = false;
            break;
        end
    end
end

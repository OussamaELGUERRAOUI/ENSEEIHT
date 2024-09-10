function y = dirac1(x)

    y = zeros(size(x));
    y(x==0) = 1;
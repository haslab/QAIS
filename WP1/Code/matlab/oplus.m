function R = oplus(A,B)
    [m, k] = size(A);
    [n, j] = size(B);
    R = [ A zeros(m,j) ; zeros(n,k) B ];
end
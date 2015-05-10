function R = otimes(A,B)
    [m, k] = size(A);
    [n, j] = size(B);
    R = kr(A*fst(k,j),B*snd(k,j));
end

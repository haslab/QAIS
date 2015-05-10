function C = choice(p,M,N)
    if size(M) ~= size(N)
        error('Dimensions must agree');
    else
        C = p*M+(1-p)*N;
   end
end

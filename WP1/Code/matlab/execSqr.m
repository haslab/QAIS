function R = execSqr(fAdd,n,m,N)
    if (N==0)
        R = sqr(fAdd,zeros(m,n));
    else
        R = sqr(fAdd,execSqr(fAdd,n,m,N-1));
    end
end
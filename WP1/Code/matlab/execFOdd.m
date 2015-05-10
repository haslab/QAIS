function R = execFOdd(fAdd,n,m,N)
    if (N==0)
        R = fOdd(fAdd,zeros(m,n));
    else
        R = fOdd(fAdd,execFOdd(fAdd,n,m,N-1));
    end
end
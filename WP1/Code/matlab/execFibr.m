function R = execFibr(fAdd,n,m,N)
    if (N==0)
        R = fibr(fAdd,zeros(m,n));
    else
        R = fibr(fAdd,execFibr(fAdd,n,m,N-1));
    end
end
function R = execFibl(fAdd,n,m,N)
    R = fst(m,m)*aux(fAdd,n,m,N);
end

function R = aux (fAdd,n,m,N)
    if (N==0)
        R = fibl(fAdd,zeros(m*m,n));
    else
        R = fibl(fAdd,aux(fAdd,n,m,N-1));
    end
end
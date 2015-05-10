function R = execSqr2(n,m,N)
    if (N==0)
        R = sqr2(zeros(m,n));
    else
        R = sqr2(execSqr2(n,m,N-1));
    end
end
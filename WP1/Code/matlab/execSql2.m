function R = execSql2(n,m,N)
    R = fst(m,m)*aux(n,m,N);
end

function R = aux (n,m,N)
    if (N==0)
        R = sql2(zeros(m*m,n));
    else
        R = sql2(aux(n,m,N-1));
    end
end

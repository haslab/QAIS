function R = nfAdd(n,m)
    aux = zeros(m,n);
    for i=0:(m-1)
        for j=0:(m-1)
            if (i+j+1<=m && (i*m+j+1)<=n)
                aux(i+j+1,i*m+j+1) = 1;
            end
        end
    end
    
    R = aux;
end


function C = faultyCat(numElems,maxLength,N)
    if (N==0)
        dim = 1;
        for i=1:maxLength
            dim = dim + numElems^i;
        end
        C = fold(@faultyCatGene,zeros(dim,dim),numElems,maxLength);
    else
        C = fold(@faultyCatGene,faultyCat(numElems,maxLength,N-1),numElems,maxLength);
    end
end
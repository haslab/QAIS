function C = faultyCount(numElems,maxLength,N)
    if (N==0)
        dim = 1;
        for i=1:maxLength
            dim = dim + numElems^i;
        end
        C = fold(@faultyCountGene,zeros(maxLength+1,dim),numElems,maxLength);
    else
        C = fold(@faultyCountGene,faultyCount(numElems,maxLength,N-1),numElems,maxLength);
    end
end
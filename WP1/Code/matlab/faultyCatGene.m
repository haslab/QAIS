function C = faultyCatGene(numElems,maxLength)
    dim = 1;
    for i=1:maxLength
        dim = dim + numElems^i;
    end
    C = [zero(dim) choice(0.1,lose(numElems,maxLength),send(numElems,maxLength))];
end
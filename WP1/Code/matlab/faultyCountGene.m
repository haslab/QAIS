function C = faultyCountGene(numElems,maxLength)
    dim = 1;
    for i=1:maxLength
        dim = dim + numElems^i;
    end
    C = [zero(maxLength+1) choice(0.15,eye(maxLength+1),succ(maxLength+1,maxLength+1))*snd(numElems,maxLength+1)];
end
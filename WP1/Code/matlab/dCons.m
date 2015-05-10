function C = dCons(numElems,maxLength)
    %To Calculate the size of the input type
    %(Sequence of at most maxLength size with numElems different elements)
    nRows = 1;
    for i=1:maxLength
        nRows = nRows + numElems^i;
    end
    
    %To allocate size for the output and input type elements
    columns = zeros(nRows,maxLength+1);
    rows = zeros(numElems*nRows,maxLength+1);
    
    %To generate the input type
    index = 2;
    for j=1:maxLength
        aux = genSequences(1:numElems,j)';
        [a b] = size(aux);
        for k=1:a
            for h=1:b
                columns(index,h) = aux(k,h);
            end
            index = index + 1;
        end
    end
    %To generate the output type
    index = 1;
    for j=1:numElems
        for k=1:nRows
            rows(index,1) = j;
            for h=1:maxLength
                rows(index,h+1) = columns(k,h);
            end
            index = index + 1;
        end
    end
    columns
    
    %To calculate the dCons function/matrix
    C = zeros(numElems*nRows,nRows);
    for k=1:(nRows)
        for f=1:(numElems*nRows)
            if (all(columns(k,1:maxLength+1)==rows(f,1:maxLength+1))==1)
                C(f,k) = 1;
            end
        end
    end
end
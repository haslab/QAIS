function C = lose(numElems,maxLength)
    %To Calculate the size of the output type
    %(Sequence of at most maxLength size with numElems different elements)
    nRows = 1;
    for i=1:maxLength
        nRows = nRows + numElems^i;
    end
    
    %To allocate size for the output and input type elements
    rows = zeros(nRows,maxLength+1);
    columns = zeros(numElems*nRows,maxLength+1);
    
    %To generate the output type
    index = 2;
    for j=1:maxLength
        aux = genSequences(1:numElems,j)';
        [a b] = size(aux);
        for k=1:a
            for h=1:b
                rows(index,h) = aux(k,h);
            end
            index = index + 1;
        end
    end
    %To generate the input type
    index = 1;
    for j=1:numElems
        for k=1:nRows
            columns(index,1) = j;
            for h=1:maxLength
                columns(index,h+1) = rows(k,h);
            end
            index = index + 1;
        end
    end
    
    %To calculate the lose function/matrix
    C = zeros(nRows,numElems*nRows);
    for k=1:(numElems*nRows)
        for f=1:(nRows)
            if (all(columns(k,2:maxLength+1)==rows(f,1:maxLength))==1)
                C(f,k) = 1;
            end
        end
    end
end
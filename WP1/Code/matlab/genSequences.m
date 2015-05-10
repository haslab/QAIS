function C = genSequences(elems,length)
    %Used to generate all the possible sequences of, at most, length size
    %with elems different elements
    if (length==1)
        C = elems;
    else
        C = combvec(elems,genSequences(elems,length-1));
    end
end
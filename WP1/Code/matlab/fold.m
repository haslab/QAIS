function R = fold(gene,Rec,numElems,maxLength)
%
%     [n] --- out ---> 1 + n x [n]
%      |                 |
%      |                 |
%     cat             id + id * cat
%      |                 |
%      |                 |
%      v                 v
%      m <----- g ---- 1 + n x m
%
%             g = gene
%
    [m n] = size(Rec);
    
    %Defining co-algebra
    coref1 = zeros(n,n);
    coref1(1,1) = 1;
    coref2 = [zeros(1,n);zeros(n-1,1) eye(n-1)];
    coalg = oplus(bang(n),dCons(numElems,maxLength))*[coref1;coref2];
    
    %Defining recursive call
    FRec = oplus(eye(1),otimes(eye(numElems),Rec));
    
    %Defining algebra
    alg = gene(numElems,maxLength);
    
    R = alg*FRec*coalg;
end

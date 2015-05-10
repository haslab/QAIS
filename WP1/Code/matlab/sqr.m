function R = sqr(fAdd,Rec)
%
%
%      n --- out --->  1 + n
%      |                 |
%      |                 |
%     sq              id + (sq,id)
%      |                 |
%      |                 |
%      v                 v
%      m <----- g ---  1 + (m x n)
%
%  g = [ 0 | (+) ] . (id + id >< odd)
%
    [m n] = size(Rec);

    %Defining co-algebra
    coref1 = [zero(n) zeros(n,n-1)]; %Equal to zero coref
    coref2 = [zeros(1,n);zeros(n-1,1) eye(n-1)]; %Not equal to zero coref
    coalg = oplus(bang(n),pred(n,n))*[coref1;coref2];
    
    %Defining recursive call
    FRec = oplus(eye(1),kr(Rec,eye(n,n)));
    
    %Defining algebra
    alg = [zero(m) fAdd(m*m,m)]*oplus(eye(1),otimes(eye(m),odd(n,m)));
    
    R = alg*FRec*coalg;
end

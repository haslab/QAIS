function R = fOdd(fAdd,Rec)
%
%      n --- out --->  1 + n
%      |                 |
%      |                 |
%     odd             id + odd
%      |                 |
%      |                 |
%      v                 v
%      m <---- g ----  1 + m
%
%      g = [1 | (+2)]
%
    [m n] = size(Rec);
    
    %Defining out
    coref1 = [zero(n) zeros(n,n-1)]; %Equal to zero coref
    coref2 = [zeros(1,n);zeros(n-1,1) eye(n-1)]; %Not equal to zero coref
    out = oplus(bang(n),pred(n,n))*[coref1;coref2];
    
    %Defining recursive call
    FRec = oplus(eye(1),Rec);
    
    %Defining algebra
    a = [one(m) fAdd(m,m)];
    
    R = a*FRec*out;
end
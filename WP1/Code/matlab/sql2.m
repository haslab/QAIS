function R = sql2(Rec)
%
%      n --- out --->  1 + n
%      |                 |
%      |                 |
%  (sq,odd)           id + (sq,odd)
%      |                 |
%      |                 |
%      v                 v
%   (m x m) <-- g ---  1 + (m x m)
%
%   g = [ <0,1> | <+,(+2).pi2> ]
%
    [rRec n] = size(Rec);
    m = sqrt(rRec);
    
    %Defining out
    coref1 = [zero(n) zeros(n,n-1)]; %Equal to zero coref
    coref2 = [zeros(1,n);zeros(n-1,1) eye(n-1)]; %Not equal to zero coref
    out = oplus(bang(n),pred(n,n))*[coref1;coref2];
    
    %Defining recursive call
    FRec = oplus(eye(1),Rec);
    
    %Defining algebra
    a = [kr(zero(m),one(m)) kr(fAdd0(m*m,m),fAdd1(m,m)*snd(m,m))];
    
    R = a*FRec*out;
end

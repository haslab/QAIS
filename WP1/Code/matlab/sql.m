function R = sql(fAdd,Rec)
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
    add2 = zeros(m,m);
    for i=0:m-1
        if (i+2+1<=m)
            add2(i+2+1,i+1) = 1;
        end
    end
    a = [kr(zero(m),one(m)) kr(fAdd(m*m,m),add2*snd(m,m))];
    
    R = a*FRec*out;
end

function R = fibr(fAdd,Rec)
%
%
%      n --- out ---> (1 + 1) + n x n
%      |                      |
%      |                      |
%     fib           (id + id) + fib><fib
%      |                      |
%      |                      |
%      v                      v
%      m <----- g --- (1 + 1) + (m x m)
%
%           g = [ [0 | 1] | (+) ]
%
    [m n] = size(Rec);
    
    %Defining out
    coref1 = [zero(n) one(n) zeros(n,n-2)]; %Less than 2 coref
    coref2 = oplus(zeros(2,2),eye(n-2,n-2)); %Greater or equal than 2 coref
    coref3 = [zero(n) zeros(n,n-1)]; %Equals 0 coref
    coref4 = [zeros(n,1) one(n) zeros(n,n-2)]; %Equals 1 coref
    coalg = oplus(oplus(bang(n),bang(n))*[coref3;coref4],kr(pred(n,n)*pred(n,n),pred(n,n)))*[coref1;coref2];
    
    %Defining recursive call
    FRec = oplus(oplus(eye(1),eye(1)),otimes(Rec,Rec));
    
    %Defining algebra
    alg = [[zero(m) one(m)] fAdd(m*m,m)];
    
    R = alg*FRec*coalg;
end
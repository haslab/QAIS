function C = succ(n,m)
% succ : n -> m
   C = zeros(m,n);
   for a = 0:n-1 
       c= a + 1 ; % c=f(a) is the unary function being tabulated        
       x= a+1;
       y=1+c ;
       if y <= m
          C(y,x) = 1 ;
        end
   end
end
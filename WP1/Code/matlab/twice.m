function C = twice(n,m)
% twice : n -> m
% add k = (k+)
   C = zeros(m,n);
   for a = 0:n-1 
       c= 2*a ; % c=2*a is the unary function being tabulated        
       x= a+1;
       y=1+c ;
       if y <= m
          C(y,x) = 1;
        end
   end
end

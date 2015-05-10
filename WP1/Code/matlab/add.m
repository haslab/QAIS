function C = add(m,n,k)
% add : m x n -> k
   C = zeros(k,m*n);
   for a = 0:m-1 
       for b = 0:n-1 
           c=a+b ; % c=f(a,b) is the binary function being tabulated        
           x=a*n+(1+b);
           y=1+c ;
           if y <= k
              C(y,x) = 1 ;
           end
       end
   end
end

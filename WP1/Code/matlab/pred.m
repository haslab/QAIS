function C = pred(n,m)
% pred : n -> m
   C = zeros(m,n);
   for a = 2:n
       if (a-1<=m)
           C(a-1,a) = 1;
       end
   end
end
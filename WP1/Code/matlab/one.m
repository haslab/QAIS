function C = one(n)
% one : 1 -> n
   C = zeros(n,1);
   if (n>1)
       C(2,1) = 1;
   else
       error('One outside type');
   end
end
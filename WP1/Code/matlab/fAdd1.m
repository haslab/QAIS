function R = fAdd1(n,m)
  aux = zeros(m,n);
  for i=1:m
      for j=1:n
          if (i==j) aux(i,j) = 0.1;
          else if (i==j+2) aux(i,j) = 0.9;
              end
          end
      end
  end
  R = aux;
end
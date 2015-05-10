
function R = jay(r,c)
         if r>=c 
            R = [ zeros(r-c,c) ; eye(c) ];
         else
            R = [ zeros(r,c-r) eye(r) ];
         end
end

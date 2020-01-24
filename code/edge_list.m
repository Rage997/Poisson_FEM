function [E] = edge_list(T)
for i=1:height(T)
    for j=1:3 
       edge = T(i,mod(j+1,3));
       
    end
end

end
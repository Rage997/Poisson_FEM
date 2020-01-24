function E = create_edge_list(T)
    len = size(T,1);
    E = zeros(len); 
    for i=1:size(T,1)
        for j=1:3
            edge = [T(i,j), T(i,1+mod(j,3))];
            
             if(edge(1) > edge(2))
                    tmp = edge(2);
                    edge(2) = edge(1);
                    edge(1) = tmp;
             end
                         
            if ismember(edge(2),E(edge(1),:)) == 0
                for k=1:len    
                    if E(edge(1), k) == 0 %to the first non-zero
                        E(edge(1),k ) = edge(2);
                        break
%                     Check wheter p1 > p2 
                    elseif E(edge(1), k) > edge(2)
                        tmp = E(edge(1), k);
                        E(edge(1), k) = edge(2);
                        edge(2) =  tmp;
                    end
                end
            end
        end
    end
%     Delete eventually zero rows/cols
%     Not working
%     E(E(:,1)==0,:) = [] ;
%     E(E(1,:)==0,:) = [] ;
end

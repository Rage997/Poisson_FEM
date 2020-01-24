function vistriang(P,T,b)
% TODO Using the edge list would simplify the code

    number_triangles = size(T);
    number_triangles = number_triangles(1);
    hold on
    
    visited_edges = [];
    for i=1:number_triangles
%         for each triangles get the three points
        points_index = T(i,:);
        edge1 = [points_index(1), points_index(2)];
        edge2 = [points_index(2), points_index(3)];
        edge3 = [points_index(3), points_index(1)];
            edges = [edge1; edge2; edge3];
            for j=1:3
                if is_in(edges(j,:), visited_edges) == 0
                p1 = P(edges(j,1),:);
                p2 = P(edges(j,2),:);
%                 add the boundary conditions
                    if b(edges(j,1)) == 0
                        scatter(p1(1), p1(2), 500, 'r');
                    elseif b(edges(j,1)) == 1
                        scatter(p1(1), p1(2), 500, 'b');
                    else
                        scatter(p1(1), p1(2), 500, 'g');
                    end
                h = line([p1(1), p2(1)], [p1(2), p2(2)], 'Color', 'b');
                visited_edges(end+1,:) = edges(j,:);
                end
            end
          
    end
   hold off
end

function bool = is_in(x, A)
if isempty(A)
    bool = false;
    return
end
    for i=1:size(x)
        if all(x(i,:) == A(i,:)) || all((flip(x(i,:)) == A(i,:)))
            bool = true;
            return
        end
    end
    bool = false;
end


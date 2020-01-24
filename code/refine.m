function [PP, TT, bb] = refine(P, T, b)

E = create_edge_list(T);

[PP, L, bb] = bisect(P, E, b);

[TT] = update_elements(T, E, L);

end

function [PP, L, bb] = bisect(P, E, b)
PP = P;
bb = b;
dm = size(E);
% Go through all the edges. Note, if E(i,j) == 0 then there's no edge
    for i=1:dm(1)
        for j=1:dm(2)
            if E(i,j) ~= 0 %if there's an edge between pi and pj
                mid_point = (P(i,:) + P(E(i, j),:))/2;
                PP(end +1, :) = mid_point;
                L(i,j) = size(PP, 1);
                if b(i) == 0 && b(E(i,j)) == 0 %something wrong here
                    bb(L(i,j)) = 0;
                else
                    bb(L(i,j)) = 1;
                end
            end
        end
    end
end

function TT = update_elements(T, E, L)
TT = [];
    for i=1:size(T, 1)
        for j=1:3
            p1 = T(i,j);
            p2 = T(i, 1+mod(j,3));
    %         find edge (p1, p2) in E
            if p1 > size(E,1)
                tmp = p1;
                p1 = p2;
                p2 = tmp;
            end
            index = find(E(p1, :) == p2);
            if isempty(index)
                index = find(E(p2, :) == p1);
                p1 = p2;
            end
            m(j) = L(p1, index);
        end

        new_triangles(4*1-3:4*1,:) = [[T(i,1), m(1), m(3)]; ...
                            [m(1), T(i,2), m(2)]; ...
                            [m(3), m(2), T(i,3)]; ...
                            [m(1), m(2), m(3)];];
        TT = [TT ; new_triangles];
    end
end


% FUnction to assembly the stiffness matrix

function [S] = fem(P, T, b)

S = sparse(size(P,1), size(P,1));
for i=1:size(T,1)
%   compute A_T(i)
%   get the points from the current triangle
    p1 = T(i, 1);
    p2 = T(i, 2);
    p3 = T(i, 3);
    
%     compute coeff a, b, c
    coeef_a = p2-p1;
    coeff_b = p3-p2;
    coeff_c = p1-p3;
    
%  Compute cos(w1) cos(w2) ... etc etc
    cos_w1 = get_cos(coeef_a, coeff_c);
    cos_w2 = get_cos(coeef_a, coeff_b);
    cos_w3 = get_cos(coeff_b, coeff_c);
    
%     Compute sin(w1) ... etc etc
    sin_w1 = get_cos(coeef_a, coeff_c);
    sin_w2 = get_cos(coeef_a, coeff_b);
    sin_w3 = get_cos(coeff_b, coeff_c);
    
%     Finally compute matrix A_T(i) 
    A_t = 1/2 * [sin_w3/cos_w3 + sin_w2/cos_w2, -sin_w3/cos_w3, -sin_w2/cos_w2 ;
               -sin_w3/cos_w3, sin_w3/cos_w3 + sin_w1/cos_w1, -sin_w1/cos_w1;
               -sin_w2/cos_w2, -sin_w1/cos_w1, sin_w2/cos_w2 + sin_w1/cos_w1];
           
    for j=1:3
        for k=1:3
            if (b(T(i,j)) ~= 0) && (b(T(i,k)) ~= 0)
                S(T(i,j), T(i,k)) = S(T(i,j), T(i,k)) + A_t(j,k);
            end
        end
    end
    
end

% handle boundaries

% put zeros in boundary rows/columns of S
% store also indexes of dirichlet points
p_d = [];
for i=1:size(b,1)
    if b(i) == 0
        p_d(end+1) = i;
        S(i,:) = 0;
        S(:,i)=0; 
    end
end

% put I into boundary submatrix of S (otherwise the matrix is singular)
S(p_d,p_d)=speye(length(p_d),length(p_d)); 

        
end


% Just helper function with computations (formulas in exercise sheet)
function [res] = get_cos(x, y)
    res = -(x' * y)/ (norm(x,2) * norm(y,2));
end
function [res] = get_sin(x, y)
    A = [x, y];
    res = det(A)/ (norm(x,2) * norm(y,2));
end

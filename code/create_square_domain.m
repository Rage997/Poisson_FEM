function [P, T, b] = create_square_domain(r, visualise)
% arguments:
%    (int) r : level of refinement of the mesh
%   (int) visualise : wheter to plot or not the resulting domain (suggest
%   to not visualise the results for r > 4 due to leak in performance for vistriang function)
% Point list
P = [
    0 0 ;
    1 0 ;
    1 1 ;
    0 1 ;
    0.5 0.5 ;
    ];
% element list
T = [
    1 2 5;
    2 3 5;
    3 4 5;
    4 1 5;
    ];
% flag vector for boundary conditions
% 0 = dirichlet
% 1 = inner point
% 2 = neumann
b = [0 0 0 0 1]';

% vistriang(P, T, b);

E = create_edge_list(T);

% Refinement 
for i=1:r
    [P, T, b] = refine(P, T, b);
end

% my vistriang is a really bad implementation and requires a lot of memory
% with r=6 it required too much space. I tried with r=3 and it s laggy but
% okay
if visualise
figure();
vistriang(P, T, b);
end

end
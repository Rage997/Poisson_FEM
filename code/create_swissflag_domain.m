function [P, T, b] = create_swissflag_domain(r, visualise)
% arguments:
%    (int) r : level of refinement of the mesh
%   (int) visualise : wheter to plot or not the resulting domain (suggest
%   to not visualise the results for r > 4 due to leak in performance for vistriang function)
% Point list

% Point list
P = [
%     first line
    0 0 ;
    1 0 ;
    2 0 ;
    3 0 ;
    4 0 ;
    5 0 ;
    
    0 1 ;
    1 1 ;
    2 1 ;
    3 1 ;
    4 1 ;
    5 1 ;
    
    0 2 ;
    1 2 ;
    2 2 ;
    3 2;
    4 2 ;
    5 2 ;
    
    0 3 ;
    1 3 ;
    2 3 ;
    3 3 ;
    4 3 ;
    5 3 ;
    
    0 4 ;
    1 4 ;
    2 4 ;
    3 4 ;
    4 4 ;
    5 4 ;
    
    0 5 ;
    1 5 ;
    2 5 ;
    3 5 ;
    4 5 ;
    5 5 ;
    ];


% element list
T = [
    1 2 8;
    1 8 7;
    2 3 9;
    2 9 8 ;
    3 4 10 ;
    3 10 9;
    4 5 11 ;
    4 11 10 ;
    5 6 12 ;
    5 12 11 ;
    
    7 8 14 ;
    7 14 13 ;
    9 15 8;
    8 15 14;
    10 11 17;
    10 17 16;
    11 12 18;
    11 18 17;
    
    13 14 20;
    13 20 19;
    17 18 24;
    17 24 23;
    
    19 20 26;
    19 26 25;
    20 21 27;
    20 27 26;
    22 23 29;
    22 29 28;
    23 24 30;
    23 30 29;
    
    25 26 32;
    25 32 31;
    26 27 33;
    26 33 32;
    27 28 34;
    27 34 33;
    28 29 35;
    28 35 34;
    29 30 36;
    29 36 35;
    ];
% flag vector for boundary conditions
% 0 = dirichlet
% 1 = inner point 
% 2 = neumann
b = ones(36, 1);
% Insert dirichlet in boundary points

% boundary_points = [
%                    1, 2, 3, 4, 5, 6 ... %unit square boundaries
%                    7, 12, ...
%                    13, 18, ...
%                    19, 24, ...
%                    25, 30, ...
%                    31, 32, 33, 34, 35, 36, ... %boundaries swiss flag
%                     9, 10 , 14, 15, 16, 17,  ...
%                     20, 21, 22, 23, 27, 28];
                
for i = 1:6:28 
    b(i) = 0;
end


E = create_edge_list(T);
% Refinement 
r = 5; % how many time refine the mesh
% r=6 takes a lot and may run out of memory
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
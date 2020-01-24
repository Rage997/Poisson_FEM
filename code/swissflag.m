clear all
clc
close all 

[P, T, b] = create_swissflag_domain(5, 0);

%% 

% Assignment 5: FEM
f = @(x,y) sin(pi*x);


S = fem(P, T, b); %assembly stiffness matrix
F = mass(P, T, b, f);  %assembly mass matrix

% direct solution
% U=S\F;  
% using cg

n = size(P,1);
x0 = zeros(n,1); %init

U = CG(S, F, x0, 1000, 0.001);

% plot numerical solution
figure();
trisurf(T,P(:,1),P(:,2),0*P(:,1),U,'edgecolor','k','facecolor','interp');
view(2),axis equal,colorbar
xlabel('Numerical solution')


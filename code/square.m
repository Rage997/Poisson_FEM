clear all
clc
close all 

[P, T, b] = create_square_domain(5, 0);

%% 

% Assignment 5: FEM
coeff = pi/2;

f = @(x,y)  1 ;

% f = @(x,y) (pi^2/2) * sin(y)^2 * (cos(pi/2*x)^2 - sin(pi/2*x)^2) - (pi^2/2) * sin(x)^2 * (cos(pi/2*y)^2 - sin(pi/2*y)^2) 

S = fem(P, T, b); %assembly stiffness matrix
F = mass(P, T, b, f);  %assembly mass matrix 

% direct solution
% U=S\F;  
% using cg
n = size(P,1);
x0 = zeros(n,1); %init

U = CG(S, F, x0, 1000, 10^-6);

% plot numerical solution
figure();
trisurf(T,P(:,1),P(:,2),0*P(:,1),U,'edgecolor','k','facecolor','interp');
view(2),axis equal,colorbar
xlabel('Numerical solution')



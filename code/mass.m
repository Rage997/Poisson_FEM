% Assembly mass matrix
function M = mass(P, T, b, f)
% I used as reference "Numerical models for differential problems,
% Quarteroni, chapter 8"

M=zeros(size(P,1),1);

for t=1:size(T,1) %ITerate over all triangles
  points=T(t,:); %get the index of corners for each triangle
  p = P(points, :); %get the actual points values
  Pe=[ones(3,1),p]; % 3x3 matrix ->[1 x y]
  Area=abs(det(Pe))/2; % area of triangle K = half square

%   formula Area(K) * sum_i=0:2 [1/3 * f(Nj] where Nj are the nodes of the
%   triangle K
  Me = 0; %init
  for j=1:3 %multiply sum of phi(Nj) over triangle K by f(pj)
  Me = f(p(j,1), p(j,2))/3 + Me;
  end
  Me = Me *Area;
% Add the result the corresponding points
  M(points)=M(points)+Me;
end

% handle boundaries 
for i=1:size(b,1)
    if b(i) == 0 %dirichlet
        M(i)=0;
    end

end

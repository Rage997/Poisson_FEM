To run the code, run square.m and swissflag.m

The code runs correctly but has some problems in performance. The Swiss 
flag will take a lifetime to solve with a level 6 of refinement. I used a 
level 4. On my mac book pro, it requires even a lower level of refinement.


Part 1 (get the circus tent like shape)
I failed to get the required shape. My best attempt is coded in square.m 
(running the matlab will plot it). The blue part is negative, if that part
would be positive, it would be, in my opinion, close enough to the circus 
tent. Howwewer, I don't know chich function f(x,y) to choose to get such
function


Part 2 (swiss flag with neumman boundary) 
Neumann boundary: since the neumman boundary condition is homogeneous, all 
I have done is removing the dirichlet boundary condition from the vector b
in the "create_swissflag_domain.m". If the neumman boundary is homogeneous,
I shouldn't need to do anything, just assemble the stiffness matrix and load
vector and solve the problem.
function [x, i] = CG( A,b,x0,max_itr,tol )
%d)
r = b - A * x0;
d = r;
p_old = r' * r;
x = x0;
i = 1;

while(i < max_itr  && norm(r)/norm(b) >= tol)
    s = A * d;
    alpha = p_old/(d' * s);
    x = x + alpha*d;
    r = r - alpha*s;
    p_new = r' * r;
    beta = p_new / p_old;
    d = r + beta * d;
    p_old = p_new;
    i = i + 1;
end
end

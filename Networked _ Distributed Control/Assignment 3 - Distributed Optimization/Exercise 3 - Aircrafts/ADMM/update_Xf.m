function [Xf] = update_Xf(X,U,L_c)
global A B x0 Tfinal umax n a rho Xflim
s_t = zeros(n,n);
c1 = 0;
for i=1:a
    s_t(:,i) = A(:,:,i)^Tfinal*x0(:,i);
    for t=1:Tfinal
        c1 = c1 + X(:,t,i)'*X(:,t,i) + U(:,t,i)'*U(:,t,i);
        s_t(:,i) = s_t(:,i) + A(:,:,n)^(t-1)*B(:,:,i)*U(:,t,i);
    end
end
x = sdpvar(4,1);
s = sum(s_t,2);
opts = sdpsettings('verbose',0);
sol = optimize(x'*x<=Xflim,c1+L_c*(s-n*x)+rho/2*(s-n*x)'*(s-n*x),opts);
if any(sol.problem ~= 0)
    error('Optimization infeasible')
end
Xf = value(x);
end
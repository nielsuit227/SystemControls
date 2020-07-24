function [L_c] = update_L_c(X,U,Xf)
global A B x0 Tfinal umax n a rho Xflim m
c1 = 0;
c2 = zeros(n,1);
for i=1:a
    for t=1:Tfinal
        c1 = c1+ X(:,t,i)'*X(:,t,i) + U(:,t,i)'*U(:,t,i);
        c2 = c2+ A(:,:,i)^(t-1)*B(:,:,i)*U(:,t,i);
    end
    c2= c2+ (A(:,:,i)^Tfinal*x0(:,i)-Xf);
end


Lc = sdpvar(1,n);
eps = 1e-3*ones(1,n);
con = [Lc >= eps];
opts = sdpsettings('verbose','0');
sol = optimize(con,c1+Lc*c2+rho/2*c2.*c2,opts);
if any(sol.problem ~= 0)
    error('Optimization infeasible')
end
L_c = value(Lc);
end

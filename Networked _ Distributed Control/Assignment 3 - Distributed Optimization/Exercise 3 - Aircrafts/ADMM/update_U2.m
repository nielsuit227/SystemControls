function [U,X] = update_U(x,L_c,Xf);
global A B x0 Tfinal umax n a rho Xflim m
c1 = 0; c2 = zeros(n,1);
for i=1:a
    for t=1:Tfinal
        c1 = c1+ x(:,t,i)'*x(:,t,i) + Xf'*Xf;
    end
    c2 = c2+ L_c*(A(:,:,i)*x(:,1,i)-Xf);
end
Q1 = [B(:,:,1) A(:,:,1)*B(:,:,1) A(:,:,1)^2*B(:,:,1) A(:,:,1)^3*B(:,:,1) A(:,:,1)^4*B(:,:,1)];
Q2 = [B(:,:,2) A(:,:,2)*B(:,:,2) A(:,:,2)^2*B(:,:,2) A(:,:,2)^3*B(:,:,2) A(:,:,2)^4*B(:,:,2)];
Q3 = [B(:,:,3) A(:,:,3)*B(:,:,3) A(:,:,3)^2*B(:,:,3) A(:,:,3)^3*B(:,:,3) A(:,:,3)^4*B(:,:,3)];
Q4 = [B(:,:,4) A(:,:,4)*B(:,:,4) A(:,:,4)^2*B(:,:,4) A(:,:,4)^3*B(:,:,4) A(:,:,4)^4*B(:,:,4)];
u = sdpvar(2,5,4);
cons = sum(sum(u.^2)) <= umax;
clc fprintf('U starting')
opts = sdpsettings('verbose',0,'solver','sdpa','sdpa.maxIteration',1000);
sol = optimize(cons,c1 + L_c*c2 + sum(sum(u.^2)) + L_c*(Q1*vec(u(:,:,1)) + ...
Q2*vec(u(:,:,2))+Q3*vec(u(:,:,3))+Q4*vec(u(:,:,4))),opts);
U = value(u);
fprintf('U finished')
for i=1:a
    for t=1:Tfinal
    end
end

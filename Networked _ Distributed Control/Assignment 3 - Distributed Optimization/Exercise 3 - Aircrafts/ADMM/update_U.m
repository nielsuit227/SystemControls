function [U,X] = update_U(X,L_c,Xf);
global A B x0 Tfinal umax n a rho Xflim m
for i = 1:a
    
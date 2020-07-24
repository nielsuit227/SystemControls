clear
close all
clc

syms s b1 b2 b3 b4

A = [-1 1 0 0;0 -1 0 0;0 0 0 1;0 0 0 0];
B = [b1;b2;b3;b4];
C = [1 -1 0 2];
G = C*(s*eye(4) - A)^-1 * B;
K =[b1 b2-b1 b1-2*b2 3*b2-b1; b2 -b2 b2 -b2; b3 b4 0 0; b4 0 0 0];
[L,U] = lu(K);
%% b3 = b2 = 0
b3 =0;
b2 =0;
K =[b1 b2-b1 b1-2*b2 3*b2-b1; b2 -b2 b2 -b2; b3 b4 0 0; b4 0 0 0];
[L,U] = lu(K);
%% Controllable canonical
a1 = 2; a2 = 2; a3 = 0; a4 = 0;
B = [1;1;1;1];
S1 = B;
S2 = (A + eye(4)*a1)*B;
S3 = (A^2 + A*a1 + eye(4)*a2)*B;
S4 = (A^3 + A^2*a1 + A*a2)*B;
S = [S1 S2 S3 S4];
%% try hard
syms f1 f2 f3 f4
l = -3;
F = [f1 f2 f3 f4];
X = A - B*F - eye(4)*l;
[f1 f2 f3 f4] = solve( det(X) == 0,f1,f2,f3,f4);
%% checking
F = [f1 f2 f3 f4]
eig(A - B*F)

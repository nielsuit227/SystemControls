clear
close all
clc
%% 3.B
A = [-2 1 -1 2;1 -3 0 2;1 1 -4 2;0 1 -1 -1];
B = [2;2;2;1];
C = [0 1 -1 0];

S = [0 1 0 0; 0 0 0 1; 1 0 0 1; 0 0 1 0];

Aon = S^-1 * A * S;
Bon = S^-1 * B;
Con = C * S;
%% 3.C
[e,d] = eig(Aon);
for n=1:length(d)
    Cm = [A-d(n,n)*eye(length(A(:,1))) B];
    RCm(n) = rank(Cm);
end
%% 3.D
sys = ss(A,B,C,0);
[Msys,U] = minreal(sys);
Amin = U*A*U';
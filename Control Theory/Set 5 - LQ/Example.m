clear
close all
clc
%% Data
A = [-1 1; 0 0];
B = [0 1]';
Q = [2 -1;-1 1];
R = 1;
%% Check controllability of (A,B) and (A’,Q)
[l,u]=lu(ctrb(A,B))
[l,u]=lu(ctrb(A',Q))

%% Compute transformation based on eigen-decomposition of H
H=[A -B*inv(R)*B';-Q -A'];
[n,n]=size(A);[T,D]=eig(H);Z=[];
for j=1:2*n;
if real(D(j,j))<0;Z=[Z T(:,j)];end;
end;
T11=Z(1:n,:);T21=Z(n+1:2*n,:);
myP=T21*T11^(-1);
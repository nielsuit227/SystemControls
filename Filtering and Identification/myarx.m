function [aest, best] = myarx(y,u,N)
%% Structure data
% Data is structured to create matrix Phi which is used to solve
% Y-theta*phi for minimal error. Theta is then splitted in the constants
% for a estimates and b estimates. 
s = length(y);
teta = zeros(2*N,1);
phi = zeros(s,2*N);
for n=2:s
    phi(n-1,1) = y(n-1);
    phi(n,2:N) = phi(n-1,1:N-1);
    phi(n-1,N+1) = u(n-1);
    phi(n,N+2:2*N) = phi(n-1,N+1:2*N-1);
end
phi2 = phi(N+1:s,:);
y2 = y(N+1:s,:);
%% Solving for theta
teta_fm = pinv(phi2)*y2;
aest = teta_fm(1:N);
best = teta_fm(N+1:2*N);
end

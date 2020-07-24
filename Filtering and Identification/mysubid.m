function [At, Bt, Ct, Dt, x0t, S] = mysubid(y, u, s, n)
%% Structure Data
N = length(u) - s;
UosN = zeros(s,N);
YosN = zeros(s,N);
for m = 1:s
    for o = 1:N
    UosN(m,o) = u(m+o);
    YosN(m,o) = y(m+o);
    end
end    
%% RQ decomposition
[Q,R] = qr([UosN;YosN]');
Qt = Q'; Rt = R';   
%% Getting R22
R22 = Rt(s+1:2*s,s+1:2*s);
%% SVD of R22
[Un,St,V] = svd(R22);
%% Calculating system matrices
Ct = Un(1,1:n);
At = pinv(Un(1:s-1,1:n))*Un(2:s,1:n);
[Bt Dt x0t] = subidhelp(y,u,At,Ct);
%% Rewriting the singular values to vector
for n=1:s
    S(n) = St(n,n);
end

end
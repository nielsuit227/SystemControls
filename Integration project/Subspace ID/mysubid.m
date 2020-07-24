function [At,Ct,S] = mysubid(y, u, s, n)
% y = output, u = input, s = systeem order, n = henkel size
%% Structure Data
N = length(u) - s;
UosN = zeros(s,N);
for m = 1:s
    for o = 1:N
    UosN(m,o) = u(m+o);
    YosN(m,o) = y(m+o);
    end
end    
fprintf('Henkel matrices assembled\n')
%% RQ decomposition
[Q,R] = qr([UosN;YosN]');
Qt = Q'; Rt = R';   
fprintf('RQ Decomposition completed\n')
%% Getting R22
R22 = Rt(s+1:2*s,s+1:2*s);
%% SVD of R22
[Un,St,V] = svd(R22);
fprintf('SVD completed\n')
%% Calculating system matrices
Ct = Un(1,1:n);
At = pinv(Un(1:s-1,1:n))*Un(2:s,1:n);
fprintf('A and C matrices assembled\n')
%% Rewriting the singular values to vector
for n=1:s
    S(n) = St(n,n);
end

end
% lock & load
clear
close all
clc
load data2
% Visualize input
plot(X(:, 1), X(:, 2), 'b*')
hold on
plot(X(Y == 1, 1), X(Y == 1, 2), 'r*')
% Parameters
c1 = 2;
c2 = 1;
a = 1;
m = 2;
d = 2;
eps1 = 1e-3;
eps2 = 1e-4;
w = 0.1;
zeta = [];
leta = [];
teta = [];
p = 0;
xr = rand(1, 5);
% Loop
for k = 1:length(Y)
    xk = X(k, :);
    yk = Y(k);
    % Wasserstein
    
    % ICA
    if ~ismember(yk, leta, 'rows', 'legacy')
        zeta = [zeta;xk];
        leta = [leta;yk];
        teta = [teta;1];
        p = p + 1;
    elseif vecnorm(zeta(leta==yk) - xk, 2, 2) > w
        zeta = [zeta;xk];
        leta = [leta;yk];
        teta = [teta;1];
        p = p + 1;
    else
        ind = vecnorm(zeta(leta==yk) - xk, 2, 2) <= w;
        teta(ind) = teta(ind) + 1/sum(ind);
    end
    % LP
    u = sdpvar(2, p);
    v = sdpvar(2, p);
    cons = [];
    cons = [cons, sum(u+v) <= k*eps];
    cons = [cons, u >= 0];
    cons = [cons, v >= 0];
    fun = 1/n*sum(diag(leta.*xr*(u-v-yp)));
    opts = sdpsettings('verbose', 0, 'solver','gurobi');
    sol = optimize(cons, fun, opts);
    % CP
    
    
    

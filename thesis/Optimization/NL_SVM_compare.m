%%% Calculates the Support Vector Machine without L2 regularization! 
%%% disclaimer: stuff here is not 100% true as the complementary KKT
%%% conditions are not fulfilled. 
clear 
close all
clc;
load NL_SVM_data
X = (X-mean(X))./sqrt(var(X));
n = 500;
X = X(1:n,:);
Y = Y(1:n);
%% Parameters
C = 1;
sigma = 0.5;
K = @(X,Y) exp(-diag((X-Y)*(X-Y)')/(2*sigma^2));
for i =1:n
    for j =1:n
        G(i,j) = K(X(i,:),X(j,:));
    end
end
%% OG SVM
opts = sdpsettings('solver', 'gurobi');
%% Solve and plot OG SVM
tic;
a = sdpvar(n,1);
cons = [];
cons = [cons, a >= 0];
cons = [cons, a <= 10000];
cons = [cons, sum(Y.*a) == 0];
fun = 1/2*(a.*Y)'*G*(a.*Y) - sum(a);
sol = optimize(cons, fun, opts);
a = value(a);
svm = toc;
plotsvm(Y, X, K, a, 'Unregularized SVM', 1);
%% Solve and plot Robust SVM
tic;
ra = sdpvar(n,1);
rcons = [];
rcons = [rcons, ra >= 0];
rcons = [rcons, ra <= C];
rcons = [rcons, sum(Y.*ra) == 0];
rfun = 1/2*(ra.*Y)'*G*(ra.*Y) - sum(ra);
rsol = optimize(rcons, rfun, opts);
ra = value(ra);
rsvm = toc;
plotsvm(Y, X, K, ra, 'Robust SVM', 2);
%% Solve and plot Distributionally Robust SVM
tic;
rho = 0.01;
k = 0.002;
L = 1;
drs = sdpvar(n, 1);
drb = sdpvar(n, 1);
lambda = sdpvar(1, 1);
drcons = [];
drcons = [drcons, drb >= 0];
drcons = [drcons, 1 - Y.*(G*drb) <= drs];
drcons = [drcons, 1 + Y.*(G*drb) - k*lambda <= drs];
drcons = [drcons, L*norm(sqrt(G)*drb, 2) <= lambda];
drfun = lambda*rho + 1/n*sum(drs);
drsol = optimize(drcons, drfun, opts);
drb = value(drb);
drsvm = toc;
plotsvm(Y, X, K, drb,'Distributionally Robust SVM', 3)
%% Solve and plot Online Distributionally Robust SVM
tic;
param.sig = sigma;
param.w = 0.25; 
param.a = 1;
param.c1 = 1.02;
param.c2 = 500;
y = [0, 0];
odra = [];
oca = [];
for i=1:n
    fprintf(' [%.2f %%] \n', i*100/n)
    param.beta = 0.8*exp(1-sqrt(i));
    param.xr = odra;
    data.X = X(i, :);
    data.Y = Y(i);
    data.iter = i;
    [odra, oca, y] = ODAA_ker(data, param, oca, y);
end
odrsvm = toc;
plotsvm(Y, X, K, odra, 'Online Distributionally Robust SVM')
% %% Calculate prediction
% EmpErr_OG = predict(X, Y, K, a);
% EmpErr_R = predict(X, Y, K, ra);
% EmpErr_DR = predict(X, Y, K, drb);
% EmpErr_ODR = predict(X, Y, K, odra);
% %% Output some numbers
% clc
% fprintf('Optimization method | Empirical | Opt. time |\n')
% fprintf('____________________|___________|___________|\n')
% fprintf('Original SVM        | %.2f %%   | %.2f s    |\n', EmpErr_OG, svm)
% fprintf('Robust SVM          | %.2f %%   | %.2f s    |\n', EmpErr_R, rsvm)
% fprintf('Distributional RSVM | %.2f %%   | %.2f s    |\n', EmpErr_DR, drsvm)
% fprintf('Online DRSVM        | %.2f %%   | %.2f s    |\n', EmpErr_ODR, odrsvm)
%% Predict function
function acc = predict(X, Y, K, alpha)
dim = size(alpha, 1);
np = size(X,1);
Yp = zeros(np, 1);
for q=1:np
    for q2=1:dim
        Yp(q) = Yp(q)+alpha(q2)*Y(q2)*K(X(q2,:), X(q, :));
    end
end
acc = sum(sign(Yp)==Y)/length(Y)*100;
end
%% Plot function 
function [] = plotsvm(Y, X, K, alpha, tstr, pind)
if exist('pind','var')
    subplot(2,2,pind)
end
n = 100;                            % Grid size
xmi = 1.1*min(min(X));             % Minimum X
xma = 1.1*max(max(X));             % Maximum X
Grid = linspace(xmi,xma,n);
f = zeros(100,100);
for i=1:length(alpha)
    for j=1:n
        for k=1:n
            f(j,k) = f(j,k) + alpha(i)*Y(i)*K([Grid(j) Grid(k)],X(i,:));
        end
    end
end
hyp = f >= 0;
mmin = abs(min(min(f))); mmax = max(max(f)); cmin = floor(50*mmin/(mmin+mmax)); cmax = ceil(50*mmax/(mmin+mmax));
cmap(1:cmin,:) = [linspace(0,1,cmin)' linspace(0,1,cmin)' ones(cmin,1)];
cmap(cmin+1:cmin+cmax,:) = [ones(cmax,1) linspace(1,0,cmax)' linspace(1,0,cmax)'];
image(Grid,Grid,f,'CDataMapping','scaled')
hold on
colormap(cmap)
contour(Grid,Grid,f,[0 0],'k-')
contour(Grid,Grid,f,[1 1],'r--')
contour(Grid,Grid,f,[-1 -1],'b--')
gscatter(X(:,2),X(:,1),Y,'br')
hold on
legend off
title(tstr)
figure
surf(f)
end


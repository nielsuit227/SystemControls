%%% Calculates the Support Vector Machine without L2 regularization! 
clear 
close all
clc
load svm_data
X = (X-mean(X))./sqrt(var(X));
n = 100;
% X = X(1:n, :);
% Y = Y(1:n);
%% Parameters
C = 1;
figure
%% Solve and plot OG SVM
tic;
opts = sdpsettings('verbose', 0, 'showprogress', 1, 'solver', 'linprog');
xi = sdpvar(n,1);
w = sdpvar(2,1);
b = sdpvar(1);
cons = [];
cons = [cons, xi >= 0];
cons = [cons, Y.*(X*w + b) >= 1 - xi];
fun = C * sum(xi);
sol = optimize(cons, fun, opts);
b = value(b);
w = value(w);
plotsvm(Y, X, w, b, 'Normal SVM', 1);
OGSVM = toc;
%% Solve and plot Robust SVM
tic;
opts = sdpsettings('verbose', 0, 'showprogress', 1, 'solver', 'gurobi');
rxi = sdpvar(n,1);
rw = sdpvar(2,1);
rb = sdpvar(1);
rcons = [];
rcons = [rcons, rxi >= 0];
rcons = [rcons, Y.*(X*rw + rb) >= 1 - rxi];
rfun = 1/2*norm(rw)^2 + C * sum(rxi);
rsol = optimize(rcons, rfun, opts);
rb = value(rb);
rw = value(rw);
plotsvm(Y, X, rw, rb, 'Robust SVM', 2);
RSVM = toc;
%% Solve and plot Distributionally Robust SVM (Peyman)
tic;
opts = sdpsettings('verbose', 1, 'showprogress', 1);
rho = 0.01;                    % Wasserstein radius (for L2 norm)
k = 0.05;                      % Trade-off between label & data uncertainty
drw = sdpvar(2, 1);  
drb = sdpvar(1, 1);
L = sdpvar(1, 1);
s = sdpvar(n, 1);
drcons = [];
drcons = [drcons, s >= 0];
drcons = [drcons, 1 - Y.*(X*drw + drb) <= s];
drcons = [drcons, 1 + Y.*(X*drw + drb) - k*L <= s];
drcons = [drcons, drw'*drw <= L];
drfun = L*rho + 1/n*sum(s);
drsol = optimize(drcons, drfun, opts);
drw = value(drw);
drb = value(drb);
plotsvm(Y, X, drw, drb, 'DRO SVM', 3)
DRSVM = toc;
%% Solve and plot Online Distributionally Robust SVM
tic;
param.xr = rand(1,2);
param.w = 0.1;
param.a = 1;
param.c1 = 1.02;
param.c2 = 50;
y = [0, 0];
odrw = [0.5, 0.5];
oca = [];
for i=1:n
    fprintf(' [%.2f %%] \n', i*100/n)
    param.beta = 0.9*exp(1-sqrt(i));
    param.xr = odrw;
    data.X = X(i,:);
    data.Y = Y(i);
    data.iter = i;
    [odrw, oca, y] = ODAA_lin(data, param, oca, y); 
end
plotsvm(Y, X, odrw', 0, 'Online Distributionally Robust SVM', 4)
ODRSVM = toc;
%% Calculate prediction
EmpErr_OG = sum(sign(X*w+b) == Y)*100/length(Y);
EmpErr_R =  sum(sign(X*rw+rb) == Y)*100/length(Y);
EmpErr_DR = sum(sign(X*drw+drb) == Y)*100/length(Y);
EmpErr_ODR = sum(sign(X*odrw') == Y)*100/length(Y);
%% Output some numbers
clc
fprintf('Optimization method | Empirical | Opt. time |\n')
fprintf('____________________|___________|___________|\n')
fprintf('Original SVM        | %.2f %%   | %.2f s    |\n', EmpErr_OG, OGSVM)
fprintf('Robust SVM          | %.2f %%   | %.2f s    |\n', EmpErr_R, RSVM)
fprintf('Distributional RSVM | %.2f %%   | %.2f s    |\n', EmpErr_DR, DRSVM)
fprintf('Online DRSVM        | %.2f %%   | %.2f s    |\n', EmpErr_ODR, ODRSVM)
%% Plot function
function [] = plotsvm(Y, X, w,b, tstr, pind)
n = 100;                            % Grid size
xmi = 1.1*min(min(X));             % Minimum X
xma = 1.1*max(max(X));             % Maximum X
Grid = linspace(xmi,xma,n);
f = zeros(100,100);
for i=1:n
    for j=1:n
        f(i,j) = w'*[Grid(i);Grid(j)] + b;
    end
end
hyp = f - b >= 0;
subplot(2,2, pind)
mmin = abs(min(min(f+b))); mmax = max(max(f+b)); cmin = floor(50*mmin/(mmin+mmax)); cmax = ceil(50*mmax/(mmin+mmax));
cmap(1:cmin,:) = [linspace(0,1,cmin)' linspace(0,1,cmin)' ones(cmin,1)];
cmap(cmin+1:cmin+cmax,:) = [ones(cmax,1) linspace(1,0,cmax)' linspace(1,0,cmax)'];
image(Grid,Grid,f+b,'CDataMapping','scaled')
hold on
colormap(cmap)
contour(Grid,Grid,f+b,[0 0],'k-')
contour(Grid,Grid,f+b,[1 1],'r--')
contour(Grid,Grid,f+b,[-1 -1],'b--')
gscatter(X(:,2),X(:,1),Y,'br')
hold on
legend off
title(tstr)
end


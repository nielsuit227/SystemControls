%% Clean sheet
clear
close all
clc
set(0, 'DefaultLineLineWidth', 2);
%% Global parameters
global eps mem tol eta
eta = 1;      % Learning rate
tol = 1e-3;     % Convergence tolerance
eps = 0.25;     % Forget threshold
mem = 300;      % Memory size
maxiter = 1000; % Maximum iterations
nplots = 10;     % Makes number of plots
%% SVM settings
sigma = 2;
C = 750;
K = @(X,Y) exp(-norm(X - Y)^2/(2*sigma^2));
%% Load data
load data2
X = (X - ones(size(X,1),1)*mean(X))./sqrt(var(X));
%% OSVM
z = 1;
for i = 1:maxiter
    Xc = X(i,:)'; Yc = Y(i);
    [alpha,b,XC,YC,g,S,E] = IDSVM(K,C,Xc,Yc,i);
    if z*maxiter/nplots == i
        z = z+1;
        visualize(XC,YC,alpha,b,i,X,Y,K,S,E)
    end       
end
%% Plot dataset
gscatter(X(1:maxiter,2),X(1:maxiter,1),Y(1:maxiter),'br')
%% Visualize grid
function [] = visualize(XC,YC,alpha,b,iter,X,Y,K,inds,inde)
global mem
n = 100;                            % Grid size
xmi = 1.1*min(min(XC));             % Minimum X
xma = 1.1*max(max(XC));             % Maximum X
Grid = linspace(xmi,xma,n);
f = zeros(100,100);
for i=1:length(alpha)
    for j=1:n
        for k=1:n
            f(j,k) = f(j,k) + alpha(i)*YC(i)*K([Grid(j) Grid(k)]',XC(:,i));
        end
    end
end
hyp = f + b >= 0;
figure
mmin = abs(floor(min(min(f+b)))); mmax = ceil(max(max(f+b)));
cmap(1:mmin,:) = [linspace(0,1,mmin)' linspace(0,1,mmin)' ones(mmin,1)];
cmap(mmin+1:mmin+mmax,:) = [ones(mmax,1) linspace(1,0,mmax)' linspace(1,0,mmax)'];
image(Grid,Grid,f+b,'CDataMapping','scaled')
hold on
colormap(cmap)
contour(Grid,Grid,f+b,[0 0],'k-')
contour(Grid,Grid,f+b,[1 1],'r--')
contour(Grid,Grid,f+b,[-1 -1],'b--')
hold on
% gscatter(X(:,2),X(:,1),Y,'br')
gscatter(XC(2,inds),XC(1,inds),YC(inds),'br','xx')
gscatter(XC(2,inde),XC(1,inde),YC(inde),'br','v^')
legend off
str = sprintf('IDSVM, %.0f SV, iteration %.0f',mem,iter);
title(str)
drawnow
end
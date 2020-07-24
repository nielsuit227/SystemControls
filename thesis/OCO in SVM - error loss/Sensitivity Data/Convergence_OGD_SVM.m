%%% Regularized Follow The Leader for Support Vector Machine with static memory.
%%% Selects n random datasamples and uses these to optimize the model based
%%% on the squared prediction error (simplified with tanh), regularized with 
%%% negative entropy. 
clear
close all
clc
set(0,'DefaultLineLineWidth',2);
%% load data
load data2
X = (X - ones(size(X,1),1)*mean(X))./sqrt(var(X));
[s,d] = size(X);
%% Define parameters
global print
print = 1;              % Whether or not to print during training/evaluation
n = 100;                % Datapoints
eta = 0.01;              % Learning rate  $$$ NEEDS DRASTIC OPTIMIZATION $$$
sigma = 2;              % Kernel width
C = 750;                 % Regularization term
tol = 0.01;             % Optimization tolerance
K = @(X,Y) exp(-diag((X-Y)*(X-Y)')/(2*sigma^2));
%% OCO with SVM
% Initalization of parameters and variables
count = 1;
for maxiter = logspace(1,3,100)
a = 0.1*ones(n,1); b = 0;
c = randi(s,n,1); XC = X(c,:); YC = Y(c);
sum_grad_a = zeros(n,1);
sum_grad_b = 0;
% Iterative loop (OGD)
tic;
for t = 1:maxiter
    Kt = K(XC,X(t,:));
    a = a - eta*(tanh(a'*(YC.*Kt) + b) - Y(t))*(1-(tanh(a'*(YC.*Kt) + b))^2)*(YC.*Kt);
    b = b - eta*(tanh(a'*(YC.*Kt) + b) - Y(t))*(1-(tanh(a'*(YC.*Kt) + b))^2);
    % Regularization projection
    a = max(min(a,C),0);
    % KKT projection
    a(YC==1) = a(YC==1)*sum(a)/2./sum(a(YC==1));
    a(YC==-1) = a(YC==-1)*sum(a)/2./sum(a(YC==-1));
    if print
        fprintf('[%.1f %%] Iteration %.0f trained\n',100*t/maxiter,t)
    end
end
fprintf('Training done\n')
train_time = toc;
%% Visualize
% visualize(XC,YC,a,b,K,X(1:10000,:),Y(1:10000))
%% Calculate accuracy
eval_n = 1000;          % Number of evaluations
[Yp,eval_time] = svm_predict(a,b,K,X(end-eval_n+1:end,:),XC,YC);
Accuracy(count) = 100*sum((sign(Yp)==Y(end-eval_n+1:end)))/eval_n;
count = count+1;
end
%% Summarize 
clc
fprintf('Support Vector Machine using Online Gradient Descent\n\n')
fprintf('Samples                    %.0f\n',maxiter)
fprintf('Multipliers                %.0f\n',n)
fprintf('Training time              %.1f s\n',train_time)
fprintf('Evaluation time            %.1f s\n',eval_time)
fprintf('Prediction Accuracy        %.2f %%\n',100*sum((sign(Yp)==Y(end-eval_n+1:end)))/eval_n)

%% Functions
function [] = visualize(XC,YC,alpha,b,K,X,Y)
n = 100;                            % Grid size
xmi = 1.1*min(min(X));             % Minimum X
xma = 1.1*max(max(X));             % Maximum X
Grid = linspace(xmi,xma,n);
f = zeros(100,100);
for i=1:length(alpha)
    for j=1:n
        for k=1:n
            f(j,k) = f(j,k) + alpha(i)*YC(i)*K([Grid(j) Grid(k)],XC(i,:));
        end
    end
end
hyp = f + b >= 0;
figure
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
gscatter(XC(:,2),XC(:,1),YC,'kk')
hold on
legend off
str = sprintf('OCO in SVM');
title(str)
drawnow
figure
surf(f+b)
title('Decision surface')
end
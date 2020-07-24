%%% Regularized Follow The Leader for Support Vector Machine with static memory.
%%% Selects n random datasamples and uses these to optimize the model based
%%% on the squared prediction error (simplified with tanh), regularized with 
%%% negative entropy. 
clear
close all
clc
set(0,'DefaultLineLineWidth',2);
%% load data
load train
X = train(2:end,3:end);
Y = train(2:end,2);
X = (X - ones(size(X,1),1)*mean(X))./sqrt(var(X));
[s,d] = size(X);
%% Define parameters
global print
print = 1;              % Whether or not to print during training/evaluation
n = 100;                % Datapoints
eta = 0.1;              % Learning rate  $$$ NEEDS DRASTIC OPTIMIZATION $$$
sigma = 1;              % Kernel width
C = 750;                % Regularization term
tol = 0.01;             % Optimization tolerance
K = @(X,Y) exp(-diag((X-Y)*(X-Y)')/(2*sigma^2));
%% OCO with SVM
% Initalization of parameters and variables
a = zeros(n,1); b = 0;
c = randi(s,n,1); 
XC = X(c,:); YC = Y(c);
sum_grad_a = zeros(n,1);
sum_grad_b = 0;
% Iterative loop (OGD)
tic;
for t = 1:maxiter
    Kt = K(XC,X(t,:));
    sgrad = (tanh(a'*(YC.*Kt)+b)-Y(t))*(1-(tanh(a'*(YC.*Kt))^2));
    sum_grad_a = sum_grad_a + eta*sgrad*(YC.*Kt);
    sum_grad_b = sum_grad_b + eta*sgrad;
    a = exp(-sum_grad_a - 1);
    b = exp(-sum_grad_b - 1);
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

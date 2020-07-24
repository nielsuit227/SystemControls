%%% Generate a dataset of n points, normally distributed on two inputs with function Y
%%% determining the area of +1. 
clear 
close all
clc
%% Settings
dim = 2;                    % Input dimension
int = 100;                  % Input interval
n = 500000;                 % Samples
dist = 'norm';              % Distribution, uni or norm
sig = 0.1;                  % Input noise
%% Inputs
switch dist
    case 'norm'
        mu = ones(2,1)*int/2;
        cov = int*[1 4/7;4/7 1];
        X = mvnrnd(mu,cov,n);
    case 'uni'
        X = randi(int,n,dim);
end
%% Output
f = @(X,Y) (X-50).^2 + (Y-50).^2 +(X-50).^3 + (X-50).^2.*(Y-20).^2;
Y = double(f(X(:,1),X(:,2))>50000);
Y(Y==0) = -1;
%% Add noise
X = X + sig*rand(n,2);
%% Plot
gscatter(X(:,1),X(:,2),Y)
save('data.mat','X','Y')
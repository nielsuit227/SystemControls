clear 
close all
clc
%% Optimization problem (convex)
% min x'*A*x + b'*x
% x in R2
% gradient is 2*x'A+b
A = random('norm',sqrt(5),sqrt(5), 2,2);
A = A*A';
b = random('norm',5,5, 2,1);                  
D = [5, 5; -5, -5];             % Domain
%% Startpoints
xfw = [5;5];        % Frank Wolfe
xgd = [5;5];        % Gradient Descent
xrl = [5;5];        % Regularized Follow The Leader

%% Optimization algo's
g = 0.01;           % Learning rate
k = 0;              % Iteration count (FWA)
while(1)
    % Gradient Descent
    xgd = xgd - g*(2*xgd'*A+b);
    xgd = min(max(xgd, D(2, :)'), D(1, :)');
    % Regularized Follow The Leader
    sgr = sgr + 2*xgr'*A+b;
    xrl = -0.5*sgr*g;
    xrl = min(max(xrl, D(2, :)'), D(1, :)');
    % Frank Wolfe Algorithm
    gfwa = 2/(k+2);
    
    
    
    
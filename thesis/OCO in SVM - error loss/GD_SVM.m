%%% Takes data from 'Data_Synthesis.m' and applies SVM. Hyperparamters are
%%% tuned for specific dataset. Uses Sequential Minimal Optimization.
%%% Dataset is split, first n samples for training. The whole dataset is
%%% used for generalization error. SVM uses RBF kernel. The function SvM
%%% updates all lagrange multipliers till convergence according to Platts
%%% SMO paper from 1998. 
%%% Output visualizes the hyperplane and all samples. Incorrectly
%%% classified samples are black. 
clear
close all
clc
set(0, 'DefaultLineLineWidth', 2);
%%  Load data
load('data.mat')
%% PARAMETER - Training samples
n = 250;        % Lagrange multipliers
%% Organize training data
X_t = X(1:n,:); Y_t = Y(1:n,:);
%% PARAMETERS - SVM settings
C = 1000;           % 1/C = regularization constant (l1 is implemented)
sig = 0.8;          % Variance of RBF kernel
% Kernel - RBF
K = @(X,Y) exp(-(X-Y)'*(X-Y)/(2*sig^2));
% Solve SVM. 
% tic;
[a] = SvM(C,K,X_t,Y_t);
% toc;
%% Show hyperplane
visualize(a,sig,X_t,Y_t)
%% Determine generalization error
Yp = eval_sample(a,K,X,X_t,Y_t);
fprintf('Generalization error %.2f %%\n',sum(sign(Yp)' ~= Y)/length(Y)*100)
hold on
Z = sign(Yp)'~=Y;
gscatter(X(Z,1),X(Z,2),Yp(Z),'kk','**') % Plots all error in black.
legend off
figure
gscatter(X_t(:,1),X_t(:,2),a)
legend off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% ALL NECESSARY FUNCTIONS %%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Complete SVM function (using SMO)
function [a] = SvM(C,K,X,Y)
%% Initialize Kernel function
G = gram(K,X,X);
%% Initialize vectors
n = size(X,1);
a = zeros(n,1);
nznc = ones(n,1);       % Vector that tracks non bounded (0,C) multipliers
nc = 0;                 % Numbers changed tracker
exall = 1;              % Flag to examine all multipliers
itmax = 1;              % Flag that max iterations is reached
c = 0;                  % Iteration counter
E = ((a.*Y)'*G)' - Y;   % Initial error
%% Main loop (outer loop for first Lagrangian selection)
% So first optimization variable is picked based upon straightforward
% things. We start off by examining all. Then after one round we optimize
% those that are not at the boundaries as they are more likely to make a
% nonzero update step. We keep doing so until there is nothing left, after which we
% check all variables again. Once we check them all and none are updated,
% the first loop closes. 
while((nc>0 || exall) && itmax)
    nc = 0;
    nznc = (a~=0).*(a~=C);
    n = length(nznc);
    if(exall)
        for i=1:n
            [a,E,ac] = ex(X,Y,i,a,G,C,E);
            nc = nc + ac;
        end
    else
        for i=nznc'.*linspace(1,n,n)
            if i == 0
                continue
            end                
            [a,E,ac] = ex(X,Y,i,a,G,C,E);
            nc = nc + ac;
        end
    end
    if exall == 1
        exall = 0;
    elseif nc == 0
        exall = 1;
    end
    c = c +1;
    fprintf('Iteration %.0f, %.0f alphas changed\n',c,nc)
    if c>100
        warning('Hyperparameters not converged')
        itmax = 0;
    end
end
%% Second loop (inner loop for second Lagrangian selection)
% The second loop checks the KKT conditions first. If they're satisfied for
% point i, it will simply not update. Now if the conditions aren't met,
% the algorithm will first update i towards the point with the largest
% error difference (used in update step). Afterwards it will update i to
% all nonbounded multipliers j. Afterwards it will update towards all other
% multipliers. 
function [a,E,nc] = ex(X,Y,i,a,G,C,E)
nc = 0;
E = E;
a = a;
nznc = (a~=0).*(a~=C);
n = length(Y);
% KKT Conditions
Ri = (a.*Y)'*G(:,i);
if (a(i) == 0 && Ri*Y(i) < 1) || (a(i)<=C && Ri*Y(i) ~= 1) || (a(i) == C && Ri*Y(i) > 1)
    % Best possible step (based on error vector)
    [~,j] = min(sign(E(i))*E);
    [a,E,ac] = Update(X,Y,i,j,a,G,C);
    nc = nc + ac;
    for j=nznc'.*linspace(1,n,n)
        if j == 0
            continue
        end
        [a,E,ac] = Update(X,Y,i,j,a,G,C);
        nc = nc + ac;
    end
    for j=[1:i-1,i+1:n]
        [a,E,ac] = Update(X,Y,i,j,a,G,C);
        nc = nc + ac;
    end        
end
end
%% Update loop
% Calculates the optimization analytically. The bounds from the constraints
% require a min and a max. Newton's method for optimization is used, the
% first and second derivative of the objective is used to update the
% multipliers. Checks for bounds and numerical issues are implemented.
function [a,E,ac] = Update(X,Y,i,j,a,G,C)
tol = 1e-3;                         % Update tolerance
E = ((a.*Y)'*G)' - Y;               % Error vector
a=a;                                % Loading multipliers
ac = 0;                             % Alphas changed tracker
nznc = (a~=0).*(a~=C);              % Binary vector whether multiplier is bounded
% Calculate errors
Ej = (a.*Y)'*G(:,j) - Y(j);         % Error for multiplier i
Ei = (a.*Y)'*G(:,i) - Y(i);         % Error for multiplier j 
% Save data - needed in cache
a_ihold = a(i);             
a_jhold = a(j);
% Calculate bounds (come from diagonal (a_i Y_i + a_j Y_j = constant))
if Y(i) ~= Y(j)
    L = max(0,a(j)-a(i));
    H=min(C,C+a(j)-a(i));
else
    L=max(0,a(i)+a(j)-C);
    H=min(C,a(i)+a(j));
end
% If singular then skip
if L==H
    return
end
% Second derivative obj fun
eta = 2*G(i,j) -G(j,j) - G(i,i);
% For positive values we don't improve (Newton's method for optimization)
% There is a fancy method that can still find small improvement, but for
% now not worth the effort. 
if eta >= 0
    return
end
% New Lagrange Multiplier alpha_j
a(j) = a(j) - Y(j)*(Ei-Ej)/eta;
% Check for bounds and correct if necessary
if a(j) > H
    a(j) = H;
elseif a(j) < L
    a(j) = L;
end
% Check for numerical inaccuracies while converged
if norm(a(j)-a_jhold) < tol
    return
end
% Update Lagrange Multiplier alpha_i
a(i)=a(i) + Y(i)*Y(j)*(a_jhold-a(j));
% Classification errors
E = ((a.*Y)'*G)' - Y;
ac = 1;                     % As we haven't hit a return we actually updated one duo of multipliers
end
%% Gram matrix
% Simple function to calculate the gram matrix. 
function [G] = gram(K,X,Y)
n = size(X,1);
m = size(Y,1);
for i=1:n
    for j=1:m
        G(i,j) = K(X(i,:)',Y(j,:)');
    end
end
end
%% Calculate Empirical error and return it
Emp_Err = sum(Y ~= sign((a.*Y)'*G)');
fprintf('Empirical error %.2f %%\n',Emp_Err/n*100)
end     
%% Visualization
function [] = visualize(a,sig,Xt,Yt)
% Implement kernel
K = @(X,Y) exp(-(X-Y)'*(X-Y)/(2*sig^2));
% Set up grid (100x100) on a x1*x2 field
n = 100;
Gr = linspace(0,n,n);
[Y,Z] = meshgrid(Gr,Gr);
Gr = [Y(:),Z(:)];
% Size
nt = size(Xt,1);
np = size(Gr,1);
% Gram matrix and prediction
for i=1:nt
    for j=1:np
        G(i,j) = K(Xt(i,:)',Gr(j,:)');
    end
end
Yp = ((a.*Yt)'*G)';
Yp = reshape(sign(Yp),n,n);
imagesc(Yp)
% gscatter(Gr(:,1),Gr(:,2),sign(Yp))
hold on
gscatter(Xt(:,1),Xt(:,2),Yt)
title('Offline SVM')

            
end

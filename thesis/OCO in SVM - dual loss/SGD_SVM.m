%%% Takes data from 'Data_Synthesis.m' and applies SVM in an online manner.
%%% Hyperparameters are tuned for offline SVM on the specific dataset. Uses
%%% the theory of Sequential Minimal Optimization by Platt 1998, but does
%%% not run iteratively until convergence. Instead it runs once for each
%%% new available datapoint. Different forget algorithms can be
%%% implemented. SVM uses RBF Kernel. Output visualizes the hyperplane and
%%% all samples. Incorrect classified samples are black. 
clear
clc
set(0,'DefaultLineLineWidth',2);
%% load data
load('data.mat')
%% PARAMETERS - Training samples
n = 250;            % Lagrange multipliers
%% PARAMETERS - SVM Settigns
C = 1000;           % 1/C = regularization constant (l1 is implemented)
sig = 0.4;          % Variance of RBF kernel
% Kernel
K = @(X,Y) exp(-(X-Y)'*(X-Y)/(2*sig^2));
%% Online optimization
% Each iteration a new datapoint is added. The necessary data is stored in a
% persistent in the optimization function. Stores maximum n support
% vectors. i is iteration count, necessary for initialization of
% persistents. Forget algorithm is adjustable within function.
a = [];         % Initialize Lagrange multipliers
for i=1:size(X,1)
%     tic;
    [a,Xt,Yt] = OCO_SVM(K,C,X(i,:),Y(i),n,i);
%     toc;
end
%% Show hyperplane
visualize(a,sig,Xt,Yt)
%% Determine global error
Yp = eval_sample(a,K,X,Xt,Yt);
fprintf('Generalization error %.2f %%\n',sum(sign(Yp)' ~= Y)/length(Y)*100)
hold on
Z = sign(Yp)'~=Y;
gscatter(X(Z,1),X(Z,2),Yp(Z),'kk','**')
legend off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% ALL NECESSARY FUNCTIONS %%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Online Convex Optimization for Support Vector Machine
function [an,Xt,Yt] = OCO_SVM(K,C,Xn,Yn,n,i)
%%% a is required as input and also an output as it will be updated. The
%%% kernel function and a new datapoint are necessary to update. In order
%%% to have a tractable algorithm, datapoints will be forgotten. 
% Few forget algorithm options. 1) Last datapoint, 2) smalles last point.
%% Initialize data
persistent a X Y;           % Dynamic training dataset
ac = 0;                     % Alpha's changed tracker
% Initialize data for first iteration (clear persistents and output)
if i == 1                   
    X = Xn;
    Y = Yn;
    a = 0;
    an = a;
    Xt = X;
    Yt = Y;
    return
end
% Remove one datapoint to make space for a new point.
if size(X,1) == n
    % Either 'smallest' or 'last' for now. Smallest removes the smallest
    % multiplier which does not add any information to the hyperplane. In
    % case of multiple non-support vectors it will chose the oldest
    % datapoint. 
    % Last simply choses to forget the oldest datapoint. 
    [a,X,Y] = forget(a,X,Y,'smallest');     
end
% Add new sample
X = [X;Xn];
Y = [Y;Yn];
a = [a;0];
%% Determine Gram matrix
G = gram(K,X,X);        % Bit stupid, but during this function, n is changed to dataset size.
%% Main loop
% Just a single iteration for the last datapoint. It is updated against
% largest gradient. Afterwards against all non-bounded alphas and
% afterwards against all multipliers.
Ri = (a.*Y)'*G(:,n);        % Prediction of new sample
% Check KKT
if (a(n) == 0 && Ri*Y(n) < 1) || (a(n)<=C && Ri*Y(n) ~= 1) || (a(n) == C && Ri*Y(n) > 1)
    % First optimize largest error difference (largest gradient)
    E = ((a.*Y)'*G)' - Y;               % Error vector
    [~,j] = min(sign(E(n))*E);          % Select largest |Ei - Ej|
    [a,nc] = update(G,Y,n,j,a,C);       % And take a step
    ac = ac + nc;                       % Track alphas changed
    % Then optimize all non-bounded multipliers (0,C)
    nznc = (a~=0).*(a~=C);              % Nonbounded vector (binary)
    for j = nznc'.*linspace(1,n,n)
        if j == 0                       % j returns zero if the multiplier is bounded, ofcourse this has to be skipped.
            continue
        end
        [a,nc] = update(G,Y,n,j,a,C);   % Take step
        ac = ac + nc;                   % And track changes
    end
    % Then optimize over all multipliers
    for j = 1:n-1
        [a,nc] = update(G,Y,n,j,a,C);
        ac = ac + nc;
    end
end
%% Output persistents
an = a;
Xt = X;
Yt = Y;
fprintf('Iteration %.0f, %.0f alphas changed \n',i,ac)
%% Forget algorithm
% Two options, smallest or last. Smallest finds the least important support
% vector. In case of multiple non-support vectors, the oldest is picked for
% replacement. 
% Last simply removes the oldest datapoint.
function [a,X,Y] = forget(a,X,Y,algo)
% Only one needs to be forgotten to make space for new
% multiplier.
switch algo
    case 'smallest'
        [~,z] = min(a);
%         if z == size(a,1);
%             warning('Last value selected')
%         end
        a(z) = [];
        X(z,:) = [];
        Y(z) = [];
    case 'last'
        a(1) = [];
        X(1,:) = [];
        Y(1) = [];
    otherwise
        error('Forget algorithm not implemented')
end
end
%% Gram matrix
function [G] = gram(K,X,Y)
n = size(X,1);
m = size(Y,1);
for ii=1:n
    for j=1:m
        G(ii,j) = K(X(ii,:)',Y(j,:)');
    end
end
end
%% Update algorithm
function [a,nc] = update(G,Y,i,j,a,C)
tol = 1e-3;
nc = 0;
% Calculate errors
Ej = (a.*Y)'*G(:,j) - Y(j);
Ei = (a.*Y)'*G(:,i) - Y(i);
% Save data
a_ihold = a(i);
a_jhold = a(j);
% Calculate bounds
if Y(i) ~= Y(j)
    L = max(0,a(j)-a(i));
    H=min(C,C+a(j)-a(i));
else
    L=max(0,a(i)+a(j)-C);
    H=min(C,a(i)+a(j));
end
% if singular than skip
if L==H
%     warning('Equal bounds')
    return
end
% second derivative obj fun
eta = 2*G(i,j) -G(j,j) - G(i,i);
% if positive we don't improve (Newton's method?)
if eta >= 0
%     warning('Positive second derivative - No improvement')
    return
end
% New Lagrange Multiplier alpha_j
a(j) = a(j) - Y(j)*(Ei-Ej)/eta;
% Check for bounds
if a(j) > H
    a(j) = H;
elseif a(j) < L
    a(j) = L;
end
% Check for numerical inaccuracies while converged
if norm(a(j)-a_jhold) < tol
%     warning('Numerical inaccurate update')
    return
end
% Update Lagrange Multiplier alpha_i
a(i)=a(i) + Y(i)*Y(j)*(a_jhold-a(j));
% Classification errors
E = ((a.*Y)'*G)' - Y;
nc = 1;
end


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
title('Online SVM')

            
end

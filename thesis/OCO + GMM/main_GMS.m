clear 
close all
clc
load data
global vis print save
save = 1;                   % Saves certain optimization variables for analysis
print = 1;                  % Optimization progress
vis = 0;                    % Selection process (intensive)
%% Initalization 
n = 100;                    % Multipliers
eta = 0.1;                  % Learning rate
sigma = 1;                  % Kernel width
C = 1;                      % L1 Regularization of dual (not really used if above 5)
tol = 0.01;                 % Convergence tolerance
% Kernel function (RBF)
K = @(X,Y) exp(-diag((X-Y)*(X-Y)')/(2*sigma^2));
% Data sizes
selsize = 500;             % Selection dataset
maxiter = 50000;           % Online iterations
eval_n = 1000;             % Number of evaluations (for prediction accuracy)
% Initialize RFTL
a = zeros(n,1);
b = 0;
sum_grad_a = zeros(n,1);
sum_grad_b = 0;
%% Select optimal data representation
X = (X-mean(X))./sqrt(var(X));              % Normalize data
% Select data representation using Gaussian Mixture Model
Xsel = X(1:selsize,:); Ysel = Y(1:selsize);
tic; [XC,YC,sig] = GMMS_I(Xsel,Ysel,n); selection_time = toc;
%% On the fly prep
mem.out = [];           % Memory for outliers
mem.his = [XC YC];      % Memory for n last datapoints
th = 0.5;               % Probability treshold for memory
%% OCO in SVM
tic;
for t = 1:maxiter
    %% RFTL
    Kt = K(XC,X(t,:));
    sgrad = (tanh(a'*(YC.*Kt)+b)-Y(t))*(1-(tanh(a'*(YC.*Kt))^2));
    sum_grad_a = sum_grad_a + eta*sgrad*(YC.*Kt);
    sum_grad_b = sum_grad_b + eta*sgrad;
    a = exp(-sum_grad_a - 1);
    b = exp(-sum_grad_b - 1);
    a = max(min(a,C),0);
    a(YC==1) = a(YC==1)*sum(a)/2./sum(a(YC==1));
    a(YC==-1) = a(YC==-1)*sum(a)/2./sum(a(YC==-1));
    %% Check new datapoint
    if Y(t) == 1
        p = diag(exp(-1/2*(X(t,:)-XC(YC==1,:))*(X(t,:)-XC(YC==1,:))'));
        if ~any(p>th)
            mem.out = [mem.out; X(t,:) Y(t)];
        end            
    else
        p = diag(exp(-1/2*(X(t,:)-XC(YC==-1,:))*(X(t,:)-XC(YC==-1,:))'));
        if ~any(p>th)
            mem.out = [mem.out; X(t,:) Y(t)];
        end
    end
    if size(mem.out,1) > selsize
        fprintf('\n\nUpdating data representation.\n\n')
        % update data representation and continue updating alpha
        Xsel = [mem.his(:,1:2);mem.out(:,1:2)]; Ysel = [mem.his(:,3);mem.out(:,3)];
        [XC,YC,sig] = GMMS_I(Xsel,Ysel,n);
        a = zeros(n,1);
        mem.out = [];
    end
    % Put last selsize datapoints in buffer for updated representation
    mem.his(1,:) = [];
    mem.his = [mem.his; X(t,:), Y(t)];
    %% Print
    if print
        fprintf('[%.1f %%] Iteration %.0f trained, %.0f outliers \n',100*t/maxiter,t,size(mem.out,1))
    end
    if save
        mem.a(:,t) = a;
        mem.outsize(t) = size(mem.out,1);
    end
end
fprintf('Training done\n')
train_time = toc;
%% Visualize
Visualize_SVM(XC,YC,a,b,K,X(1:1000,:),Y(1:1000))
%% Calculate accuracy
[Yp,eval_time] = svm_predict(a,b,K,X(end-eval_n+1:end,:),XC,YC,1);
if print
    c = randi(n,10,1);
    figure
    for i = 1:10
        plot(mem.a(c(i),:))
        hold on
    end
    title('Convergence of multipliers')
    legend off
end
%% Summarize 
clc
fprintf('Support Vector Machine using Regularized Follow The Leader\n\n')
fprintf('Samples                    %.0f\n',maxiter)
fprintf('Multipliers                %.0f\n',n)
fprintf('Training time              %.1f s\n',train_time)
fprintf('Evaluation time            %.1f s\n',eval_time)
fprintf('Selection time             %.1f s\n',selection_time)
fprintf('Prediction Accuracy        %.2f %%\n',100*sum((sign(Yp)==Y(end-eval_n+1:end)))/eval_n)


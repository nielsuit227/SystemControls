%%% Script that makes a certain prediction on bank stuff. As the data is
%%% quite high dimensional firstly supervised LDA is used for dimension
%%% reduction. Afterwards data is fitted with a GMM and updated using
%%% online learning in SVM. 
clear
close all
clc
load bankaddfull                            % Load data
X = (X-mean(X))./sqrt(var(X));              % Normalize data
[n,m] = size(X);                            % Data size
idx = randperm(n);                          % Randomize order
Y = Y(idx); X = X(idx,:);
%% Pipeline options
global print conv store vis vis2
print = 1;              % Show progress
conv = 1;               % Save convergence
store = 0;              % Store sgrad & representation 
vis = 0;                % Show GMM generation
vis2 = 1;               % Show result for 2D
%% Linear Discriminant Analysis
% Initialize
mup = ones(1,m);
mun = ones(1,m);
s_w = zeros(m);
np = sum(Y(Y==1)); nn = -sum(Y(Y==-1));
% Calculate class means
mup = mean(X(Y==1,:));
mun = mean(X(Y==-1,:));
% Calculate covariance
for i = 1:n
    if Y(i) == 1
        s_w = s_w + (X(i,:) - mup)'*(X(i,:)-mup);
    else
        s_w = s_w + (X(i,:) - mun)'*(X(i,:)-mun);
    end
end
mu = mean(X);
s_b = np*(mup-mu)'*(mup-mu) + nn*(mun-mu)'*(mun-mu);
[e,v] = eig(s_w\s_b); v = diag(v);
figure; semilogy(abs(v));
D = 6;
G = e(:,1:D);
X = abs(X*G);
clear e i mu mun mup s_b s_w nn np
%% Gaussian Mixture Model
if store
    load data_repr
else
    selsize = 5000;             % Datapoints taken for GMM
    mp = 150;                   % Number of Multipliers
    Xp = X(Y==1,:); Xn = X(Y==-1,:); Xsel = [Xn(1:selsize/2,:);Xp(1:selsize/2,:)];
    Ysel = [-1*ones(selsize/2,1);ones(selsize/2,1)];
    [XC,YC] = GMMS_I(Xsel,Ysel,mp);
    save('data_repr.mat','XC','YC','mp')
end
if D == 2 && vis2 == 1
    figure
    gscatter(X(:,1),X(:,2),Y)
    hold on
    gscatter(XC(:,1),XC(:,2),YC,'kk')
end
%% Support Vector Machine
if ~print
    fprintf('Optimizing multipliers')
end
epoch = 2;
eta = 0.075;                % Learning rate
sigma = 0.5;                % Kernel width
C = 50;                     % L1 Regularization term
th = 0.5;                   % Probability ThresHold for outliers
% RBF Kernel
K = @(X,Y) exp(-diag((X-Y)*(X-Y)')/(2*sigma^2));
% Initialize
a = zeros(mp,1);
b = 0;
sgrad_a = zeros(mp,1);
sgrad_b = 0;
if store
    load sgrad
end
mem.out = [];
mem.his = [Xsel Ysel];
ep = 0;
% Online Convex Optimization - Regularized Follow The Leader
while ep < epoch
    % Randomize rows
    idx = randperm(n);
    Y = Y(idx); X = X(idx,:);
    for t = 1:n
        % Update multipliers
        Kt = K(XC,X(t,:));
        sgrad = (tanh(a'*(YC.*Kt)+b)-Y(t))*(1-(tanh(a'*(YC.*Kt))^2));
        sgrad_a = sgrad_a + eta/(ep+1)*sgrad*(YC.*Kt);
        sgrad_b = sgrad_b + eta/(ep+1)*sgrad;
        a = exp(-sgrad_a - 1);
        b = exp(-sgrad_b - 1);
        % Project onto convex action space
        a = max(min(a,C),0);
        a(YC==1) = a(YC==1)*sum(a)/2./sum(a(YC==1));
        a(YC==-1) = a(YC==-1)*sum(a)/2./sum(a(YC==-1));
        % Check new datapoint for representation
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
            [XC,YC] = GMMS_I(Xsel,Ysel,n);
            a = zeros(n,1);
            mem.out = [];
            end
        % Put last selsize datapoints in buffer for updated representation
        mem.his(1,:) = [];      
        mem.his = [mem.his; X(t,:), Y(t)];
        if print
            fprintf('[%.1f %%] Iteration %.0f trained, %.0f outliers \n',100*(t+ep*n)/n/epoch,t+n*ep,size(mem.out,1))
        end
        if conv
            mem.a(:,t+ep*n) = a;
            mem.kt(:,t+ep*n) = Kt;
        end
    end
    ep = ep+1;
end
% Plot convergence
if conv
    plot(mem.a(1,:));
    hold on
    plot(mem.a(10,:));
    plot(mem.a(mp,:));
end
% Save gradient sum for next iteration
save('sgrad.mat','sgrad_a','sgrad_b')
%% Prediction
[Ypemp,~] = svm_predict(a,b,K,X,XC,YC,0);
load bankadd
Xval = (Xval-mean(Xval))./sqrt(var(Xval));
[Ypgen,~] = svm_predict(a,b,K,Xval*G,XC,YC,0);
% ROC calculation
[AUCx2,AUCy2,~,AUCgen] = perfcurve(Yval,Ypgen,1);
[AUCx1,AUCy1,T,AUCemp] = perfcurve(Y,Ypemp,1);
% Visualize
figure
plot(AUCx1,AUCy1)
hold on; 
plot(AUCx2,AUCy2); 
plot([0,1],[0,1],'k')
legend('Empirical','Generalization')
clc
fprintf('*** RFTL SVM with GMM & LDA ***\n\n')
fprintf('LDA dimension:             %.0f\n',D)
fprintf('LDA weight:                %.2e \n',abs(v(D)))
fprintf('GMM selection size:        %.0f\n',selsize)
fprintf('SVM multipliers:           %.0f\n',mp)
fprintf('SVM kernel width:          %.2f\n',sigma)
fprintf('SVM regularization:        %.2f\n',C)
fprintf('RFTL epochs:               %.0f\n',epoch)
fprintf('RFTL learning rate:        %.2f\n',eta)
fprintf('\nAverage kernel:            %.2f\n',mean(mean(mem.kt)))
fprintf('Average multiplier:        %.2f\n',mean(mean(mem.a)))
fprintf('\n\nEmpirical error:           %.2f\n',100*sum(sign(Ypemp)~=Y)/length(Y))
fprintf('Generalization error:      %.2f\n',100*sum(sign(Ypgen)~=Yval)/length(Yval))
fprintf('AUC training data:         %.3f\n',AUCemp)
fprintf('AUC validation data:       %.3f\n',AUCgen)




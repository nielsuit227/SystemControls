clear
close all
clc
load irisdata
fprintf('*** Multiclass RFTL SVM ***\n\n')
X = (X-mean(X))./sqrt(var(X));              % Normalize data
[n,m] = size(X);                            % Data size
idx = randperm(n);                          % Randomize order
Y = Y(idx); X = X(idx,:);
%% Pipeline options

%% Split training / validation data
t = ceil(2/3*n);
Xt = X(1:t,:); Yt = Y(1:t);
Xv = X(t+1:end,:); Yv = Y(t+1:end);
%% Support Vector Machine
global epoch eta sigma C K print mp
print = 0;

mp = 40;
epoch = 5;
eta = 0.15;                % Learning rate
sigma = 2;                  % Kernel width
C = 50;                     % L1 Regularization term
% RBF Kernel
K = @(X,Y) exp(-diag((X-Y)*(X-Y)')/(2*sigma^2));
%% Classify Y == 1
Y1=Yt; Y1(Y1~=1)=-1;Y1(Y1==1)=1;
[a1,b1,K1,XC1,YC1,predacc] = RFTL_pipe(Xt,Y1);
fprintf('Prediction Accuracy of class 1:    %.2f\n',predacc)
%% Classify Y == 2
Y2=Yt; Y2(Y2~=2)=-1;Y2(Y2==2)=1;
[a2,b2,K2,XC2,YC2,predacc] = RFTL_pipe(Xt,Y2);
fprintf('Prediction Accuracy of class 2:    %.2f\n',predacc)
%% Classify Y == 3
Y3=Yt; Y3(Y3~=3)=-1;Y3(Y3==3)=1;
[a3,b3,K3,XC3,YC3,predacc] = RFTL_pipe(Xt,Y3);
fprintf('Prediction Accuracy of class 3:    %.2f\n',predacc)

%% Validation
[Yp1] = svm_predict(a1,b1,K1,Xv,XC1,YC1,0);
[Yp2] = svm_predict(a2,b2,K2,Xv,XC2,YC2,0);
[Yp3] = svm_predict(a3,b3,K3,Xv,XC3,YC3,0);
[~,Yp] = max([Yp1 Yp2 Yp3]');
gen_acc = sum(Yp'==Yv)*100/length(Yv);

fprintf('\n\nMulticlass Generalization Accuracy:       %.2f\n',gen_acc)










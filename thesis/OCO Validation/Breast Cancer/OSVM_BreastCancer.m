clear
close all
clc
load bcdata
%% Preprocess
X = (X-mean(X))./sqrt(var(X));          % Zero mean, unity variance
[n,m] = size(X);                        % Note size
t = floor(2/3*n);
Yt = Y(1:t); Xt = X(1:t,:);             % Training data
Yv = Y(t+1:end); Xv = X(t+1:end,:);     % Validation data
[n,m] = size(Xt);                       % Overwrite size
clear X Y t idx
%% Settings
global print mp epoch C eta sigma
% Parameters
sig = 0.5;
mp = 50;
epoch = 5;
C = 50;
eta = 0.075;
sigma = sig;
% Output options
print = 0;
%% Training - RFTL SVM
fprintf('*** Starting online SVM ***\n\n')
[a,b,G,K,XC,YC,predacc] = RFTL_pipe(Xt,Yt);
fprintf('Empirical Accuracy:        %.2f\n\n',predacc)

%% Validation
[Yp] = svm_predict(a,b,K,Xv*G,XC,YC,0);
gen_acc = sum(sign(Yp)==Yv)*100/length(Yv);
fprintf('Generalization Accuracy:   %.2f\n\n',gen_acc)







%%% Script that classifies potential car buys into 'unaccessible',
%%% 'accessible', 'good' and 'very good'. 
clear
close all
clc
load cardata
%% Preprocess
X = (X-mean(X))./sqrt(var(X));          % Zero mean, unity variance
[n,m] = size(X);                        % Note size
t = floor(2/3*n);
Yt = Y(1:t); Xt = X(1:t,:);             % Training data
Yv = Y(t+1:end); Xv = X(t+1:end,:);     % Validation data
[n,m] = size(Xt);                       % Overwrite size
clear X Y t idx
%% Settings
global print gscat vis mp epoch C eta sigma
% Parameters
sig = 0.5;
mp = 50;
epoch = 1;
C = 50;
eta = 0.075;
sigma = sig;
% Output options
print = 0;
gscat = 0;
vis = 0;
%% Intro optimization
fprintf('*** Starting online SVM ***')
fprintf('\n\nEmpirical error:          \n')
%% Classify 'very good' (Y==3)
cache.Yt = Yt;
Yt(Yt~=3)= -1; Yt(Yt==3)= 1;                % Switch labels for vgood
[a3,b3,K3,XC3,YC3,predacc] = RFTL_pipe(Xt,Yt);    % Determine multiplier 
cache.sig3 = sigma; sigma = sig;
fprintf('Classified very good cars, pred. acc.      =    %.2f\n',predacc)
%% Classify 'good' (Y==2)
Yt = cache.Yt;
Yt(Yt~=2) = -1; Yt(Yt==2)=1;                % Switch labels
[a2,b2,K2,XC2,YC2,predacc] = RFTL_pipe(Xt,Yt);    % Determine multipliers
cache.sig2 = sigma; sigma = sig;
fprintf('Classified very good, pred. acc.           =    %.2f\n',predacc)
%% Classify 'acceptable' (Y==1)
Yt = cache.Yt;
Yt(Yt~=1) = -1; Yt(Yt==1)=1;                % Switch labels
[a1,b1,K1,XC1,YC1,predacc] = RFTL_pipe(Xt,Yt);    % Determine multipliers
cache.sig1 = sigma; sigma = sig;
fprintf('Classified acceptable cars, pred. acc.     =    %.2f\n',predacc)
%% Classify 'unacceptable' (Y==0)
Yt = cache.Yt;
Yt(Yt~=0) = -1; Yt(Yt==0)=1;                % Switch labels
[a0,b0,K0,XC0,YC0,predacc] = RFTL_pipe(Xt,Yt);    % Determine multipliers
cache.sig0 = sigma; sigma = sig;
fprintf('Classified unacceptable cars, pred. acc.   =    %.2f\n',predacc)
%% Validate
[Yp3] = svm_predict(a3,b3,K3,Xv,XC3,YC3);
[Yp2] = svm_predict(a2,b2,K2,Xv,XC2,YC2);
[Yp1] = svm_predict(a1,b1,K1,Xv,XC1,YC1);
[Yp0] = svm_predict(a0,b0,K0,Xv,XC0,YC0);
[~,Yp] = max([Yp0 Yp1 Yp2 Yp3]');
pred_acc = sum(Yp'==Yv)*100/length(Yv);

fprintf('*** Multiclass RFTL SVM ***\n\n')
fprintf('SVM multipliers:               %.0f\n',mp)
fprintf('SVM kernel width 0:            %.2f\n',cache.sig0)
fprintf('SVM kernel width 1:            %.2f\n',cache.sig1)
fprintf('SVM kernel width 2:            %.2f\n',cache.sig2)
fprintf('SVM kernel width 3:            %.2f\n',cache.sig3)
fprintf('SVM regularization:            %.2f\n',C)
fprintf('RFTL epochs:                   %.0f\n',epoch)
fprintf('RFTL learning rate:            %.4f\n\n',eta)
fprintf('Multiclass gen. acc.:          %.2f\n',predacc)






function [Yp,eval_time] = svm_predict(a,b,K,X_p,X_t,Y_t,print)
% Makes prediction on a trained SVM. 
%
% Global  Print  Will show progress
%
% Input   a:     Lagrange multipliers
%         b:     Bias
%         K:     Kernel function
%         X_p:   Prediction data
%         X_t:   Training data
%         Y_t:   Training labels
%         print: Binary variable whether to print progress
%
% Output  Y_p:   Prediction
%
if nargin == 6
    print = 0;
end
np = size(X_p,1);
nt = size(X_t,1);
Yp = zeros(np,1);
tic
for i=1:np
    G = zeros(nt,1);
    for j=1:nt
        G(j) = K(X_p(i,:),X_t(j,:));
    end
    Yp(i) = real(((a.*Y_t)'*G)+b)     ;
    if print
        fprintf('[%.1f %%] Iteration %.0f predicted\n',100*i/np,i)
    end
end
eval_time = toc;
end
function [a,b,K,XC,YC,predacc] = RFTL_pipe(Xt,Yt)
% Fully automated LDA, GMM and RFTL SVM. Solely returns multipliers. 
global print mp epoch C eta sigma
[n,m] = size(Xt);
%% GMM
idx = randperm(n); idx = idx(1:mp);
XC = Xt(idx,:); YC = Yt(idx);
%% Support Vector Machine
% epoch = 5;                  % Loops over data
% eta = 0.075;                % Learning rate
% sigma = 0.5;                % Kernel width (adjusts)
% C = 50;                     % Regularization term
% Kernel function
K = @(X,Y) exp(-diag((X-Y)*(X-Y)')/(2*sigma^2));
% Initiate
a = zeros(mp,1);
b = 0;
sgrad_a = a;
sgrad_b = b;
mem.out = [];
mem.his = [Xt, Yt];
ep = 0;
while ep < epoch
    idx = randperm(n);
    Yt = Yt(idx); Xt = Xt(idx,:);
    for t = 1:n
        % Update multipliers
        Kt = K(XC,Xt(t,:));
        sgrad = (tanh(a'*(YC.*Kt)+b)-Yt(t))*(1-(tanh(a'*(YC.*Kt))^2));
        sgrad_a = sgrad_a + eta/(ep+1)*sgrad*(YC.*Kt);
        sgrad_b = sgrad_b + eta/(ep+1)*sgrad;
        a = exp(-sgrad_a - 1);
        b = exp(-sgrad_b - 1);
        % Project onto convex action space
        a = max(min(a,C),0);
        a(YC==1) = a(YC==1)*sum(a)/2./sum(a(YC==1));
        a(YC==-1) = a(YC==-1)*sum(a)/2./sum(a(YC==-1));
        if print
            fprintf('[%.1f %%] Iteration %.0f trained, %.0f outliers \n',100*(t+ep*n)/n/epoch,t+n*ep,size(mem.out,1))
        end
        % Adjust kernel width
        sigma = sigma + 10/n*(0.5-mean(Kt));
        K = @(X,Y) exp(-diag((X-Y)*(X-Y)')/(2*sigma^2));
        % Adjust learning rate
        mem.a(:,t+ep*n) = a;        % somehow need to fit this....
        mem.sig(t+ep*n) = sigma;
        mem.avgkt(t+ep*n) = mean(Kt);
    end
    ep = ep+1;
end
Yp = svm_predict(a,b,K,Xt,XC,YC);
predacc = sum(sign(Yp)==Yt)*100/n;
end


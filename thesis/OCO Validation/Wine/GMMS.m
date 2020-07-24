function [X,Y,sig] = GMMS(X,Y,k)
% Gaussian Mixture Model Selection, selects k datapoints that represent the
% datapoints best. As of now, label knowledge is not used. The outputted
% covariance can be used to calculate probability of a new datapoint
% belonging to one of the older representations. 
%
% Input         X       Data features
%               Y       Data labels
%               k       Fitted Gaussians
%
% Output        X       Feature representations
%               Y       Representation labels
%               sig     Covariance of representation

%% Initialization
global vis
Xs = X;                 % Store variables
k = k / 2;              % Selection per label
X = X(Y==1,:);          % Positive first
[n,m] = size(X);
figure
title('Determining optimal data representation')
%% GMM init
mu = X(linspace(1,k,k)',:);     % Initial means
for i = 1:n
    for j = 1:k
        t(j) = norm(mu(j,:)-X(i,:));
    end
    [~,l] = min(t);
    Z(i) = l;
end
sig = zeros(m,m,k);
for j = 1:k
    phi(j) = 1/n*sum(Z==j);
    for i = 1:n
        sig(:,:,j) = sig(:,:,j) + (Z(i) == j)/sum(Z==j) * (X(i,:) - mu(j,:))'* (X(i,:) - mu(j,:));
        sig(:,:,j) = diag(diag(sig(:,:,j)));
    end
end
%% EM Algorithm 
while(1)
    % E-step - Calculates probabilities of clusters
    for j = 1:k
        p(:,j) = diag(1/sqrt(det(2*pi*sig(:,:,j)))*exp(-1/2*((X-mu(j,:))/sig(:,:,j))*(X-mu(j,:))'));
    end
    w = p.*phi./sum(p*phi',2);
    % M-step - Updates cluster parameters
    sig = zeros(m,m,k);
    phi = 1/n * sum(w);
    mu_s = mu;
    mu = w'*X./sum(w)';    
    for j = 1:k
        sig(:,:,j) = (w(:,j).*(X-mu(j,:)))'*(X-mu(j,:))/sum(w(:,j));
        sig(:,:,j) = diag(diag(sig(:,:,j)));
    end
    %% VISUALIZATION
    if vis
        [~,Z] = max(w');
        hold off
        plotgaussian(X,Z',mu(1,:),sig(:,:,1));
        for j = 2:k
            plotgaussian(X,Z',mu(j,:),sig(:,:,j));
        end
        plot(mu(:,1),mu(:,2),'k*')
        legend off
        drawnow
        pause(0.5)
    end
    % Stopping criterion - (Cluster mean didn't change)
    if norm(mu_s-mu) < 2*k*1e-3
        break
    end
end
%% Switch class
Xp = mu;                % Store data (X)
sigp = sig;             % Covariance
Yp = ones(k,1);         % Labels
X = Xs(Y==-1,:);        % Load data
[n,m] = size(X);
clear sig p w t
%% GMM init
mu = X(linspace(1,k,k)',:);     % Initial means
for i = 1:n
    for j = 1:k
        t(j) = norm(mu(j,:)-X(i,:));
    end
    [~,l] = min(t);
    Z(i) = l;
end
sig = zeros(m,m,k);
for j = 1:k
    phi(j) = 1/n*sum(Z==j);
    for i = 1:n
        sig(:,:,j) = sig(:,:,j) + (Z(i) == j)/sum(Z==j) * (X(i,:) - mu(j,:))'* (X(i,:) - mu(j,:));
        sig(:,:,j) = diag(diag(sig(:,:,j)));
    end
end
%% EM Algorithm 
while(1)
    % E-step 
    for j = 1:k
        p(:,j) = diag(1/sqrt(det(2*pi*sig(:,:,j)))*exp(-1/2*((X-mu(j,:))/sig(:,:,j))*(X-mu(j,:))'));
    end
    w = p.*phi./sum(p*phi',2);
    % M-step
    sig = zeros(m,m,k);
    phi = 1/n * sum(w);
    mu_s = mu;
    mu = w'*X./sum(w)';    
    for j = 1:k
        sig(:,:,j) = (w(:,j).*(X-mu(j,:)))'*(X-mu(j,:))/sum(w(:,j));
        sig(:,:,j) = diag(diag(sig(:,:,j)));
    end
    %% VISUALIZATION
    if vis
        [~,Z] = max(w');
        hold off
        plotgaussian(X,Z',mu(1,:),sig(:,:,1));
        for j = 2:k
            plotgaussian(X,Z',mu(j,:),sig(:,:,j));
        end
        plot(mu(:,1),mu(:,2),'k*')
        legend off
        drawnow
        pause(0.5)
    end
    % Stopping criterion
    if norm(mu_s-mu) < 2*k*1e-3
        break
    end
end
%% Accumulate data
X = [Xp;mu];
temp = sig;
sig = zeros(m,m,2*k);
sig(:,:,k+1:end) = temp;
sig(:,:,1:k) = sigp; 
Y = [Yp;-ones(k,1)];
end


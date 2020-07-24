function [X,Y] = GMMS_I(X,Y,k)
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
fprintf('Finding best data representation\n\n')
global vis
if isempty(vis) 
    vis = 0
end

Xs = X;                 % Store variables
X = X(Y==1,:);          % Positive first
[n,m] = size(X);        % Input size
sig = eye(m)/k;         % Constraint covariance matrix
k = k / 2;              % Selection per label
if vis
    figure
    title('Determining optimal data representation')
end
%% GMM init
tic;
mu = X(linspace(1,k,k)',:);     % Initial means
for i = 1:n
    for j = 1:k
        t(j) = norm(mu(j,:)-X(i,:));
    end
    [~,l] = min(t);
    Z(i) = l;
end
for j = 1:k
    phi(j) = 1/n*sum(Z==j);
end
init_time = toc;
%% EM Algorithm 
while(1)
    % E-step - Calculates probabilities of clusters
    tic;
    for j = 1:k
        p(:,j) = diag(1/sqrt(det(2*pi*sig))*exp(-1/2*((X-mu(j,:))/sig)*(X-mu(j,:))'));
    end
    w = p.*phi./sum(p*phi',2);
    prob_t = toc;
    % M-step - Updates cluster parameters
    tic;
    phi = 1/n * sum(w);
    mu_s = mu;
    mu = w'*X./sum(w)';    
    mstep_t = toc;
    %% VISUALIZATION
    tic;
    if vis
        [~,Z] = max(w');
        hold off
        plotgaussian(X,Z',mu(1,:),sig);
        for j = 2:k
            plotgaussian(X,Z',mu(j,:),sig);
        end
        plot(mu(:,1),mu(:,2),'k*')
        legend off
        drawnow
        pause(0.5)
    end
    vis_t = toc;
    % Stopping criterion - (Cluster mean didn't change)
    if norm(mu_s-mu) < 2*k*1e-3
        break
    end
end
%% Switch class
Xp = mu;                % Store data (X)
Yp = ones(k,1);         % Labels
X = Xs(Y==-1,:);        % Load data
[n,m] = size(X);
clear p w t
%% GMM init
mu = X(linspace(1,k,k)',:);     % Initial means
for i = 1:n
    for j = 1:k
        t(j) = norm(mu(j,:)-X(i,:));
    end
    [~,l] = min(t);
    Z(i) = l;
end
for j = 1:k
    phi(j) = 1/n*sum(Z==j);
end
%% EM Algorithm 
while(1)
    % E-step 
    for j = 1:k
        p(:,j) = diag(1/sqrt(det(2*pi*sig))*exp(-1/2*((X-mu(j,:))/sig)*(X-mu(j,:))'));
    end
    w = p.*phi./sum(p*phi',2);
    % M-step
    phi = 1/n * sum(w);
    mu_s = mu;
    mu = w'*X./sum(w)'; 
    %% VISUALIZATION
    if vis
        [~,Z] = max(w');
        hold off
        plotgaussian(X,Z',mu(1,:),sig);
        for j = 2:k
            plotgaussian(X,Z',mu(j,:),sig);
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
Y = [Yp;-ones(k,1)];
end


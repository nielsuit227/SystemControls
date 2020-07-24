clear
close all
clc
%% Load and visualize data
load('Double_Gaussian_Large.mat')
K = 2;
%% K-means algorithm
% Preprocess
Y = X(:, 2);
X = X(:, 1);
%% Initial clusters
for n=1:K
    i = randi(length(X));
    j = randi(length(Y));
    Mu(n,:) = [X(i) Y(j)];
    Sig(:, :, n) = eye(2);
end
%%
plot(Mu(:,1),Mu(:,2),'kd')
C = zeros(1,length(X));
Z = C;
%%
% Max 15 iterations
for n=1:15
    hold off
    for i=1:length(X)
        t = [];
        for ii=1:K 
            % Determine cluster distance for each point to each cluster
            % t = [t; sqrt((Mu(ii,1)-X(i))^2+(Mu(ii,2)-Y(i))^2)];
            t = [t; exp(-1/2 * (Mu(ii, :) - [X(i), Y(i)]) / Sig(:, :, ii) * (Mu(ii, :) - [X(i), Y(i)])') ];
        end
        % Assign Clusters
        [~,C(i)] = max(t);
    end
    for i=1:K
        % Update cluster centers
        Mu(i,:) = [sum([C==i]'.*X)/sum(C==i),sum([C==i]'.*Y)/sum(C==i)];
        Sig(:, :, i) = 1 / sum(C == 1) * ([X, Y] - Mu(i, :))' * ([X, Y] - Mu(i, :));
        % And plot
        tx = [C==i]'.*X; tx(~any(tx,2),:) = [];
        ty = [C==i]'.*Y; ty(~any(ty,2),:) = [];
        plot(tx,ty,'o')
        hold on
    end
    plot(Mu(:,1),Mu(:,2),'R*')
    pause(1)
    if C == Z
        fprintf('Converged\n')
        break
    end
    Z = C;
end
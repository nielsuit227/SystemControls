%# generate data
clear
close all
clc
set(0, 'DefaultLineLineWidth', 2);
%% Parameters 
num = 250;
mu1 = [50 50];
mu2 = [75 50];
cov1 = [0.1 0.03; 0.03 0.25]; cov1 = 10*cov1/det(cov1);
cov2 = [0.1 0.1; 0.1 0.25]; cov2 = 10*cov2/det(cov2);
%% Checks
if ~issymmetric(cov1) || ~issymmetric(cov2)
    error('Covariance matrices need to be symmetric')
end
if det(cov1) < 0 || det(cov2) <0
    error('Covariance matrices need to be positive definite')
end
%% Data generation
X = [ mvnrnd(mu1, cov1, num/2) ; ...
      mvnrnd(mu2, cov2, num/2)   ];
G = [1*ones(num/2,1) ; 2*ones(num/2,1)];
Gt = G + round(rand(num,1));
gscatter(X(:,1), X(:,2), G,'br','oo')
axis equal, hold on
%% Plot data
for k=1:2
    %# indices of points in this group
    idx = ( G == k );

    %# substract mean
    Mu = mean( X(idx,:) );
    X0 = bsxfun(@minus, X(idx,:), Mu);

    %# eigen decomposition [sorted by eigen values]
    [V D] = eig( X0'*X0 ./ (sum(idx)-1) );     %#' cov(X0)
    [D order] = sort(diag(D), 'descend');
    D = diag(D);
    V = V(:, order);

    t = linspace(0,2*pi,100);
    e = [cos(t) ; sin(t)];        %# unit circle
    VV = 2*V*sqrt(D);               %# scale eigenvectors
    e = bsxfun(@plus, VV*e, Mu'); %#' project circle back to orig space

    %# plot cov and major/minor axes
    i = rand;
    plot(e(1,:), e(2,:), 'Color','k');
    %#quiver(Mu(1),Mu(2), VV(1,1),VV(2,1), 'Color','k')
    %#quiver(Mu(1),Mu(2), VV(1,2),VV(2,2), 'Color','k')
end
Y = G; Y(Y==2) = -1;
%% Shuffle data
Z = [X Y];
Z = Z(randperm(size(Z,1)),:);
%% Save data
Y = Z(:,3); 
X = Z(:,1:2);
save('data2.mat','X','Y')


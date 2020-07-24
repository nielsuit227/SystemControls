function [xr, oca, y] = ODAA_lin(data, param, oca, yprev)
% Load & extendOCA
if isfield(oca, 'centers')
    centers = oca.centers;
    labels = oca.labels;
    weights = oca.weights;
    p = oca.p;
    skipoca = 1;
else
    centers = data.X;
    labels = data.Y;
    weights = 1;
    p = 1;
    skipoca = 1;
end
% Load data & parameters
X = data.X;
Y = data.Y;
xr = param.xr;
c1 = param.c1;
c2 = param.c2;
a = param.a;
w = param.w;
beta = param.beta;
% Some more parameters
m = size(X, 2);
n = sum(weights);
p = size(centers, 1);
%% OCA 
if ~ismember(Y, labels) || all(sum((centers - X).^2, 1) >= w^2)
    centers = [centers; X];
    labels = [labels; Y];
    weights = [weights; 1];
    p = p + 1;
    yprev = [yprev; ones(1, m)];
elseif ~skipoca
    center_ind = sum((zeta - X).^2, 1) >= w^2;
    weights(center_ind) = weights(center_ind) + 1/sum(center_ind);   
end
oca.centers = centers;
oca.labels = labels;
oca.weights = weights;
oca.p = p;
%% Wasserstein 
if data.iter >= log(c1/beta) / c2
    eps = log(c1/beta)/(c2*a).^a;
else
    eps = log(c1/beta)/(c2*data.iter);
end
%% Gradient Direction (Ambiguity)
dhkr = labels * xr;
dhkr(labels.*centers*xr' >= 0, :) = 0;
[sx, sy] = find(abs(dhkr) == max(abs(dhkr)));
omega = zeros(p, m, length(sx));
for i=1:length(sx)
    omega(sx(i), sy(i), i) = n*eps*sign(dhkr(sx(i), sy(i)));
end
eta = 1/n*labels'*((omega(:,:, 1)-yprev)*xr');    
%% Vertex weights (Ambiguity)
omega(1:end, 1:end, size(omega, 3) + 1) = yprev;
st = zeros(size(omega, 3), 1);
for i=1:size(omega, 3)
   st(i) = 1/n*labels'*omega(:, :, i)*xr';
end
st = st / norm(st, 1);     %%% SUPER IMPORTANT NORM %%%
y = zeros(p, m);
for i=1:size(omega, 3)
    y = y + st(i) * omega(:, :, i);
end
%% Gradient Update (Decision)
grad = -1/n*(weights.*labels).*(centers - y./weights);
grad(labels.*(centers - y./weights)*xr' >= 1, :) = 0;
alpha = data.iter^(-1/2);
xr = xr - alpha*sum(grad, 1);
end
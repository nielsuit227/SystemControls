function [xr, oca, y] = ODAA_ker(data, param, oca, yprev)
% Load & extendOCA
if isfield(oca, 'centers')
    centers = oca.centers;
    labels = oca.labels;
    weights = oca.weights;
    p = oca.p;
    skipoca = 1;
    xr = param.xr;
else
    centers = data.X;
    labels = data.Y;
    weights = 1;
    p = 1;
    skipoca = 0;
    xr = rand;  
end
% Load data & parameters
X = data.X;
Y = data.Y;
c1 = param.c1;
c2 = param.c2;
a = param.a;
w = param.w;
sig = param.sig;
beta = param.beta;
m = size(X, 2);
persistent omega; if isempty(omega); omega = zeros(p, m); end
%% OCA 
if ~ismember(Y, labels) || all(sum((centers - X).^2, 2) >= w^2)
    centers = [centers; X];
    labels = [labels; Y];
    weights = [weights; 1];
    p = p + 1;
    yprev = [yprev; ones(1, m)];
    xr = [xr; rand];
elseif ~skipoca
    center_ind = sum((centers - X).^2, 2) <= w^2;
    weights(center_ind) = weights(center_ind) + 1/sum(center_ind);   
end
oca.centers = centers;
oca.labels = labels;
oca.weights = weights;
oca.p = p;
% Some more parameters
n = sum(weights);
p = size(centers, 1);
if p == 1
    y = zeros(1, m);
    return
end
%% Wasserstein
if data.iter >= log(c1/beta) / c2
    eps = log(c1/beta)/(c2*a).^a;
else
    eps = log(c1/beta)/(c2*data.iter);
end
%% Clean ambiguity
[po, ~, t] = size(omega);
omega = cat(1, omega, zeros(p-po, m, t));
omega = round(omega, 1);
if t > 30
    omega = omega(:, :, end-25:end);
end
%% Gradient Direction (Ambiguity)
G = gram(centers - yprev);
H = (weights.*labels*(xr.*labels)'+xr.*labels*(weights.*labels)')*G*(centers-yprev)/n/sig/sig;
[~, ind] = sort(vecnorm(H, 2, 2), 'descend');
t = size(omega, 3)+1;
omega(ind(1), :, t) = H(ind(1), :) / norm(H(1, :), 1);
%% Vertex weights
st = zeros(t, 1);
gamma = rand(t, 1);
gamma = gamma/norm(gamma,1);
l = 0;
while(1)
    l = l+1;
    if l > 25
        break
    end
    % Generate current ambiguity
    y = zeros(p, m);
    for z=1:t
        y = y + gamma(z)*omega(:,:,z);
    end
    % Normalize current ambiguity
    for k = 1:p
        y(k, :) = y(k, :) / weights(k);
    end
   % Calculate derivate of the weights
   st = zeros(t, 1);
   G = gram(centers-y);
    for i=1:t
        for k=1:p
            st(i) = st(i) - 1/n/sig/sig*weights(k)*labels(k)*(xr.*labels)'*G(:, k)*omega(k,:,i)*(centers(k, :) - y(k,:))';
        end
    end
    temp = max(0, gamma - st);
    if norm(temp, 1) > 1
        temp = temp/norm(temp,1);
    end
    if norm(temp-gamma, 2) < 1e-2
        break
    else
        gamma = temp;
    end
end
% Generate final ambiguity
y = zeros(p,m);
for z =1:t 
    y = y + gamma(z)*omega(:,:,z);
end
% Scale to weights (OCA)
for k =1:p 
    y(k, :) = y(k, :) / weights(k);
end
%% Gradient step
G = gram(centers-y);
grad = - labels.*G*(weights.*labels)/n;
alpha = data.iter^(-1/2);
xr = max(0, xr - alpha*grad);
sa = sum(xr);
xr(labels==1) = xr(labels==1)*sa/2/sum(xr(labels==1));
xr(labels==-1) = xr(labels==-1)*sa/2/sum(xr(labels==-1));


        function G = gram(data)
        % Pressumes data is samples x dimension. 
        [ng, mg] = size(data);
        G = zeros(ng, mg);
        for it=1:ng
            G(:, it) = kernel(data, data(it, :));
        end
        end              
        function Kij = kernel(x, y)
        % Pressumes row vector as inputs. X may be a matrix (samples x
        % dimension)
        Kij = exp(diag(-(x-y)*(x-y)'/2/sig/sig));
        end
end
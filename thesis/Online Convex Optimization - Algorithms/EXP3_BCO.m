%%% EXP3 is an exponential weighted algorithm for exploration and
%%% explotation that benefits an almost optimal regret bound, up to a
%%% factor 2sqrt(nlogn). Action is taken randomly by the weights which are
%%% updated in an exponential manner. Furthermore there is a egalitarianism
%%% factor which tunes the desire to pick an action uniformly, gamma.
% In this particular setting there are K discrete actions in an online
% setting with full information. 
clear
close all
clc
set(0,'DefaultLineLineWidth',2);            % Set linethickness for plots
%% Model parameters
% Online running length
T = 1000;
% Action space
K = 5;
% Egalitarianism factor (greedy factor)
eps = sqrt(log(K)/T/K);
% Adverserial
p = [0 1/5 1/5 0 0];%randi(10,1,K); 
p = p/sum(p);
Xt = mnrnd(1,p,T)';
[~,A] = max(Xt);
%% EXP3
% Initalization 
w = ones(K,T); 
Xes = zeros(K,T);
It = zeros(T,1);
BP = zeros(T,1);
r = zeros(T,1);
R = zeros(T,1);
% Loop
for i = 1:T-1
    P(:,i) = w(:,i)/sum(w(:,i));
    [~,It(i)] = max(mnrnd(1,P(:,i)));    
    % At this stage we play It and observe the loss
    if It(i) == A(i)
        z = ones(K,1); z(It(i)) = 0;
        Lh = 1/P(It(i),i)*z;
    else
        Lh = 0;
    end
    w(:,i+1) = w(:,i).*exp(-eps*Lh);
    % Rt = E[sum(A-It) - min_i sum(A-It)] = E[sum(It)-sum(I*)]
    r(i) = abs(linspace(1,K,K)*P(:,i) - linspace(1,K,K)*p');
    R(i+1) = R(i) + r(i);
end
%% Visualize results
% Plot loss
figure
plot(R)
hold on
y = @(x) 2*sqrt(x*K*log(K));    % Bound
fplot(y,[0,T])
title('Regret')
legend('Actual Regret', 'Regret Bound')
% Compare pdf's
fprintf('Original distribution and estimated distrubtion: \n It = 1; %.2f %.2f \n It = 2; %.2f %.2f \n It = 3; %.2f %.2f \n It = 4; %.2f %.2f \n It = 5; %.2f %.2f \n\n',p(1),P(1,end),p(2),P(2,end),p(3),P(3,end),p(4),P(4,end),p(5),P(5,end))
fprintf('Regret %.0f \n',sum(It ~= A'))
fprintf('Normalized regret %.3f \n',R(end)/2/sqrt(T*K*log(K)))



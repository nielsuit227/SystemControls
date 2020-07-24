clear
close all
clc
%% System
A = [0.9926 -0.5815;-0.0001 0.9931];
B = [-0.0407;-0.005];
C = [-0.4159 -0.5981];
D = 0.2128;

% A = [0.9867 -0.434 -0.1848; 0 1.0022 0.9991;0 0 0.997];
% B = [0.0453; 0.0002; 0];
% C = [-0.3702 -0.5350 0.5377];
% D = -0.2105;
z = size(A,1);
Ue = 0.5123 - 0.0098;
Ye = 0.7314-0.0019;
%% System check
obs =[];
con =[];
for n=1:z
    obs = [obs; C*A^(n-1)];
    con = [con A^(n-1)*B];
end
if rank(obs) ~= z
    error('System not Observable')
elseif rank(con) ~= z
    error('System not Controllable')
end
%% LQ settings
Q1 = 10000;
Q2 = 1;
Q3 = 1;
Q4 = 1;
Q5 = 1;
R = 4000000000000;
Q = [Q1 0 0 0 0;0 Q2 0 0 0;0 0 Q3 0 0;0 0 0 Q4 0; 0 0 0 0 Q5];
Q = Q(1:z,1:z);
%% LQ calculation
H = [A -B*R^-1*B'; -Q -A'];
[Ev, Dv] = eig(H);
[n,n] = size(A);
Z = [];
for j=1:2*n;
if real(Dv(j,j))<0;Z=[Z Ev(:,j)];end;
end;
T11=Z(1:n,:);T21=Z(n+1:2*n,:);
P=T21*T11^(-1);
F_lq = R^-1*B'*P
%% Linear Simulation LQ Optimal
% Settings
t = 0.2;
h = 0.001;
% Initials
u(1) = 0;
Xt(:,1) = [0.0032;0;0;0;0];
X(:,1) = Xt(1:z,1);
Y(1) = C*X(:,1) + u;
% Simulation
T(1) = 0;
for i=1:1:t/h
    X(:,i+1) = A*X(:,i) + B*u(i);
    Y(i+1) = C*X(:,i+1);
    if 1-Y(i+1)-Ye >= 1
        Y(i+1) = -Ye;
    elseif 1-Y(i+1)-Ye <= 0
        Y(i+1) = 1-Ye;
    end
    u(i+1) = -F_lq * X(:,i+1);
    if u(i+1)+Ue > 1
        u(i+1) = 1 - Ue;
    elseif u(i+1)+Ue<0
        u(i+1) = -Ue;
    end
    T(i+1) = T(i) + h;
end
% Plot
figure(1)
plot(T,X(1,:),'linewidth',2)
hold on
for n=2:z
    plot(T,X(z,:),'linewidth',2)
end
plot(T,1-Y-Ye,'linewidth',2)
plot(T,u+Ue)
legend('State 1','State 2','Output','Control Action')
title('LQ Optimal')
Y(1) + Ye
% %% Linear Simulation Poleplacement controller
% F_pp = [0.0411 -3.4828]*1e6;
% % Simulation
% sysLQ = ss(A-B*F_pp,B,zeros(size(A)),0);
% [Y,T,X] = lsim(sysLQ,U,T,X0);
% % Plot
% plot(T,X(:,1),'linewidth',2)
% plot(T,X(:,2),'linewidth',2)

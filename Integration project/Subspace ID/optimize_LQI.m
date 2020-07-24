clear
close all
clc
load('SS_f.mat')
Ye = 0.5;
Ue = 0.5591*Ye + 0.1005;
load('U_LPF1_Val.mat')
U = data.Data;
T = data.Time;
load('Y_LPF1_Val.mat')
Y = data.Data;
U_Val = U(10000:15000);
Y_Val = Y(10000:15000);
T_Val = T(10000:15000);
%% Asymptotic Observer
L = place(ss1.A',ss1.C',[0.8 .9])';
%% Optimizer
n = 100;
z1 = 0;
z2 = 3;
z = logspace(z1,z2,n);
for zz = 1:n
    
%% LQI controller
Q = [50 0 0;0 50 0; 0 0 1];
R = z(zz);
N = 0*ones(3,1);
[K,S,e] = lqi(ss(ss1),Q,R,N);
%% SIM
X_lqi = zeros(2,length(Y_Val));
X_lqi(:,1) = ss1.x0;
Y_lqi = zeros(length(Y_Val),1);
xi = zeros(length(Y_Val),1);
h = 0.001;
t = zeros(length(Y_Val)-1,1);
u = zeros(length(Y_Val)-1,1);
for n=1:length(U_Val)-1
    t(n+1) = t(n) + h;
    %% Using just the estimation
    a = 0.3;
    d = a*rand - 0.5*a;
    Y_lqi(n) = ss1.C*X_lqi(:,n)+d;
    xi(n+1) = xi(n) + h*Y_lqi(n);
    u(n+1) = -K*[X_lqi(:,n);xi(n)];
    X_lqi(:,n+1) = ss1.A*X_lqi(:,n)-ss1.B*min(max(0,K*[X_lqi(:,n);xi(n)]),1) +  L*(Y_Val(n) - Y_lqi(n));
end
Z(zz) = sum(Y_lqi.^2);
end
%% Results
figure
plot(t,Y_lqi+Ye)
title('Height')
axis([0 0.1 0 1])
figure
plot(t,u +Ue)
title('Control Action')
axis([0 0.1 0 1])


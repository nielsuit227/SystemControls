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
U_Val = U(10000:10100);
Y_Val = Y(10000:10100);
T_Val = T(10000:10100);
%% Asymptotic Observer
L = place(ss1.A',ss1.C',[0.8 .9])';
%% LQI controller
Q = [500 0 0;0 500 0; 0 0 10 ];
R = 50;
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
ufb = zeros(length(Y_Val)-1,1);
for n=1:length(U_Val)-1
    t(n+1) = t(n) + h;
    %% Using just the estimation
    a = 0.05;
    d = a*rand - 0.5*a;
    Y_lqi(n) = ss1.C*X_lqi(:,n)+d;
    xi(n+1) = xi(n) + h*Y_lqi(n);
    u(n+1) = min(max(0,Ue-K*[X_lqi(:,n);xi(n)]),1);
    ufb(n+1) = -K*[X_lqi(:,n);xi(n)];
    X_lqi(:,n+1) = ss1.A*X_lqi(:,n)-0*ss1.B*min(max(0,Ue+K*[X_lqi(:,n);xi(n)]),1) +  L*(Y_Val(n) - Y_lqi(n));
end
%% Results
figure
plot(t,Y_lqi,t,ufb)
figure
plot(t,Y_lqi+Ye)
title('Height')
axis([0 0.1 0 1])
figure
plot(t,ufb,t,ufb+Ue,t,u)
legend('Control output','plus Eq.','Saturated')
title('Control Action')


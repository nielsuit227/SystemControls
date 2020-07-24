clear
close all
clc
load('U.mat')
U = data.Data;
T = data.Time;
load('Y.mat')
Y = data.Data;
load('SS_f.mat')
U_val = U(40000:50000);
T_val = T(40000:50000);
Y_val = Y(40000:50000);
n = length(U_val);
%% Init
figure
Y_sim = lsim(ss1,U_val,T_val,ss1.x0);
plot(T_val,Y_sim)
hold on
plot(T_val,Y_val)
title('Fit on Identification Set')
%% Asymptotic Observer
L = place(ss1.A',ss1.C',[0.65+0.3*i 0.65-0.3*i])';
%% Validation5
load('U_LPF1_Val.mat')
U = data.Data;
T = data.Time;
load('Y_LPF1_Val.mat')
Y = data.Data;
U_Val = U(10000:15000);
Y_Val = Y(10000:15000);
T_Val = T(10000:15000);

load('SS_fail.mat')
T = time;
U_Val = U(5000:40000);
T_Val = linspace(5,40,35001);
Y_Val = Y(5000:40000);
Y_sim = lsim(ss1,U_Val,T_Val,ss1.x0);
figure
plot(T_Val,5*Y_sim)
hold on
plot(T_Val,5*Y_Val)
title('Fit on Validation Set')
%% Kalman filter
R = 0.3186e-3;  % Model Accuracy
Q = eye(2)*1.12315e-5;    % Measurement accuracy
S = zeros(2,1);
if rank([Q^(1/2) ss1.A*Q^(1/2)]) ~= 2
        error('System not reachable')
end
[P,L,Kkf] = dare(ss1.A',ss1.C',Q,R);


tau_M = 0.0173;
tau_E = 0.0023;
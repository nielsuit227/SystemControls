clear
close all
clc
%% Equilibrium
Ue = 0.4977;
Ye = 0.7313;
%% PID
Kp = 0.7;
Ki = 0.15;
Kp = 0.04;
%% plant
b = 1;
a2 = -1;
a1 = 50;
%% Adaptive
p = 0.9;
ms = [1 p 2*p];
G = [5000 500 500];
alpha = 1;
beta = 0.1;
t0 = [18 4 1];
clear
close all
clc

La = 0.002;
Ra = 0.05;
t_a = La/Ra;
Re = 2.15;
Ke = 220/50/pi;
J1 = 1.2;
Jl = 10;
J2 = 10000;
alpha = 0.005;
tau_u = 0.002;
%% speed controller
Kp_w = 10000000;
Ti_w = 0.01;

%% current controller
Kp_i = 0.22;
Ti_i = 5.4;

%% Thermal model
alphaA = 1000/80;
Pnoload = 500;
tau = 20*60;

%% Rope unit
m = 142.7;
r = 0.1;
g = 9.81;

%% Winding dynamics
Uf = 220;
Rf = 200;
Lf = 200;
t_f = Lf/Rf;
Gaf = 1.273;
i_f_0 = Uf/Rf;
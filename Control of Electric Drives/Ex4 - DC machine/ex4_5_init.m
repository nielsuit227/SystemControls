clear
close all
clc
%% Given Motor parameters
Gaf = 0.8858; % from torque and ia
Rf = 375; % Two equations
tf = 0.67;
Lf = tf / Rf;
If_0 = 4;
Uf = 1500;
Ra = 0.1442; % from Ia
ta = 0.034;
La = ta/Ra;
Ia_0 = 0;
Ia_rat = 204; % from power and voltage
Ia_ol = 3*Ia_rat;
Ua = 1500;

Rs_0 = 2.3068;
Rs_wm = 2.3068/415;

tdc = 0.01;
%% Mechanical parameters
Gr = 4.3;
Rw = 0.46;
Frol = 1650;
alpha = 12.87; % from force balance
Te_rat = 722.8;
Wm_rat = 415.0;
m = 110000;
%% speed controller
Kp_w = 1000;
Ti_w = 15;
Ti_w_lim = 50;
%% current controller
Kp_i = 1000;
Ti_i = 50;
Ti_i_lim = 1500;

V_set = 44;
I_set = 0;

Uf = 1500;
Rs_on = 0;
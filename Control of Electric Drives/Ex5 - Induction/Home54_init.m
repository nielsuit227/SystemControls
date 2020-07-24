clear
close all
%% System Parameters
% Mechanical
Tl = 10;
J = 0.5;
% Electrical
Isy_lim = 120;
Isx_lim = 120;
sigma = 0.0693;
L_s = 0.085;
tau_r = 0.283;
tau_r_m = tau_r;
tau_u = 0.0005;
p = 1;
R_R = 0.2792;
R_R_m = R_R;
Imax = 122.5;
%% Initials
rho0 = 1e-4;
L0 = 1e-4;
Wm0 = 0;
%% Controller
Kp_l = 2300;%12.6;
Ki_l = 8000;%45;
Llim = 100;
Kp_w = 320;%2000;
Ki_w = 24000;%2000;
Wlim = 100;
%% Setpoints
Wm_set = 0.1;
L_set = 0.816;
%% Simulation
runtime = 5;
warning off
sim('Home_5_4')

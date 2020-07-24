clear
clc
L_ssig = 3e-3;
L_rsig = 0.03e-3;
L_sm = 82e-3;
L_rm = 0.82e-3;
R_s = 0.3;
R_r = 3e-3;
J = 0.5;
p = 1;
T_L=0;

n_nom = 2910; %RPM
tau_u = 0.5e-3;
%% 3.10
R_R_prime = L_sm/L_rm*R_r;
L_Rsig_prime = L_sm/L_rm*L_rsig;
%% 3.11
L_s = L_ssig+L_sm;
L_r = L_rsig+L_rm;
M = sqrt(L_sm*L_rm);
sigma = 1-M^2/L_s/L_r;
R_R = (M/L_r)^2*R_r;
tau_r = L_r/R_r;
tau_sigma = sigma*L_s/(R_s+R_R);
%% question b
m = 60;
psi_R0 = 1e-6;
rho_0 = 0;
om_Kp = 0;
om_Ki = 0;
psi_Kp = 2300;
psi_Ki = psi_Kp/tau_r;
%% question c
psi_ref = 0.816;
omega_ref = 0.001;
T_L = 10;
psi_Kp = 2200;
psi_Ki = psi_Kp/tau_r;
t_l = 0.1;
om_Kp = 320;
om_Ki = 24000;
%% question d
psi_ref = 0.816;
psi_Kp = 2300;
psi_Ki = psi_Kp/tau_r;
om_Kp = 320;
om_Ki = 24000;
omega_ref = 300;
T_L = 0;
%% d, second half
T_L = 50;
t_l = 1.5;
%% e, warmer
R_r = 2.*R_r;
R_R = (M/L_r)^2*R_r;
tau_r = L_r/R_r;
tau_sigma = sigma*L_s/(R_s+R_R);
%% open loop, g
R_r = R_r./2;
R_R = (M/L_r)^2*R_r;
tau_r = L_r/R_r;
tau_sigma = sigma*L_s/(R_s+R_R);
omega_ref = 0;
psi_R0 = 1e-4;
psi_ref = 0.816;
%% i
T_L = 50;
t_l = 1.5;
omega_ref = 300;
tau_r_m = tau_r;
R_R_m = R_R;
R_r_m = R_r;
%% j
%don't check tau_r in inversed model
R_r_m = R_r*2;
R_R_m = (M/L_r)^2*R_r_m;
tau_r_m = L_r/R_r_m;
tau_sigma = sigma*L_s/(R_s+R_R_m);
omega_ref = 300;
psi_R0 = 1e-4;
psi_ref = 0.816;
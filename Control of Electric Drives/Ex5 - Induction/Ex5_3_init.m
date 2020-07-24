clear
close all
clc
%% System Parameters
% Mechanical
m = 40;
r = 0.1;
g = 9.81;
J = 0.05;
% Electrical
Us = 220*sqrt(2); Us_rat = Us;
U0 = 22;
Ws_rat = 50*2*pi;
ws = 50; 
ws = ws*2*pi; 
L_s = 0.085;
sigma = 0.0693;
tau_sigma = 0.0102;
tau_r = 0.283;
i_smn0 = zeros(2,1);
psi_Rmn0 = zeros(2,1);
p = 1;
Wk = 50*2*pi;
% Controller
Kp = 120;
Ki = 1;
Kd = 1;
Wslip_max = 49;
runtime = 10;

tic;
sim('Ex5_3')
toc;
%% G)
R_s = 0.3;
R_r = 0.003;
M = 0.0082;
L_r = 0.00085;
figure
Ws = 20*pi:20*pi:50*pi*2;
for n=1:length(Ws)
Us = Us_rat/Ws_rat * Ws(n);
ws = Ws(n);
wm_t = (-ws:ws/100:2*ws)';
Wslip = ws - p*wm_t;
Is = (Us./(R_s+1i*ws*L_s+M^2*Wslip*ws./(R_r+1i*Wslip*L_r)));
Te = 3/2*p*(1-sigma)*L_s*abs(Is).^2 ./ (R_r./(L_r*Wslip) + Wslip*L_r/R_r);
hold on
plot(wm_t,Te)
axis([wm_t(1) wm_t(end) -250 125])
drawnow
end
%%
R_s = 0;
ws = 50*2*pi;
wm_t = (-ws:ws/100:2*ws)';
Us = Us_rat/Ws_rat * ws;    
Wslip = ws - p*wm_t;
Is = (Us./(R_s+1i*ws*L_s+M^2*Wslip*ws./(R_r+1i*Wslip*L_r)));
Ter = 3/2*p*(1-sigma)*L_s*abs(Is).^2 ./ (R_r./(L_r*Wslip) + Wslip*L_r/R_r);
hold on
plot(wm_t,Ter)
%%
legend('Ws = 62.8','Ws = 125.7','Ws = 188.5','Ws = 251.3','Ws =314.2','R_s = 0')
xlabel('Wm [rad/s]')
ylabel('Te [Nm]')
title('Torque curves for different supply frequencies')
%% H)
R_s = 0.3;
Ws = 25*pi*2;
Us0 = Us_rat/Ws_rat *Ws;
Us1 = (Us_rat-22)/Ws_rat*Ws + 22;
Is0 = (Us0./(R_s+1i*ws*L_s+M^2*Wslip*ws./(R_r+1i*Wslip*L_r)));
Te0 = 3/2*p*(1-sigma)*L_s*abs(Is0).^2 ./ (R_r./(L_r*Wslip) + Wslip*L_r/R_r);
Is1 = (Us1./(R_s+1i*ws*L_s+M^2*Wslip*ws./(R_r+1i*Wslip*L_r)));
Te1 = 3/2*p*(1-sigma)*L_s*abs(Is1).^2 ./ (R_r./(L_r*Wslip) + Wslip*L_r/R_r);
figure
plot(wm_t,Te0,wm_t,Te1)
legend('Original Formula','New Formula')
title('Torque curves at W_s=25Hz')
xlabel('Wm [rad/s]')
ylabel('Te [Nm]')
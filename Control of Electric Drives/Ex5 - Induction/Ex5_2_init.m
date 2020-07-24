clear
close all
clc
%% System Parameters
% Induction Machine
L_s = 0.085;
L_r = 0.085;
M = 0.082;
Lsm = M;
R_s = 0.3;
R_r = 0.3;
J = 0.05;
wm_rat = 2910/60*2*pi;
p_rat = 12e3;
ws = 50*2*pi;
p = 1;
Uphase = 220;
Us = sqrt(2)*Uphase;
Ur = 0;
sigma = 1 - M^2/(L_s*L_r);
%% Speed setting
wm = 2910/60*2*pi;% 0:0.01:ws;
%% Stator/Rotor Current Calculation
Wslip = ws - p*wm;
I_s = (Us./(R_s+1i.*ws.*L_s+M^2.*Wslip.*ws./(R_r+1i.*Wslip.*L_r))); 
I_r = j.*(p.*wm.*M.*I_s-ws.*M.*I_s)./(R_r+j.*(ws.*L_r-p.*wm.*L_r));

I_s_al_bet0 = [real(I_s);imag(I_s)];
I_r_al_bet0 = [real(I_r);imag(I_r)];

L_s_al_bet0 = [L_s*real(I_s)+M*real(I_r); L_s*imag(I_s)+M*imag(I_r)];
L_r_al_bet0 = [M*real(I_s) + L_r*real(I_r); M*imag(I_s)+L_r*imag(I_r)];
%% Setting stuff to zero
% I_s_al_bet0 = zeros(2,1);%[real(I_s);imag(I_s)];
% I_r_al_bet0 = zeros(2,1);%[real(I_r);imag(I_r)];
% L_s_al_bet0 = zeros(2,1);%[L_s*real(I_s)+M*real(I_r); L_s*imag(I_s)+M*imag(I_r)];
% L_r_al_bet0 = zeros(2,1);%[M*real(I_s) + L_r*real(I_r); M*imag(I_s)+L_r*imag(I_r)];

I_angle = (angle(I_s) - angle(I_r))*360/2/pi;
s_angle = (angle(Us) - angle(I_s))*360/2/pi;
%% 5.2 A, steady state analysis
% Currents are calculated by voltage equations. (after 3.27)
% Torque using form. 3.34
% Max torque
wm_t = (-ws:ws/100:2*ws)';
Wslip = ws - p*wm_t;
Is = (Us./(R_s+1i*ws*L_s+M^2*Wslip*ws./(R_r+1i*Wslip*L_r)));
Te = 3/2*p*(1-sigma)*L_s*abs(Is).^2 ./ (R_r./(L_r*Wslip) + Wslip*L_r/R_r);
[maxTe,ind] = max(Te);
wmax = wm_t(ind);
%% Output
fprintf('Stator Current (mag): %.3f A\n',abs(I_s))
fprintf('Rotor Current (mag): %.3f A\n',abs(I_r))
fprintf('Angle I_s / I_r: %.3f degrees \n',I_angle)
fprintf('Angle Us / I_s: %.3f degrees \n',s_angle)
%% Plots
% figure
% plot([0 real(Us)],[0 imag(Us)]);
% hold on
% plot([0 real(I_s)],[0 imag(I_s)],'r')
% legend('Stator Voltage','Stator Current')
% xlabel('Real  [A]')
% ylabel('Imaginiary [A]')
% title('Stator Voltage and Current Phasor')
% axis([-300 300 -300 300])
% figure
% plot([0 real(I_s)],[0 imag(I_s)],'r')
% hold on
% plot([0 real(I_r)],[0 imag(I_r)],'b')
% legend('Stator Current','Rotor Current')
% xlabel('Real  [A]')
% ylabel('Imaginiary [A]')
% title('Stator and Rotor Current Phasor')
% axis([-300 300 -300 300])
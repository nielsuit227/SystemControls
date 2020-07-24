%%% Example of a PI controller as proposed by Ziegler and Nichols in 1945.
%%% In general a way to get easy control, although not very robust. 
clear
close all
clc
opts = bodeoptions('cstprefs');
opts.PhaseWrapping = 'on';
%% Example Plant
G = tf([-6 3],[50 15 1]);
% Bode plot gives 0.4 rad/s as frequency where the plant reaches -180
% degrees.
Wu = 0.4; %[rad/s]
[m,p] = bode(G,0.4);
Ku = 1/m;
Kc = Ku/2.2;
Pu = 2*pi/Wu;
ti = Pu/1.2;
K = tf([Kc]) + tf([1],[ti 0]);
%% Analyse controller
step(K*G/(1+K*G))
title('Step Response Ziegler&Nichols PI controller')
figure
bode(K*G/(1+K*G),opts)
hold on
bode(1/(1+K*G),opts)
bode(K*G)
legend('Complementary Sensitivity [T]','Sensitivity [S]','Loop Gain [L]')
title('Ziegler&Nichols PI controller')


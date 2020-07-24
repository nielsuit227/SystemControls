%%% Just for the step response of question 7
close all
clc
clear
%% constants
J1 = 0.1;      % [kgm^2]
J2 = 0.1;      % [kgm^2]
k=0;           % [N/m] verkeerde units...
b1 = 0;        % [Nms/rad]
b2 = 0;        % [Nms/rad]
%% Gains
Kp = 11.1303;
Kv = 0.8893;
%% Transfer functions
C = tf([Kp]) + tf([Kv*140*pi 0],[1 140*pi]);
G = tf([J2 b2 k],[J1*J2 b1*J2+b2*J1 b2*b1+(J1+J2)*k  (b1+b2)*k 0]);
OL = C*G;
CL = C*G/(1+C*G);
%% Bode plots
opts = bodeoptions;
opts.FreqUnits = 'Hz';
figure
bode(OL,opts)
title('Open Loop')
figure
[x,y]=step(CL)
title('Closed Loop step response')
data = stepinfo(x,y,1);
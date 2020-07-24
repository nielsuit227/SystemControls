clc
close all
clear
%% constants
J1 = 0.1;        % [kgm^2]
J2 = 0.1;       % [kgm^2]
k=0;              % [N/m] verkeerde units...
b1 = 0;        % [Nms/rad]
b2 = 0;        % [Nms/rad]

%% Gain calculation
f = 10;
w = 2 * f * pi;
Kp = w * w / 10 * (0.5 * sqrt(2) - ((140*pi)/(140*140*pi*pi)))
Kv = 0.5 * sqrt(2) * (w^3 + 140 * 140 * pi * pi * w) / (1400 * 140 * pi * pi)

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
step(CL)
[x,y]=step(CL);
title('Closed Loop step response')
data = stepinfo(x,y,1);

%% Margins
[Mag,Phase,Wout] = bode(OL,w);
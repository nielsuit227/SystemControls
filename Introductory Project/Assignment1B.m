%% Assignment 1B, 11/09/2017
close all
clc
clear
%% constants
J1 = 1.2e-3;        % [kgm^2]
J2 = 5.45e-4;       % [kgm^2]
k=0.9;              % [N/m] verkeerde units...
b1 = 1.5e-2;        % [Nms/rad]
b2 = 1.5e-3;        % [Nms/rad]
%% Gains
Kp = 1.9624;
Kv = 1/20;
%% Transfer functions
C = tf([Kp]) + tf([Kv*140*pi 0],[1 140*pi]);
G = tf([J2 b2 k],[J1*J2 b1*J2+b2*J1 b2*b1+(J1+J2)*k  (b1+b2)*k 0]);
%% Loop functions
OL = C*G;
CL = C*G / (1 + C*G);
%% Plant gain
w = 5*2*pi;
[PMag,PPhase,PWout] = bode(G,w);
PGain5Hz = 20*log10(PMag);
%% Desired controller gain
CGain_req = 10^(-PGain5Hz/20);
%% Controller gain
Cnew = tf([0.36341]) + tf([Kv*140*pi 0],[1 140*pi]);
[Mag,Phase,Wout] = bode(Cnew,w);
CGain5Hz = 20*log10(Mag);
%% System gain at 5 Hz
[Gain,PhaseMargin,c] = bode(OL,w);
System_Gain_5Hz = Gain
%% Plot poles
figure
hold on
nyquist(OL)
ReP = real(pole(OL));
ImP = imag(pole(OL));
ReZ = real(zero(OL));
ImZ = imag(zero(OL));
for n=1:length(ReP)
    plot(ReP(n),ImP(n),'*')
end
for n=1:length(ReZ)
    plot(ReZ(n),ImZ(n),'o')
end

%% Bode plots
opts = bodeoptions;
opts.FreqUnits = 'Hz';
figure
bode(OL,opts)
title('Open Loop')
figure
bode(G,opts)
title('Plant')
figure
bode(C,opts)
title('Controller')

%% Checking the influence of the two gains
figure
hold on
for n=1:4
    for m=1:4
        Kp = 2*n;
        Kv = 2*m;
        C(n,m) = tf([Kp]) + tf([Kv*140*pi 0],[1 140*pi]);
        G(n,m) = tf([J2 b2 k],[J1*J2 b1*J2+b2*J1 b2*b1+(J1+J2)*k  (b1+b2)*k 0]);
        CL = C(n,m)*G(n,m)/(1+C(n,m)*G(n,m))
        [x,y] = step(CL);
        data=stepinfo(x,y,1);
        Risetime(n) = data.RiseTime;
        Settlingtime(n) = data.SettlingTime;
        Overshoot(n) = data.Overshoot;
        fprintf('.')
        figure
        step(CL)
        str = sprintf('Kp = %.0f, Kv = %.0f',Kp,Kv)
        title(str)
    end
end
figure
hold on
for n =1:4
    for m=1:4
        Kp = 2*n;
        Kv = 2*m;
        C(n,m) = tf([Kp]) + tf([Kv*140*pi 0],[1 140*pi]);
        G(n,m) = tf([J2 b2 k],[J1*J2 b1*J2+b2*J1 b2*b1+(J1+J2)*k  (b1+b2)*k 0]);
        CL = C(n,m)*G(n,m)/(1+C(n,m)*G(n,m))
        figure
        bode(CL)
        str = sprintf('Kp = %.0f, Kv = %.0f',Kp,Kv);
        title(str)
    end
end
        

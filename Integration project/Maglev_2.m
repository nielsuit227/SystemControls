clear
close all
clc
%% ADC
Kda = 10;       % ADC Gain
u0 = 0;         % ADC offset
%% Coil
Kam = 100;      % amplifier gain
Ks = 13.33;     % current sensor gain
Rs = 0.25;      % resistor feedback gain
Rc = 3.5;       % coil resistance
Lc = 0.03;      % coil inductance
%% Ball
mk = 8.37e-3;   % Mass ball
Kf = 0.653e-6;  % coil/amplifier constant
Kfv = 0.02;     % Damping coefficient
Kdl = 34;       % Damping limit force
Kel = 33e4;     % Elastic limit force
g = 9.81;       % Gravitation constant
x0 = 9.02e-3;   % distance min/max pos
L = 6.3e-3;     % Max position
%% Sensor
Kx = 10;        % position sensor gain
y0 = 0.054;     % position sensor offset
Kad = 0.2;      % ADC gain
ymu0 = 0;       % ADC offset
clear
close all
clc
load('FLoatingWindTurbine.mat');
G = ss(A,B,C,D);
G11 = -G(1,1);
%% Controller Parameters
Kp = 1;             % Proportional gain
Ti = 1;             % Integral gain
Td = 0;             % Derivative gain
b1 = 0.2;              % Notch damping 1
b2 = 0.7;              % Notch damping 2
w = 0.25;               % Notch frequency
%% Controller
s = tf('s');                                        % Derivative
PID = Kp*(1 + Ti*(1/s) + Td*s);                     % PID filter
notch = tf([1 2*w*b1 w^2],[1 2*w*b2 w^2]);          % Notch filter
K = ss(PID*notch);                                  % Combined controller
%% Bode's
opts = bodeoptions;
opts.FreqUnits = 'Hz';
figure
bode(G11,opts)
hold on
bode(K,opts)
bode(K*G11,opts)
legend('SISO Plant (b->w)','Controller','Open loop controller')
%% New bode
w = logspace (-4,4 ,1000)';
Nw = length (w) ;
[re , im] = nyquist(K*G11,w) ;
re = reshape(re,Nw,1);
im = reshape(im,Nw,1);
mg11 = 20*log10(sqrt(re.^2+im.^2));
pg11 = 180*phase(re+j*im)/pi ;
figure; clf;
subplot(2,1,1);
semilogx(w,mg11,'linewidth',2); grid;
ylabel('|\cdot|');legend('|G {11}|');
subplot(2,1,2);
semilogx(w,pg11,'linewidth',2); grid;
legend('\phi(-G {11})');
xlabel('\omega[rad/s]'); ylabel('\phi(\cdot)');
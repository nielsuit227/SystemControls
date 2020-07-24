clear
close all
clc
%% Plant
P = tf([0.2128 -0.8279 1.207 -0.7818 0.1898],[1 -3.971 5.915 -3.915 0.9717]);
figure
bode(P)
%% Controller
C = pid(1.9,7,-0.1);
lpf = tf([1],[1 10]);
figure
bode(lpf*C*P)

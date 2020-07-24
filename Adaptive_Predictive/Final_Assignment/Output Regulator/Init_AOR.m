5%% Init
clear 
close all
clc
%% Exosystem
w1 = 10;
w2 = 5;
S = [0 w1 0 0;-w1 0 0 0;0 0 0 w2;0 0 -w2 0];    % nxn
S0 = zeros(4,4);
R = [1 0 0 0];                              % 1xn
V0 = [1 0 1 0]';                            % nx1
n = size(S,1);                              % Order Exosystem
%% System
A = [3 1;-1 0];
B = [1;1];
C = [1 0];
D = 0;
F = -R;                                     % 1xn
E = zeros(2,4);                             % 2xn
C = [1 0];                                  % 1x2
Al = [1;0];                                 % 2x1
%% Adaptive controller
m = 1;
beta = 1;
G = [750 2500 5 100];
p = 0.09;
L = [1 2*p p];                          %% SPI Filter
t0 = ones(4,1);%[2.5;-1.5;1.5;0.5];     %% Initial parameter estimation

As = [20,60];                           %% Observer poles
X0 = ones(2,1);                         %% Initial State

P = [-2, -6];                           %% Regulator poles
mu = 100;                               %% Regulator gain
Z0 = ones(3*n,1);                       %% Initial Regulator

%% Distributed Observer
Mu_S = 10;
Mu_n = 100000;
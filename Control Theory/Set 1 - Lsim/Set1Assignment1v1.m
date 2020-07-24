%%% Script for state space representation assignment. See the step response
%%% of a square wave with period 75 and amplitude 1. State Space model is
%%% given by the assignment. 
clear
close all
clc
%% State Space model
A = [-2,-4,-6;1,0,0;0,1,0];
B = [1;0;0];
C = [0,0,1];
D = 0;
sys = ss(A,B,C,D);
%% Initial conditions
x(:,1) = [0;0;0];
y(1) = 0;
%% Square wave
time = 100;
samples = 10000;
dt = time/samples;
t = linspace(0,time,samples);
u = zeros(1,samples);
u(1,:) = square(t*2*pi/75,50);
%% Loop
% for n=1:length(t-1)
%     x(:,n+1) = (A*x(:,n) + B*u(n));
%     y(n) = C*x(:,n) + D*u(n);
% end
[y2,T,X] = lsim(sys,u,t);
%% plot
figure
plot(t,u)
hold on
plot(t,y2)
% figure
% plot(t,u)
% hold on
% plot(t,y)
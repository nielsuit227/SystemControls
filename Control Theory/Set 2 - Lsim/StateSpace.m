%%% Script for state space representation assignment. See the step response
%%% of a square wave with period 75 and amplitude 1. State Space model is
%%% given by the assignment. 
clear
close all
clc
%% State Space model
A = [-1,0,0;0,0,0;-1,1,0];
B = [1;0;0];
C = [0,0,1];
D = 0;
sys = ss(A,B,C,D);
%% Initial conditions
X(:,1) = [100;0;0];
y(1) = 0;
%% Input system
Time = 100;
Hz = 10;
samples = Time*Hz;
t = linspace(0,Time,samples);
u = zeros(1,samples);
%% System
[y2,T,X] = lsim(sys,u,t,X);
%% Plotting
figure
plot(t,X(:,1),'g',t,X(:,2),'b',t,X(:,3),'r')